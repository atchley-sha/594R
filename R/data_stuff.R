library(tidyverse)
library(ggthemes)

costs <- readxl::read_xlsx("data/bus.xlsx", range = "A1:H25")

fullcosts <- costs %>% 
	mutate(
		"50L100B" = `50lanes` + `100bus`,
		"50L50B" = `50lanes`+ `50bus`,
		"50LXXB" = `50lanes` + `XXbus/yr`,
		"OPP100B" = XXopp + `100bus`,
		"OPP50B" = XXopp + `50bus`,
		"OPPXXB" = XXopp + `XXbus/yr`,
		"DCFC100B" = XXdcfc + `100bus`,
		"DCFC50B" = XXdcfc + `50bus`,
		"DCFCXXB" = XXdcfc + `XXbus/yr`
)

scenarios <- fullcosts %>% 
	select(-(`50lanes`:`XXbus/yr`), -which(str_detect(colnames(.), "DCFC"))) %>% 
	pivot_longer(-Year, names_to = "Ebus", values_to = "Cost") %>% 
	mutate(
		Scenario = case_when(
			str_detect(Ebus, "50L") ~ "Lanes",
			str_detect(Ebus, "OPP") ~ "Chargers",
			TRUE ~ "None"
		),
		Ebus = case_when(
			str_detect(Ebus, "100B") ~ "100%",
			str_detect(Ebus, "50B") ~ "50%",
			str_detect(Ebus, "XXB") ~ "Gradual",
			TRUE ~ "None"
		)
	)

scenarios %>% 
	filter(Scenario != "Chargers") %>% 
	ggplot(aes(x = Year, y = Cost, color = Ebus)) +
	annotate("rect", xmin = 10, xmax = 14, ymin = -Inf, ymax = Inf,
					 alpha = 0.2, fill = "red") +
	geom_line(linewidth = 1) +
	theme_pander() +
	lims(x = c(NA,20)) +
	labs(x = "Years of Operation",
			 y = "Cumulative Cost (USD)",
			 color = "BE Bus\nStrategy",
			 title = "Inductive Lanes")

ggsave("project/image/inductive_lanes.png",
			 width = 7,
			 height = 6,
			 units = "in")

scenarios %>% 
	filter(Scenario != "Lanes") %>% 
	ggplot(aes(x = Year, y = Cost, color = Ebus)) +
	annotate("rect", xmin = 10, xmax = 14, ymin = -Inf, ymax = Inf,
					 alpha = 0.2, fill = "red") +
	geom_line(linewidth = 1) +
	theme_pander() +
	lims(x = c(NA,20)) +
	labs(x = "Years of Operation",
			 y = "Cumulative Cost (USD)",
			 color = "BE Bus\nStrategy",
			 title = "Site Charging")

ggsave("project/image/site_charging.png",
			 width = 7,
			 height = 6,
			 units = "in")