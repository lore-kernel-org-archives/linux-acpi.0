From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH 4/4]An ACPI callback for pci_set_power_state
Date: Wed, 05 Jan 2005 17:05:09 +0800
Message-ID: <1104915909.17388.9.camel@sli10-desk.sh.intel.com>
References: <1104893456.5550.135.camel@sli10-desk.sh.intel.com>
	 <20050105084954.GA5170@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050105084954.GA5170-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-01-05 at 16:49, Pavel Machek wrote:
> Hi!
> 
> > This is an ACPI callback for pci_set_power_state. Besides setting PCI
> > config space, changing device's power state sometimes requires to power
> > on device's power source and to invoke other firmware methods.
> 
> 
> > diff -puN drivers/pci/pci.h~acpi-pci-set-power-state-callback drivers/pci/pci.h
> > --- 2.5/drivers/pci/pci.h~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.469923128 +0800
> > +++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:58:06.473922520 +0800
> > @@ -13,6 +13,7 @@ extern int pci_bus_alloc_resource(struct
> >  				  void *alignf_data);
> >  /* Firmware callbacks */
> >  extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
> > +extern int (*platform_pci_set_power_state)(struct pci_dev *dev, int state);
> 
> What kind of state is passed here? Why is it u32 in one case and int
> in the second one?
This is the types of current pci routines (pci_set_power_state and pci_device_suspend). 
Both are PCI device states. I agree it's confused.

> I'm about to introduce separate types for pci power states and system
> power states; could you at least add comments which states are which?
> Also few lines of documentation would be very usefull...
I planed post the patches after your patches enter before, but it seems
have a long delay. What's your plan? I'm ok to merge the patches after
yours.

Thanks,
Shaohua



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
