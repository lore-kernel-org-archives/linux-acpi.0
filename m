From: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: Thu, 16 Sep 2004 03:57:43 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040916105743.GV20883@aero.ensim.com>
References: <1092807746.25902.155.camel@dhcppc4> <1092835382.11535.6.camel@sponge.fungus> <1092836298.25911.180.camel@dhcppc4> <20040810080826.GD28939@aero.ensim.com> <20040814211247.GS20883@aero.ensim.com> <20040817091921.GI20883@aero.ensim.com> <1092807697.25902.152.camel@dhcppc4> <B44D37711ED29844BEA67908EAF36F03860DC2@pdsmsx401.ccr.corp.intel.com> <20040810083807.GF28939@aero.ensim.com> <1092805762.25911.129.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1092836298.25911.180.camel@dhcppc4> <1092807697.25902.152.camel@dhcppc4> <1092805762.25911.129.camel@dhcppc4>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len,

Apologies for taking so long to reply.

On Wed, Aug 18, 2004 at 01:09:22AM -0400, Len Brown wrote:
> On Tue, 2004-08-10 at 04:38, Borislav Deianov wrote:
> > On Tue, Aug 10, 2004 at 04:24:39PM +0800, Li, Shaohua wrote:
> > >
> > > IBM hotkey has a unique ID. In T40, it's 'IBM0068'. I guess other
> > > IBM laptops also use it. Using a hardcode path in the patch possibly
> > > isn't a good idea.
> > 
> > Agreed. I was originally using acpi_bus_register_driver() and refering
> > to devices by HID but that turned out to not work very well for the
> > dock (ACPI drops it if it's not present at boot) and embedded
> > controller (the ec driver has already grabbed it). So I switched to
> > looking things up by the path. I see your point, though, I'll see what
> > I can do.
> 
> please stick with the HID method if you can.

I'd like to, but, for the most part, I can't. The two problems above
still stand: I need to access devices not present at boot time, and I
need to access devices already grabbed by other drivers. In addition,
I need to access devices and methods which just don't have
HIDs. Basically, out of the six features currently supported by
ibm-acpi, two can be done via acpi_bus_register_driver(). For the
other four, I need to call acpi_get_handle() (with several hard-coded
alternative paths). I use the latter method for all features,
simplifies the structure of the driver quite a bit.

Would you consider something like acpi_get_handle_by_hid() (which can
also access non-present devices)? That would help a lot.

On Wed, Aug 18, 2004 at 01:41:37AM -0400, Len Brown wrote:
> what's the GLOBAL_NOTIFY stuff about?
> 
>         status = acpi_install_notify_handler(ACPI_ROOT_OBJECT,
>                                              ACPI_DEVICE_NOTIFY,
>                                              global_notify, NULL);
> 

Used it for debugging before I figured out how to use
/proc/acpi/debug_*.  Got rid of it in 0.4.

On Wed, Aug 18, 2004 at 09:38:18AM -0400, Len Brown wrote:
> On Wed, 2004-08-18 at 09:23, Henrik Brix Andersen wrote:
> > On Wed, 2004-08-18 at 07:42, Len Brown wrote:
> > > #!/bin/bash
> > > 
> > > if ! /sbin/rmmod ipw2100; then
> > >         /sbin/service network restart
> > > fi
> > > 
> > > 
> > > Does this means that the button press magically changed
> > > the state of the radio in hardware?  I didn't see any
> > > processing inside the driver to do that.
> > 
> > No. The listed radio.sh script just unloads the ipw2100 module from
> > memory which effectively disables the wireless network connection.
> 
> So rather than actually disabling the radio, we're diabling the network
> by unloading the driver?  Is there an indicator light that says if the
> radio is enalbed?  Does is stay on?

The "antenna" LED goes off and power consumption goes down a bit, so I
assume unloading the module does turn off the radio. My laptop doesn't
have a software kill switch, so not much else I can do.

Regards,
Boris


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
