From: Peter.Zeipelt-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
Subject: Re: No network after S3
Date: Tue, 17 Feb 2004 22:49:23 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077053289.40328769b7495@webmail.t-online.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com>  <200402161417.42755.t.zachmann@zagge.de> <1077000806.2515.46.camel@dhcppc4>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077000806.2515.46.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Thorsten Zachmann <t.zachmann-c61pB8mzqkY@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len

My  first mails concerned interrupts shared with ACPI
So I did some further testing with manually controlled
resources. 
Same result.
An interesting thing is, that the cheapest NIC an AT2500 with
realtek 8139b, did some pings after S3.
At first nothing happens after pressing enter.
Suddenly 4lines with a reply from the other host appeared.
Then I had to wait some seconds and several new lines 
with a reply appeared.
But each time, these lines appered "at once"  and not in the usual
"ping rythm".
After that , in the usual "ping rythm" ping told me
ping : sendmsg: No buffer space available
Here's my /proc/interrupts

           CPU0       
0:      1569738          XT-PIC  timer
1:          527          XT-PIC  i8042
2:            0          XT-PIC  cascade
5:            0          XT-PIC  acpi
6:           37          XT-PIC  floppy
8:            2          XT-PIC  rtc
10:           4          XT-PIC  HiSax
11:          19          XT-PIC  eth0
14:       23376          XT-PIC  ide0
15:          42          XT-PIC  ide1
NMI:          0
LOC:    1569739
ERR:       1528
MIS:          0

I don't know, if it's useful for you, but here are
some lines from /var/log/messages

Feb 17 22:01:26 penti kernel: PM: Preparing system for suspend
Feb 17 22:01:26 penti kernel: Stopping tasks:
==============================|
Feb 17 22:01:26 penti kernel: hdd: start_power_step(step: 0)
Feb 17 22:01:26 penti kernel: hdd: start_power_step(step: 1)
Feb 17 22:01:26 penti kernel: hdd: complete_power_step(step: 1, stat:
50, err: 0)
Feb 17 22:01:26 penti kernel: hdd: completing PM request, suspend
Feb 17 22:01:26 penti kernel: hdc: start_power_step(step: 0)
Feb 17 22:01:26 penti kernel: hdc: completing PM request, suspend
Feb 17 22:01:26 penti kernel: hda: start_power_step(step: 0)
Feb 17 22:01:26 penti kernel: hda: start_power_step(step: 1)
Feb 17 22:01:26 penti kernel: hda: complete_power_step(step: 1, stat:
50, err: 0)
Feb 17 22:01:26 penti kernel: hda: completing PM request, suspend
Feb 17 22:01:26 penti kernel: PM: Entering state.
Feb 17 22:01:26 penti kernel: Back to C!
Feb 17 22:01:26 penti kernel: PM: Finishing up.
Feb 17 22:01:26 penti kernel: eth0: link up, 100Mbps, full-duplex, lpa
0x45E1
Feb 17 22:01:26 penti kernel: hda: Wakeup request inited, waiting for
!BSY...
Feb 17 22:01:26 penti kernel: hda: start_power_step(step: 1000)
Feb 17 22:01:26 penti kernel: blk: queue c139ca00, I/O limit 4095Mb
(mask 0xffffffff)
Feb 17 22:01:26 penti kernel: hda: completing PM request, resume
Feb 17 22:01:26 penti kernel: hdc: Wakeup request inited, waiting for
!BSY...
Feb 17 22:01:26 penti kernel: hdc: start_power_step(step: 1000)
Feb 17 22:01:26 penti kernel: hdc: completing PM request, resume
Feb 17 22:01:26 penti kernel: hdd: Wakeup request inited, waiting for
!BSY...
Feb 17 22:01:26 penti kernel: hdd: start_power_step(step: 1000)
Feb 17 22:01:26 penti kernel: blk: queue c1396e00, I/O limit 4095Mb
(mask 0xffffffff)
Feb 17 22:01:26 penti kernel: hdd: completing PM request, resume
Feb 17 22:01:26 penti kernel: Restarting tasks... done
Feb 17 22:01:44 penti kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 17 22:01:44 penti kernel: eth0: Tx queue start entry 4  dirty entry
0.
Feb 17 22:01:44 penti kernel: eth0:  Tx descriptor 0 is 00002000.
(queue head)
Feb 17 22:01:44 penti kernel: eth0:  Tx descriptor 1 is 00002000.
Feb 17 22:01:44 penti kernel: eth0:  Tx descriptor 2 is 00002000.
Feb 17 22:01:44 penti kernel: eth0:  Tx descriptor 3 is 00002000.
Feb 17 22:01:44 penti kernel: eth0: link up, 100Mbps, full-duplex, lpa
0x45E1
Feb 17 22:01:56 penti kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 17 22:01:56 penti kernel: eth0: Tx queue start entry 4  dirty entry
0.
Feb 17 22:01:56 penti kernel: eth0:  Tx descriptor 0 is 00002000.
(queue head)
Feb 17 22:01:56 penti kernel: eth0:  Tx descriptor 1 is 00002000.
Feb 17 22:01:56 penti kernel: eth0:  Tx descriptor 2 is 00002000.
Feb 17 22:01:56 penti kernel: eth0:  Tx descriptor 3 is 00002000.
Feb 17 22:01:56 penti kernel: eth0: link up, 100Mbps, full-duplex, lpa
0x45E1

All these are books with seven seals for me.

I hope you can use this information.
What I haven't said before.
I tested the system with a well known commercial OS.
No problems with S3 or S4.
Btw: Are there linux-systems without problems?

Many thanks for your help and
good luck

Peter


Len Brown schrieb:
> On Mon, 2004-02-16 at 08:17, Thorsten Zachmann wrote:
> > Hello 
> > On Monday 16 February 2004 07:10, Brown, Len wrote:
> > > >I tried pci=noacpi. No diference.
> > > >If I understand you right, I should wait a little
> bit before dealing
> > > >with this powersaving stuff.
> > >
> > > If the NIC were now working before attempting
> suspend/resume, then we'd
> > > need to get that fixed first.  However, I think
> you're saying that the
> > > NIC _does_ work under normal conditions, and the
> failure is only after
> > > returning from S3. yes?
> > >
> > 
> > It looks like I have the same problem on my Tecra S1.
> After a suspend (S3) the 
> > network and sound are no longer working. 
> > A ethereal trace shows that the interface still sends
> arp requests but is 
> > unable to receive something. If I look at
> /proc/interrupts the counter for 
> > the interrupt where the network card is connected is no
> longer incremented.
> > 
> > > So this seems suspend/resume specific, and your use
> of pci=noacpi
> > > further suggests it has nothing to do with the
> initial interrupt
> > > assignments.
> > 
> > pci=noacpi also didn't change the situation.
> > 
> > > We've got a number of post-resume failures, and this
> issue is rising on
> > > the priority list -- so I expect we'll spend some
> time looking at it
> > > soon.
> > 
> > I tried out the patches from bug report 1409 and 1661
> but nothing changed.
> > 
> > Please let me know if there is any information that I
> can provide to track the 
> > problem down?
> 
> need /proc/interrupts -- PIC or APIC mode?  network
> interrupt shared
> with ACPI, other devices, or dedicated interrupt?  We'll
> probably have
> to dump out the state of the interrupt controller after
> resume.  for
> IOAPIC we can do that with print_IO_APIC.  for PIC mode
> we'll need
> something else.
> 
> -Len
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
