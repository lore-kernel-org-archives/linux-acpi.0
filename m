From: Olaf Dabrunz <Olaf.Dabrunz@gmx.net>
Subject: Re: lost parts of "pci, acpi: reroute PCI interrupt to legacy boot
 interrupt equivalent" during merge
Date: Thu, 21 Oct 2010 20:20:22 +0200
Message-ID: <20101021182022.GC7328@santana.dyndns.org>
References: <4CBEDA90020000780001E290@vpn.id2.novell.com>
 <20101020152453.GD22271@elte.hu>
 <4CBF1896.70901@redhat.com>
 <201010201214.03363.bjorn.helgaas@hp.com>
 <4CBF4904.8050503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CBF4904.8050503@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Stefan Assmann <sassmann@redhat.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <JBeulich@novell.com>, Takashi Iwai <tiwai@suse.de>, Junio C Hamano <gitster@pobox.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Olaf Dabrunz <Olaf.Dabrunz@gmx.net>
List-Id: linux-acpi@vger.kernel.org

On 20-Oct-10, Stefan Assmann wrote:
> On 20.10.2010 20:14, Bjorn Helgaas wrote:
> > On Wednesday, October 20, 2010 10:28:06 am Stefan Assmann wrote:
> >> Let me take a look at the current situation and see if I can come up
> >> with a solution. Sorry if things got messy.
> > 
> > When you redo this, can you update the printks to use dev_info()
> > and "[%04x:%04x]" for vendor/device, like the rest of PCI?
> 
> Noted.
> 
> > 
> > Actually, the bridge_has_boot_interrupt_variant() printk looks
> > superfluous to me.
> 
> That's a leftover from debugging and will be removed.
> 
> > 
> > Do you know how Windows handles these machines?  I'm just wondering
> > if there's some ACPI or other information from the BIOS that we're
> > not handling quite correctly, and if we fixed that maybe we wouldn't
> > need a quirk.
> 
> I have no knowledge about the Windows internals. It might be that
> Windows does not mask the interrupt line on the IO-APIC while handling
> the interrupt and shuts off the interrupt on the device itself.
> Thus no boot interrupt would be generated.
> Remember, this problem was first discovered when the RT kernel masked
> the interrupt line until the threaded interrupt handler has done its
> work.
> 
> For your second question, let me point you to
> http://lkml.org/lkml/2009/10/19/74
> which I posted a while ago, trying to summarize the boot interrupt
> problem and how chipset and BIOS developers may avoid it in the future.
> 
> In short, yes it can be avoided.However there are already broken
> chipsets out there where you simply cannot disable the generation of
> boot interrupts if a (non-primary IO-APIC) interrupt line is masked.

Short answers:

To my knowledge, Windows variants that are able to trigger the boot
interrupt problems are not targeted at server hardware that uses boot
interrupts. So Windows simply does not have to deal with the problem.

There is also no hidden method in the BIOS to rectify the situation, the
ACPI and MP specifications and vendor-specific docs contain nothing of
that sort. (I worked my way through these specs several times to find
alternatives, but there are none.)

A BIOS that has this problem (and hardware that does not allow software
to disable boot interrupts) is just broken.

The URL Stefan gave above explains the situation and cites what we wrote
so far to solve the problem.


Long answers:

The type of interrupt handling depends on the version of Windows. At
least older desktop and server versions of Windows did not use threaded
interrupt handling, but handled the interrupt completely in the
interrupt service routine (as Linux does when configured not to use
threaded interrupts). So there was no need to mask the interrupt, and
the boot interrupt problems simply were not triggered.

There is an RT version of Windows that uses threaded interrupt handling,
and I believe Windows CE may use it as well. But these variants of
windows are typically not run on (or certified for?) server hardware
that comes with more than one bus and APIC.

So Windows simply does not trigger the problem because MS offers and
maintains different variants of Windows for different markets.


That is most probably also the reason why some BIOSes forget to turn off
boot interrupts when the OS tells them to switch to APIC-based interrupt
handling: during BIOS development, the BIOS is tested against a version
of Windows that does not use threaded interrupts / interrupt masking,
and the problem is not noticed.


Here are the reasons why we have to solve this in Linux.

    - Linux companies actually have customers who use multi-bus servers
      with RT Linux / threaded interrupts.

    - The vanilla Linux kernel should work properly on all hardware when
      someone enables a kernel option, like threaded interrupt handling.

      This is something that Windows is not trying to achieve. MS is a
      vendor and works with certifications, and by this means can tell
      people which variant of Windows works on which hardware. But
      _vanilla_ Linux is the technical basis for vendors and should be
      very reliable on all hardware, even when kernel options are
      changed.
      

(BTW: early acknowledgment / masking / shutdown of interrupts on the
device is a technique that needs careful testing with every single
device. The exact way how this works (or fails) depends entirely on the
device. There are no standards here, and every device driver needs to do
that separately in a device-dependent way. It also requires that the
device has been designed to tell acknowledged events apart from not
acknowledged events.

My knowledge about interrupt handling in Windows is by no means
comprehensive, but I have not yet seen this kind of interrupt
acknowledgement mentioned in any Windows documentation.)


Also note that there are several BIOSes out there that turn off boot
interrupts properly when the OS asks them for APIC-based interrupt
handling. Stefan also cited the AMD documentation where I found a
complete account on how to do this in a BIOS for that chipset.

Other BIOSes do not have these routines in the _PIC() function. This is
clearly a bug.


> > ISTR a paper or some kind of writeup you did, but the commit
> > (e1d3a90846) doesn't mention it.  Am I mis-remembering that?
> 
> Please see the URL above, it contains references to the writeups we did
> at that time. There's also a paper we were working on, but we got
> side-tracked and it never reached a state that was publishable.
> Apologies for that, we might be able release a stripped down version of
> it, but I will have to coordinate this as I'm not the sole author.
> 
> Ccing Olaf Dabrunz, as he was very involved in the whole writing and
> fixing as well.

Thanks for the Cc. (I am not subscribed to lkml atm.)

Yep, this is largely my fault. Last year I suddenly got the chance to
work on two other projects that are on top of my priority list. This is
why the paper is delayed for so long (and Stefan is waiting for me to
re-surface).

Also, it turned out that there is no comprehensive interrupt handling
text and we had to read quite a number of books and specs to put
everything together, and to arrive at our solutions for boot interrupt
problems (rerouting when the problem is in the hardware, quirks for BIOS
bugs).

So for the paper we felt that we needed to put together a short overview
of all involved technologies so that readers can follow our
argument On the other hand, to really understand why most other
approaches fail, or are unavailable, and why rerouting and quirks are
the "best" alternative, we had to give a relatively detailed
presentation of the involved signal paths.

So, at least as a spin-off and as something to cite in the paper, we
(esp.  I) were tempted to write a comprehensive text on interrupt
handling as well.

It is also not the first time I have researched interrupt problems, and
I hate to research that amount of information another time.

I hope that soon Stefan and I can work on this again. For me, this
depends on decisions about my other projects that will be made soon.


In the meantime, if you want some additional information quickly, please
have a look at the URL Stefan gave above, esp. at our presentation:
http://people.redhat.com/sassmann/publications/Boot_Interrupts_and_IRQ_Threads.pdf.

>From page 45 on, in the "Details" section, you will find an overview of
other ideas for handling boot interrupt problems. I believe this
overview may be difficult to understand completely, as it just
summarizes the information we had. But it may help to understand why
some approaches fail.

> > It'd be kind of nice for archaeologists like me if there were a
> > kernel bugzilla with before/after dmesg logs and stuff.
> 
> Sorry I'm not aware of any.

Same here.

Maybe you should bring this up in a thread of it's own.

-- 
Olaf Dabrunz (Olaf.Dabrunz <at> gmx.net)
