From: Pekka Pietikainen <pp-YuCZbdju05vHOG6cAo2yLw@public.gmane.org>
Subject: Re: b44 -- Re: No network after S3
Date: Wed, 25 Feb 2004 00:34:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040224223421.GA6225@ee.oulu.fi>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com> <1077000806.2515.46.camel@dhcppc4> <200402170856.42059.t.zachmann@zagge.de> <200402240741.30530.t.zachmann@zagge.de> <1077640877.5369.12.camel@homer> <1077660024.3036.56.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1077660024.3036.56.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Peter Meier <crazy-b-Mmb7MZpHnFY@public.gmane.org>, Thorsten Zachmann <t.zachmann-c61pB8mzqkY@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 24, 2004 at 05:00:24PM -0500, Len Brown wrote:
> > So, somehow, the MAC address is incorrect. I can ping my local IP
> > address, but nothing else. There is no way to get the network card
> > back
> > to live, except rebooting. If I rmmod b44 *before* going to sleep, and
> > modprobing it after I resume, I'm getting the same faulty MAC address
> > and no network.
I was recently able to reproduce a bug that sounds related, 
http://bugme.osdl.org/show_bug.cgi?id=2030 has the details.
Would be interesting to know whether the "fix" I found (running 
_only_ the initialization part of the bcm4400 driver) helps in this case too.

Broadcoms changelog provides some clues about what kind of access patters
make the chip break.

Current guesses are ssb_* (maybe ssb_is_core_up returning 1 
even when it isn't leading to ssb_pci_setup not getting called)
and b44_setup_phy (where the register access pattern differs slightly).
It didn't work even after altering the register access patterns to be ~= 
identical, making sure ssb_pci_setup gets run etc., alas, but I 
probably missed something.

Anyway, I'm working on it, but no guarantees on when I'll find the time to
nail it down.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
