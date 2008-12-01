From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH] x86: create drivers/x86/ from drivers/misc/
Date: Mon, 01 Dec 2008 00:00:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811302338450.3314@localhost.localdomain>
References: <20081128213620.2ec593d4.sfr@canb.auug.org.au>
 <4930307C.30106@oracle.com> <20081129083550.3c23af37.sfr@canb.auug.org.au>
 <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain>
 <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain>
 <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain>
 <20081128223533.GA5175@uranus.ravnborg.org>
 <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
 <20081129073816.GB8351@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <20081129073816.GB8351@uranus.ravnborg.org>
Sender: linux-next-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On Sat, 29 Nov 2008, Sam Ravnborg wrote:

> Comments below in case we stick to this drivers/x86 thing...

now the "drivers/platform/x86/ thing"
aka the "get rid of drivers/misc/ thing":-)

> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 93224b5..b89db1e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1904,6 +1904,8 @@ source "drivers/Kconfig"
> >  
> >  source "drivers/firmware/Kconfig"
> >  
> > +source "drivers/x86/Kconfig"
> > +
> >  source "fs/Kconfig"
> 
> Any chance we can have this in drivers/Kconfig?
> 
> Just wrap all of the file in an
> 
> if X86
> .....
> endif
> 
> So we keep all the drivers/ stuff in one Kconfig file and
> not spread all over.

grep 'source "drivers"' arch/x86/Kconfig 

source "drivers/acpi/Kconfig"
source "drivers/cpuidle/Kconfig"
source "drivers/idle/Kconfig"
source "drivers/pci/pcie/Kconfig"
source "drivers/pci/Kconfig"
source "drivers/eisa/Kconfig"
source "drivers/mca/Kconfig"
source "drivers/pcmcia/Kconfig"
source "drivers/pci/hotplug/Kconfig"
source "drivers/Kconfig"
source "drivers/firmware/Kconfig"
source "drivers/x86/Kconfig"

Are the lines above a good example, a bad example,
or did I miss a nuance of the grand Kconfig design?

I really don't care one way or another, but there
seem to be examples of both ways...

> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index d1a47ad..a750519 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -171,6 +171,9 @@ ifeq ($(CONFIG_X86_32),y)
> >  drivers-$(CONFIG_FB) += arch/x86/video/
> >  endif
> >  
> > +# x86 platform-specific drivers
> > +drivers-y       += drivers/x86/
> > +
> 
> Can this be included in drivers/Makefile like this:
> 
> obj-$(CONFIG_X86) += x86/
> 
> Notice that parisc already do the same. (Yes they have
> a drivers/parisc dir).
> 
> We shall try to visit our tree in natural order when we build
> and such a rule breaks this.
> Also it is good to keep drivers/ stuff in one place.

sure, that sounds reasonable.

> > +++ b/drivers/x86/Kconfig
> > @@ -0,0 +1,290 @@
> > +#
> > +# X86 Platform Specific Drivers
> > +#
> > +
> > +menuconfig X86_PLATFORM_DEVICES
> > +	bool "X86 Platform devices"
> > +	default y
> > +	---help---
> > +	  Say Y here to get to see options for device drivers for various
> > +	  x86 platforms, including vendor-specific laptop extension drivers.
> > +	  This option alone does not add any kernel code.
> > +
> > +	  If you say N, all options in this submenu will be skipped and disabled.
> > +
> > +if X86_PLATFORM_DEVICES
> > +
> > +config ACER_WMI
> > +        tristate "Acer WMI Laptop Extras (EXPERIMENTAL)"
> spaces => tab
> 
> > +config ASUS_LAPTOP
> > +        tristate "Asus Laptop Extras (EXPERIMENTAL)"
> > +        depends on ACPI
> spaces => tab
> 
> > +config FUJITSU_LAPTOP
> > +        tristate "Fujitsu Laptop Extras"
> > +        depends on ACPI
> > +	depends on INPUT
> > +        depends on BACKLIGHT_CLASS_DEVICE
> > +        ---help---
> spaces => tab
> 
> > +config HP_WMI
> > +       tristate "HP WMI extras"
> > +       depends on ACPI_WMI
> > +       depends on INPUT
> > +       depends on RFKILL
> > +       help
> > +         Say Y here if you want to support WMI-based hotkeys on HP laptops and
> spaces => tab
> 
> > +	 to read data from WMI such as docking or ambient light sensor state.
> > +
> > +         To compile this driver as a module, choose M here: the module will
> > +         be called hp-wmi.
> > +
> > +config MSI_LAPTOP
> > +        tristate "MSI Laptop Extras"
> > +        depends on ACPI
> > +        depends on BACKLIGHT_CLASS_DEVICE
> > +        ---help---
> spaces => tab
> 
> > diff --git a/drivers/x86/Makefile b/drivers/x86/Makefile
> > new file mode 100644
> > index 0000000..4f14f28
> > --- /dev/null
> > +++ b/drivers/x86/Makefile
> > @@ -0,0 +1,17 @@
> > +#
> > +# x86 Platform-Specific Drivers
> > +#
> > +obj- := x86.o	# Dummy rule to force built-in.o to be made
> 
> This is not needed. I can see divers/misc uses the same
> but it is bogus.

Yes, all of this text came from the existing drivers/misc/
I'll fix it.

thanks,
-Len
