From: Russell King <rmk-pci-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: pci bridge suspend/resume (Re: PCI not restored correctly after suspend to ram)
Date: Wed, 31 Mar 2004 08:28:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040331082834.B27804@flint.arm.linux.org.uk>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at> <1079761564.7274.730.camel@dhcppc4> <405C00C6.3010805@pobox.com> <20040320134542.GV25059@parcelfarce.linux.theplanet.co.uk> <20040320181000.GA8272@kroah.com> <20040322223425.GB3213@neo.rr.com> <20040324013557.GB21477@kroah.com> <20040324090746.A13095@flint.arm.linux.org.uk> <20040330214941.L85074@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040330214941.L85074-Y6VGUYTwhu0@public.gmane.org>; from nate-Y6VGUYTwhu0@public.gmane.org on Tue, Mar 30, 2004 at 10:03:35PM -0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org, "linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org" <linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 30, 2004 at 10:03:35PM -0800, Nate Lawson wrote:
> This can screw up devices that don't allow full shutdown (i.e. require
> BIOS initialization).  A two-pass approach works better.  First pass
> allows the driver to match an ID but not initialize anything.  Second
> allocates resources like memory, IRQs, etc.

Consider the case where the generic driver is built into the kernel,
and the specific driver is a module.

The generic driver will have been initialised long before the specific
driver is known to the system.  So doing a first-pass over existing
drivers to find the "best match" and then initialising on a second
pass Just Doesn't Work(tm).

Also, if what you say is true, these device drivers can only ever be
inserted and never removed and re-inserted - which would be a driver
bug.

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
