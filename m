From: Russell King <rmk-pci-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: pci bridge suspend/resume (Re: PCI not restored correctly after suspend to ram)
Date: Tue, 23 Mar 2004 09:23:38 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040323092338.A21352@flint.arm.linux.org.uk>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at> <1079761564.7274.730.camel@dhcppc4> <405C00C6.3010805@pobox.com> <20040320134542.GV25059@parcelfarce.linux.theplanet.co.uk> <20040320181000.GA8272@kroah.com> <20040322223425.GB3213@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040322223425.GB3213-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>; from ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org on Mon, Mar 22, 2004 at 10:34:25PM +0000
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org, "linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org" <linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 22, 2004 at 10:34:25PM +0000, Adam Belay wrote:
> What do you think would be the best way to go about this?
> 
> I was able to come up with the following options:
> 
> 1.) flags in struct device_driver
> 2.) return codes from (*match)
> 3.) a seperate bus specific function to evaluate driver priority
> 
> Also how can we prevent the order in which drivers are loaded from
> determining which driver is bound?  It seems that we would need to
> delay device matching.

There's also the problem of devices which don't have a driver loaded.
For instance, if you suspend and power down a cardbus bridge which
hasn't had yenta_socket loaded, you could loose the extra configuration
information in TI bridges necessary for IRQ routing, which we won't
be able to recover at a later point in time.

Do we even care about this?

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
