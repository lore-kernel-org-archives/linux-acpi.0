From: Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Subject: Re: pci bridge suspend/resume (Re: PCI not restored correctly after suspend to ram)
Date: Sat, 20 Mar 2004 11:00:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040320180045.GB26931@colo.lackof.org>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at> <1079761564.7274.730.camel@dhcppc4> <405C00C6.3010805@pobox.com> <20040320134542.GV25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040320134542.GV25059-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org, "linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org" <linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 20, 2004 at 01:45:42PM +0000, Matthew Wilcox wrote:
> I've often thought we needed a generic pci bridge driver ...

Right now, all the PCI-PCI Bridge support is spread across 4 files.
Mostly in drivers/pci/setup-bus.c. Similar for PCI_CLASS_BRIDGE_CARDBUS
(generic) support.  Right now, not counting hotplug support,
a driver for PCI_CLASS_BRIDGE_PCI devices would only need to claim
the PCI device.  hotplug support would be the main reason for adding
such a driver.

Is there a preferred way to invoke multiple drivers
for suspend/resume like we do for bus walks?

grant


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
