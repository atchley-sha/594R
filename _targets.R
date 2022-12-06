# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed. # nolint
library(readr)

# Set target options:
tar_option_set(
  packages = c("tibble"), # packages that your targets need to run
  format = "rds" # default storage format
)


# Run the R scripts in the R/ folder with your custom functions:
tar_source()


data_targets <- tar_plan(
	tar_target(costfilebus, "data/bus.csv", format = "file"),
	costbus = read_csv(costfilebus),
	
	tar_target(costfilecharge, "data/charging.csv", format = "file"),
	costcharging = read_csv(costfilecharge),
	
	utabusmiles = 15842578,
	uvxmiles = 11,
	uvxfleet = 21,
	
)

analysis_targets <- tar_plan(
	
	
	
)

viz_targets <- tar_plan(
	
	
	
)


#### Run all targets ####

tar_plan(
	data_targets,
	analysis_targets,
	viz_targets
)