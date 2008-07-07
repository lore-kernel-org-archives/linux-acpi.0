From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP
 systems
Date: Mon, 7 Jul 2008 21:10:56 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0807072101070.20615@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl>
 <200807071423.48425.rjw@sisk.pl> <Pine.LNX.4.55.0807071435160.16767@cliff.in.clinika.pl>
 <200807072003.48228.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200807072003.48228.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 7 Jul 2008, Rafael J. Wysocki wrote:

> Sorry, the patch I posted was _instead_ of your previous patch with the quirk,
> because that patch didn't work.  I don't know why it didn't work, however, I
> can only say it didn't work after removing the __i386__ dependency of
> acpi_dmi_table[].

 I don't recall seeing a note that my patch was reverted.  I had a careful
look at yours now and it applies on top of some diagnostic code which
should never have been applied to the tree in the first place as it was
not meant to and would also break the majority of systems out there.  I am
fairly sure this piece of code is the reason my implementation of the
workaround did not work for you.

> My patch is on top of the linux-next tree that didn't contain your patch.
> So, my patch adds a quirk that sets disable_irq0_through_ioapic to 1 (this
> variable is defined differently in my patch) and uses it to skip the part of
> check_timer() that breaks my box.
> 
> I hope that makes things clear.

 It does, thanks.  However I insist on getting this issue dealt with the
way I proposed -- check_timer() is too complicated and too fragile to mess
with as our history has already shown.  If IRQ0 is not to be routed
through the I/O APIC, then it should never be registered as an I/O APIC
interrupt in the first place.

 I am fairly with the offending change removed my fix will work for you as
expected as I went through the effort of checking at the run time that
once activated it makes the kernel correctly avoid the sequence in
check_timer() that hits your system, so it is only the DMI ID matching
that could have gone wrong, but your change indicates this is actually not
the case.

  Maciej
