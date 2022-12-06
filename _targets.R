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
	tar_target(costsfile, "data/costs.csv", format = "file"),
	tar_target(fleetfile, "data/fleet.csv", format = "file"),
	tar_target(fuelfile, "data/fuel.csv", format = "file"),
	tar_target(lifespanfile, "data/lifespan.csv", format = "file"),
	tar_target(mofile, "data/mo.csv", format = "file"),
	
	costs = read_csv(costsfile),
	fleet = read_csv(fleetfile),
	fuel = read_csv(fuelfile),
	lifespan = read_csv(lifespanfile),
	mo = read_csv(mofile),
	
	utabusmiles = 15842578,
	
)

viz_targets <- tar_plan(
	
	
	
)


#### Run all targets ####

tar_plan(
	data_targets,
	viz_targets
)