From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: pci bridge suspend/resume (Re: PCI not restored correctly after suspend to ram)
Date: Tue, 23 Mar 2004 17:35:57 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040324013557.GB21477@kroah.com>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at> <1079761564.7274.730.camel@dhcppc4> <405C00C6.3010805@pobox.com> <20040320134542.GV25059@parcelfarce.linux.theplanet.co.uk> <20040320181000.GA8272@kroah.com> <20040322223425.GB3213@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040322223425.GB3213-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org, "linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org" <linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 22, 2004 at 10:34:25PM +0000, Adam Belay wrote:
> > Yes, this will happen in 2.7 when we add the ability to have "generic"
> > and "specific" type drivers for devices.
> 
> What do you think would be the best way to go about this?
> 
> I was able to come up with the following options:
> 
> 1.) flags in struct device_driver

I think this is the best place for it.  We will have to do something
like weight the different ways to specify a driver can handle a device
differently.  Something like this kind of priority:
	- device id
	- device class

So if a driver matches a device by the id, it should be bound to it,
instead of a driver that can bind to id by the "class".

> 2.) return codes from (*match)
> 3.) a seperate bus specific function to evaluate driver priority

I think this will be necessary, as every bus will have different ways to
specify priority.

> Also how can we prevent the order in which drivers are loaded from
> determining which driver is bound?  It seems that we would need to
> delay device matching.

Or we can disconnect a driver from a device when a driver with a higher
"weight" comes into the system.

But I don't really know, I haven't given it all that much thought yet :)

thanks,

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
