From: Russell King <rmk-pci-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: pci bridge suspend/resume (Re: PCI not restored correctly after suspend to ram)
Date: Wed, 24 Mar 2004 09:07:47 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040324090746.A13095@flint.arm.linux.org.uk>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at> <1079761564.7274.730.camel@dhcppc4> <405C00C6.3010805@pobox.com> <20040320134542.GV25059@parcelfarce.linux.theplanet.co.uk> <20040320181000.GA8272@kroah.com> <20040322223425.GB3213@neo.rr.com> <20040324013557.GB21477@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040324013557.GB21477-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>; from greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org on Tue, Mar 23, 2004 at 05:35:57PM -0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org, "linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org" <linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 23, 2004 at 05:35:57PM -0800, Greg KH wrote:
> On Mon, Mar 22, 2004 at 10:34:25PM +0000, Adam Belay wrote:
> > > Yes, this will happen in 2.7 when we add the ability to have "generic"
> > > and "specific" type drivers for devices.
> > 
> > What do you think would be the best way to go about this?
> > 
> > I was able to come up with the following options:
> > 
> > 1.) flags in struct device_driver
> 
> I think this is the best place for it.  We will have to do something
> like weight the different ways to specify a driver can handle a device
> differently.  Something like this kind of priority:
> 	- device id
> 	- device class

The way I discussed with Pat two OLS's ago (I think it was two) was that
the bus type match method would return a value to indicate how well the
IDs matched the device.

When a driver matches a device, we remember this value, and call the
drivers ->probe function, as we do today.

However, when we add a new driver, we attempt to re-match all devices,
including those with drivers.  If a device with an existing driver is
found to have a "better" match with the new driver, the original driver's
->remove function is called to unbind the driver, and the new driver
bound to the device.

The match function would, for instance, return a lower value for a
device driver matching only the class IDs, a higher ID for a device
driver matching only the vendor ID, vendor ID + device ID, and the
highest value for vendor ID + device ID + class ID.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
