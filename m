From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: pci bridge suspend/resume (Re: PCI not restored correctly
 after suspend to ram)
Date: Tue, 30 Mar 2004 22:03:35 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040330214941.L85074@root.org>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at>
 <1079761564.7274.730.camel@dhcppc4> <405C00C6.3010805@pobox.com>
 <20040320134542.GV25059@parcelfarce.linux.theplanet.co.uk>
 <20040320181000.GA8272@kroah.com> <20040322223425.GB3213@neo.rr.com>
 <20040324013557.GB21477@kroah.com> <20040324090746.A13095@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040324090746.A13095-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Russell King <rmk-pci-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org, "linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org" <linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 24 Mar 2004, Russell King wrote:
> The way I discussed with Pat two OLS's ago (I think it was two) was that
> the bus type match method would return a value to indicate how well the
> IDs matched the device.
>
> When a driver matches a device, we remember this value, and call the
> drivers ->probe function, as we do today.
>
> However, when we add a new driver, we attempt to re-match all devices,
> including those with drivers.  If a device with an existing driver is
> found to have a "better" match with the new driver, the original driver's
> ->remove function is called to unbind the driver, and the new driver
> bound to the device.

This can screw up devices that don't allow full shutdown (i.e. require
BIOS initialization).  A two-pass approach works better.  First pass
allows the driver to match an ID but not initialize anything.  Second
allocates resources like memory, IRQs, etc.

> The match function would, for instance, return a lower value for a
> device driver matching only the class IDs, a higher ID for a device
> driver matching only the vendor ID, vendor ID + device ID, and the
> highest value for vendor ID + device ID + class ID.

The driver's match method (first pass) returns a value for how well it
matches the hardware.  The underlying bus code sorts those values and
picks the winning driver to have its initialize routine called.

http://www.freebsd.org/cgi/man.cgi?query=DEVICE_PROBE&sektion=9&apropos=0&manpath=FreeBSD+5.2-RELEASE+and+Ports
http://www.freebsd.org/cgi/man.cgi?query=DEVICE_ATTACH&sektion=9&apropos=0&manpath=FreeBSD+5.2-RELEASE+and+Ports

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
