From: Stefan Assmann <sassmann@redhat.com>
Subject: Re: lost parts of "pci, acpi: reroute PCI interrupt to legacy boot
 interrupt equivalent" during merge
Date: Wed, 20 Oct 2010 21:54:44 +0200
Message-ID: <4CBF4904.8050503@redhat.com>
References: <4CBEDA90020000780001E290@vpn.id2.novell.com> <20101020152453.GD22271@elte.hu> <4CBF1896.70901@redhat.com> <201010201214.03363.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201010201214.03363.bjorn.helgaas@hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <JBeulich@novell.com>, Takashi Iwai <tiwai@suse.de>, Junio C Hamano <gitster@pobox.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Olaf Dabrunz <Olaf.Dabrunz@gmx.net>
List-Id: linux-acpi@vger.kernel.org

On 20.10.2010 20:14, Bjorn Helgaas wrote:
> On Wednesday, October 20, 2010 10:28:06 am Stefan Assmann wrote:
>> Let me take a look at the current situation and see if I can come up
>> with a solution. Sorry if things got messy.
> 
> When you redo this, can you update the printks to use dev_info()
> and "[%04x:%04x]" for vendor/device, like the rest of PCI?

Noted.

> 
> Actually, the bridge_has_boot_interrupt_variant() printk looks
> superfluous to me.

That's a leftover from debugging and will be removed.

> 
> Do you know how Windows handles these machines?  I'm just wondering
> if there's some ACPI or other information from the BIOS that we're
> not handling quite correctly, and if we fixed that maybe we wouldn't
> need a quirk.

I have no knowledge about the Windows internals. It might be that
Windows does not mask the interrupt line on the IO-APIC while handling
the interrupt and shuts off the interrupt on the device itself.
Thus no boot interrupt would be generated.
Remember, this problem was first discovered when the RT kernel masked
the interrupt line until the threaded interrupt handler has done its
work.

For your second question, let me point you to
http://lkml.org/lkml/2009/10/19/74
which I posted a while ago, trying to summarize the boot interrupt
problem and how chipset and BIOS developers may avoid it in the future.

In short, yes it can be avoided.However there are already broken
chipsets out there where you simply cannot disable the generation of
boot interrupts if a (non-primary IO-APIC) interrupt line is masked.

> 
> ISTR a paper or some kind of writeup you did, but the commit
> (e1d3a90846) doesn't mention it.  Am I mis-remembering that?

Please see the URL above, it contains references to the writeups we did
at that time. There's also a paper we were working on, but we got
side-tracked and it never reached a state that was publishable.
Apologies for that, we might be able release a stripped down version of
it, but I will have to coordinate this as I'm not the sole author.

Ccing Olaf Dabrunz, as he was very involved in the whole writing and
fixing as well.

> 
> It'd be kind of nice for archaeologists like me if there were a
> kernel bugzilla with before/after dmesg logs and stuff.

Sorry I'm not aware of any.

  Stefan
--
Stefan Assmann         | Red Hat GmbH
Software Engineer      | Otto-Hahn-Strasse 20, 85609 Dornach
                       | HR: Amtsgericht Muenchen HRB 153243
                       | GF: Brendan Lane, Charlie Peters,
sassmann at redhat.com |     Michael Cunningham, Charles Cachera
