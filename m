From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/11] ACPI: update debug parameter documentation
Date: Thu, 06 Nov 2008 15:29:16 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811061502100.3106@localhost.localdomain>
References: <20081105231710.26131.3110.stgit@bob.kio>
 <20081105231737.26131.62046.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:43340 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYKFUcW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 15:32:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9X00CIOI8U5250@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 14:29:24 -0600 (CST)
In-reply-to: <20081105231737.26131.62046.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Renninger <trenn@suse.de>



On Wed, 5 Nov 2008, Bjorn Helgaas wrote:

> Fix the init, debug, info level definitions, which changed recently.
> 
> Reformat acpi.debug_layer and acpi.debug_level documentation so it's
> more readable, add some clues about how to figure out the mask bits that
> enable a specific ACPI_DEBUG_PRINT statement, and include some useful
> examples.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  Documentation/kernel-parameters.txt |   98 ++++++++++++++++++++++-------------
>  drivers/acpi/Kconfig                |   12 +++-
>  2 files changed, 70 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 1bbcaa8..ddc791e 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -198,42 +198,69 @@ and is between 256 and 4096 characters. It is defined in the file
>  			that require a timer override, but don't have
>  			HPET
>  
> -	acpi.debug_layer=	[HW,ACPI]
> +	acpi.debug_*=	[HW,ACPI,ACPI_DEBUG]
> +			CONFIG_ACPI_DEBUG must be enabled to produce any ACPI
> +			debug output.  The type and amount of output is
> +			controlled by debug_layer and debug_level parameters,
> +			which can be in decimal or hex (prefixed with "0x").
> +			Some values produce so much output that the system is
> +			unusable.  The "log_buf_len" parameter may be useful
> +			if you need to capture more output.
> +
> +			To see AML "Debug" output (stores to the Debug object
> +			while interpreting AML (this is enabled by default)):
> +			    acpi.debug_layer=0xffffffff acpi.debug_level=0x2
> +			For debugging PCI/_PRT issues (PCI, info msgs):
> +			    acpi.debug_layer=0x400000 acpi.debug_level=0x4
> +			For ACPI hardware issues (hardware, all msgs):
> +			    acpi.debug_layer=0x2 acpi.debug_level=0xffffffff

i like it.

> +
> +	    acpi.debug_layer=	[HW,ACPI,ACPI_DEBUG]
>  			Format: <int>
> -			Each bit of the <int> indicates an ACPI debug layer,
> -			1: enable, 0: disable. It is useful for boot time
> -			debugging. After system has booted up, it can be set
> -			via /sys/module/acpi/parameters/debug_layer.
> -			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
> -			Available bits (add the numbers together) to enable debug output
> -			for specific parts of the ACPI subsystem:
> -			0x01 utilities 0x02 hardware 0x04 events 0x08 tables
> -			0x10 namespace 0x20 parser 0x40 dispatcher
> -			0x80 executer 0x100 resources 0x200 acpica debugger
> -			0x400 os services 0x800 acpica disassembler.
> -			The number can be in decimal or prefixed with 0x in hex.
> -			Warning: Many of these options can produce a lot of
> -			output and make your system unusable. Be very careful.
> -
> -	acpi.debug_level=	[HW,ACPI]
> +			Bits in <int> correspond to _COMPONENT definitions in
> +			ACPI source files.  After boot, this mask can changed
> +			on the fly, e.g., 
> +			    echo 0x2 > /sys/module/acpi/parameters/debug_layer
> +			The contents of debug_layer show the names of all the
> +			defined bits and their current state.
> +
> +			The following are some of the global components
> +			defined by the ACPI CA and the Linux OSPM:
> +				0x01 utilities
> +				0x02 hardware
> +				0x04 events
> +				0x08 tables
> +				0x10 namespace
> +				0x20 parser
> +				0x40 dispatcher
> +				0x80 executer
> +			       0x100 resources
> +			       0x200 ACPI CA debugger
> +			       0x400 OS services
> +			       0x800 ACPI CA disassembler
> +			     0x40000 battery
> +			     0x80000 button
> +			    0x200000 fan
> +			    0x400000 PCI
> +			  0x10000000 bay

The (always current) bit definitions can always be had this way:

$ cat /sys/module/acpi/parameters/debug_layer
Description              	Hex        SET
ACPI_UTILITIES           	0x00000001 [*]
ACPI_HARDWARE            	0x00000002 [*]
ACPI_EVENTS              	0x00000004 [*]
ACPI_TABLES              	0x00000008 [*]
ACPI_NAMESPACE           	0x00000010 [*]
ACPI_PARSER              	0x00000020 [*]
ACPI_DISPATCHER          	0x00000040 [*]
ACPI_EXECUTER            	0x00000080 [*]
ACPI_RESOURCES           	0x00000100 [*]
ACPI_CA_DEBUGGER         	0x00000200 [*]
ACPI_OS_SERVICES         	0x00000400 [*]
ACPI_CA_DISASSEMBLER     	0x00000800 [*]
ACPI_COMPILER            	0x00001000 [*]
ACPI_TOOLS               	0x00002000 [*]
ACPI_ALL_DRIVERS         	0xFFFF0000 [*]

So I think just mentioning that is enough, rather than
reproducing it here.  However, I do think that highlighting
the driver bits would be good, since they're not included above.
bay isn't a good example, as it doesn't exist any more.

I think we've got the component definitions in the wrong place.

today we have

button.c
#define ACPI_BUTTON_COMPONENT		0x00080000
#define _COMPONENT		ACPI_BUTTON_COMPONENT

but this should really be

acoutput.h
#define ACPI_BUTTON_COMPONENT           0x00080000

button.c                
#define _COMPONENT              ACPI_BUTTON_COMPONENT

and we should print all the driver bits in the module file,
not just ACPI_ALL_DRIVERS

> +
> +			Many others, e.g., ACPI_BUS_COMPONENT and
> +			ACPI_AC_COMPONENT, are defined by the Linux OSPM and
> +			individual drivers.
> +
> +	    acpi.debug_level=	[HW,ACPI,ACPI_DEBUG]
>  			Format: <int>
> -			Each bit of the <int> indicates an ACPI debug level,
> -			which corresponds to the level in an ACPI_DEBUG_PRINT
> -			statement.  After system has booted up, this mask
> -			can be set via /sys/module/acpi/parameters/debug_level.
> -
> -			CONFIG_ACPI_DEBUG must be enabled for this to produce
> -			any output.  The number can be in decimal or prefixed
> -			with 0x in hex.  Some of these options produce so much
> -			output that the system is unusable.
> -
> -			The following global components are defined by the
> -			ACPI CA:
> -			       0x01 error
> -			       0x02 warn
> -			       0x04 init
> -			       0x08 debug object
> -			       0x10 info
> +			Bits in <int> correspond to levels in ACPI_DEBUG_PRINT
> +			statements.  After boot, this mask can be changed on
> +			the fly, e.g.,
> +			    echo 0x2 > /sys/module/acpi/parameters/debug_level
> +			The contents of debug_level show the names of all the
> +			defined bits and their current state.
> +
> +			The following levels are defined by the ACPI CA:
> +			       0x01 init
> +			       0x02 debug (AML stores to the Debug object)
> +			       0x04 info
>  			       0x20 init names
>  			       0x40 parse
>  			       0x80 load
> @@ -248,9 +275,6 @@ and is between 256 and 4096 characters. It is defined in the file
>  			    0x10000 resources
>  			    0x20000 user requests
>  			    0x40000 package
> - 			The number can be in decimal or prefixed with 0x in hex.
> - 			Warning: Many of these options can produce a lot of
> - 			output and make your system unusable. Be very careful.

actually, we have more than that:

$ cat /sys/module/acpi/parameters/debug_level
Description              	Hex        SET
ACPI_LV_INIT             	0x00000001 [*]
ACPI_LV_DEBUG_OBJECT     	0x00000002 [*]
ACPI_LV_INFO             	0x00000004 [ ]
ACPI_LV_INIT_NAMES       	0x00000020 [ ]
ACPI_LV_PARSE            	0x00000040 [ ]
ACPI_LV_LOAD             	0x00000080 [ ]
ACPI_LV_DISPATCH         	0x00000100 [ ]
ACPI_LV_EXEC             	0x00000200 [ ]
ACPI_LV_NAMES            	0x00000400 [ ]
ACPI_LV_OPREGION         	0x00000800 [ ]
ACPI_LV_BFIELD           	0x00001000 [ ]
ACPI_LV_TABLES           	0x00002000 [ ]
ACPI_LV_VALUES           	0x00004000 [ ]
ACPI_LV_OBJECTS          	0x00008000 [ ]
ACPI_LV_RESOURCES        	0x00010000 [ ]
ACPI_LV_USER_REQUESTS    	0x00020000 [ ]
ACPI_LV_PACKAGE          	0x00040000 [ ]
ACPI_LV_ALLOCATIONS      	0x00100000 [ ]
ACPI_LV_FUNCTIONS        	0x00200000 [ ]
ACPI_LV_OPTIMIZATIONS    	0x00400000 [ ]
ACPI_LV_MUTEX            	0x01000000 [ ]
ACPI_LV_THREADS          	0x02000000 [ ]
ACPI_LV_IO               	0x04000000 [ ]
ACPI_LV_INTERRUPTS       	0x08000000 [ ]
ACPI_LV_AML_DISASSEMBLE  	0x10000000 [ ]
ACPI_LV_VERBOSE_INFO     	0x20000000 [ ]
ACPI_LV_FULL_TABLES      	0x40000000 [ ]
ACPI_LV_EVENTS           	0x80000000 [ ]

>  
>   	acpi.power_nocheck=	[HW,ACPI]
>   			Format: 1/0 enable/disable the check of power state.
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f4f6329..1c954a7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -312,9 +312,15 @@ config ACPI_DEBUG
>  	bool "Debug Statements"
>  	default n
>  	help
> -	  The ACPI driver can optionally report errors with a great deal
> -	  of verbosity. Saying Y enables these statements. This will increase
> -	  your kernel size by around 50K.
> +	  The ACPI subsystem can produce debug output.  Saying Y enables this
> +	  output and increases the kernel size by around 50K.
> +
> +	  Use the acpi.debug_layer and acpi.debug_level kernel command-line
> +	  parameters documented in Documentation/kernel-parameters.txt to
> +	  control the type and amount of debug output.
> +
> +	  When no parameters are supplied, the default settings cause AML
> +	  stores to the "Debug" object to produce console output.

I think Thomas may have changed this at SuSE b/c they ship
with CONFIG_ACPI_DEBUG=y, if so, maybe upstream should also?

thanks,
-Len

->  
>  config ACPI_DEBUG_FUNC_TRACE
>  	bool "Additionally enable ACPI function tracing"
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
