From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: No network after S3
Date: 17 Feb 2004 01:53:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077000806.2515.46.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com>
	 <200402161417.42755.t.zachmann@zagge.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402161417.42755.t.zachmann-c61pB8mzqkY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thorsten Zachmann <t.zachmann-c61pB8mzqkY@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-02-16 at 08:17, Thorsten Zachmann wrote:
> Hello 
> On Monday 16 February 2004 07:10, Brown, Len wrote:
> > >I tried pci=noacpi. No diference.
> > >If I understand you right, I should wait a little bit before dealing
> > >with this powersaving stuff.
> >
> > If the NIC were now working before attempting suspend/resume, then we'd
> > need to get that fixed first.  However, I think you're saying that the
> > NIC _does_ work under normal conditions, and the failure is only after
> > returning from S3. yes?
> >
> 
> It looks like I have the same problem on my Tecra S1. After a suspend (S3) the 
> network and sound are no longer working. 
> A ethereal trace shows that the interface still sends arp requests but is 
> unable to receive something. If I look at /proc/interrupts the counter for 
> the interrupt where the network card is connected is no longer incremented.
> 
> > So this seems suspend/resume specific, and your use of pci=noacpi
> > further suggests it has nothing to do with the initial interrupt
> > assignments.
> 
> pci=noacpi also didn't change the situation.
> 
> > We've got a number of post-resume failures, and this issue is rising on
> > the priority list -- so I expect we'll spend some time looking at it
> > soon.
> 
> I tried out the patches from bug report 1409 and 1661 but nothing changed.
> 
> Please let me know if there is any information that I can provide to track the 
> problem down?

need /proc/interrupts -- PIC or APIC mode?  network interrupt shared
with ACPI, other devices, or dedicated interrupt?  We'll probably have
to dump out the state of the interrupt controller after resume.  for
IOAPIC we can do that with print_IO_APIC.  for PIC mode we'll need
something else.

-Len




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
