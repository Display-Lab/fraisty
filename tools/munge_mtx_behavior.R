# Process MTX rows into behavior data
args = commandArgs(trailingOnly=TRUE)

# Require file path argument
if(length(args) < 1){ stop("Missing mtx file path arg.", call.=F)  }

mtx_path <- args[1]
if(!file.exists(mtx_path)){ stop(mtx_path, " not found.", call.=F) }

library(dplyr)
library(readr)
library(lubridate)

# Read raw data
mtx_data <- readr::read_csv(mtx_path)

# Trim data to required fields
tdata <- mtx_data %>% 
  transmute(
    practice=as.factor(PRACTICE),
    bnf_code=as.factor(`BNF CODE`),
    num_scripts=as.integer(ITEMS),
    quantity=as.integer(QUANTITY),
    period=lubridate::parse_date_time(as.character(PERIOD), "%Y%m")
  )
  
# Calculate behavior data
behavior_data <- tdata %>%
  group_by(practice, period) %>%
  summarize(
    total_scripts = sum(num_scripts),
    total_quantity = sum(quantity),
    high_dose_scripts = sum(num_scripts[bnf_code == '1001030U0AAACAC']),
    high_dose_quantity = sum(quantity[bnf_code == '1001030U0AAACAC']))  %>%
  mutate( 
    hd_script_ratio = high_dose_scripts / total_scripts,
    hd_quantity_ratio = high_dose_quantity / total_quantity)

# Emit result to std out
write.csv(behavior_data, file="")
 