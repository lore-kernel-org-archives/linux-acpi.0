From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Detect mmconfig on nVidia MCP55
Date: Wed, 4 Feb 2009 18:04:40 +0100
Message-ID: <20090204170440.GA31973@elte.hu>
References: <1233765552.16414.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1233765552.16414.6.camel@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Ed Swierk <eswierk@aristanetworks.com> wrote:

> +static const char __init *pci_mmcfg_nvidia_mcp55(void)
> +{
> +	u32 extcfg;
> +
> +	raw_pci_ops->read(0, 0, PCI_DEVFN(0, 0), 0x90, 4, &extcfg);
> +
> +	if (!(extcfg & 0x80000000))
> +		return NULL;
> +	pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]), GFP_KERNEL);
> +	if (!pci_mmcfg_config)
> +		return NULL;
> +	pci_mmcfg_config[0].address = (extcfg & 0x00007fff) << 25;
> +	pci_mmcfg_config[0].pci_segment = 0;
> +	pci_mmcfg_config[0].start_bus_number = 0;
> +	pci_mmcfg_config[0].end_bus_number = (1 << (8 - ((extcfg >> 28) & 3))) - 1;
> +	pci_mmcfg_config_num = 1;
> +
> +	return "nVidia MCP55";

Looks good in principle, but here are a few code cleanliness observations:

1) Please introduce a helper variable to:

	struct acpi_mcfg_allocation *config;

   Which you can allocate, initialize - and then set pci_mmcfg_config to it. 
   Does not change the end result but makes the code structure cleaner and 
   shortens the lines.

2) Please use vertical spaces when initializing structure fields. Instead of 
   the messy looking (and over-long-line generating) construct of:

	pci_mmcfg_config[0].address = (extcfg & 0x00007fff) << 25;
	pci_mmcfg_config[0].pci_segment = 0;
	pci_mmcfg_config[0].start_bus_number = 0;
	pci_mmcfg_config[0].end_bus_number = (1 << (8 - ((extcfg >> 28) & 3))) - 1;
	pci_mmcfg_config_num = 1;

   You will get something like:

	config->address			= (extcfg & 0x00007fff) << 25;
	config->pci_segment		= 0;
	config->start_bus_number	= 0;
	config->end_bus_number		= (1 << (8 - ((extcfg >> 28) & 3)));

	pci_mmcfg_config = config;
	pci_mmcfg_config_num = 1;

   Which makes it more structured, more reviewable - and more pleasant to 
   look at as well.

3) Please use newlines in a more structured way, instead of:

	raw_pci_ops->read(0, 0, PCI_DEVFN(0, 0), 0x90, 4, &extcfg);

	if (!(extcfg & 0x80000000))
		return NULL;
	pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]), GFP_KERNEL);
	if (!pci_mmcfg_config)
		return NULL;
	pci_mmcfg_config[0].address = (extcfg & 0x00007fff) << 25;

   Do something like:

	raw_pci_ops->read(0, 0, PCI_DEVFN(0, 0), 0x90, 4, &extcfg);
	if (!(extcfg & 0x80000000))
		return NULL;

	config = kzalloc(sizeof(*config), GFP_KERNEL);
	if (!config)
		return NULL;

	config->address			= (extcfg & 0x00007fff) << 25;

   Note how the grouping of statements made the code flow really apparent 
   and straightforward, and made the returns and error conditions stand out.

4) Also, there's 6 magic constants in this patch:

      0x90, 4, 0x80000000, 0x00007fff, 28, 3

   Wherever you know already existing symbols for these in the PCI code 
   please use them - and where not, add a const u32 to introduce them.

   For example 0x80000000 means 'mmconf already enabled' - a suitable 
   symbol should be used. That way the code becomes self-explanatory at a 
   glance - even years down the line when everyone has forgotten what it's 
   all about.

   If a constant is very specific to the nVidia MCP55 chipset register 
   layout, you can define it straight before the pci_mmcfg_nvidia_mcp55() 
   function, no need to separate the definitions from the function by moving 
   it into some header file.

   Also, if possible and if it exists, add information (URLs if they exist) 
   about the chipset documentation that was the basis for this change.

5) Finally, some testing info and motivation-for-change info would be nice 
   as well. Which specific system/model encountered problems with 
   non-enabled mmconfig, and did it work well after you enabled it via this 
   chipset quirk?

Thanks!

	Ingo
