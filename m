From: Ingo Molnar <mingo@elte.hu>
Subject: Re: lost parts of "pci, acpi: reroute PCI interrupt to legacy boot
 interrupt equivalent" during merge
Date: Wed, 20 Oct 2010 15:48:48 +0200
Message-ID: <20101020134848.GB7970@elte.hu>
References: <4CBEDA90020000780001E290@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CBEDA90020000780001E290@vpn.id2.novell.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>, Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Junio C Hamano <gitster@pobox.com>
Cc: sassmann@redhat.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org


* Jan Beulich <JBeulich@novell.com> wrote:

> The git history shows the complete patch (commit
> e1d3a90846b40ad3160bf4b648d36c6badad39ac), but none of the
> released versions from .29 onwards have the pieces the patch was
> supposed to add to drivers/acpi/pci_irq.c. What happened here? Is
> the workaround no longer needed (in which case the other bits
> should also be removed to avoid confusion)?

Very strange. It appears to have been damaged by this merge commit:

 |
 | commit 5b56eec77498f15317f3ff5ac9101372f400c859 (from 662c319ae4b4fb60001816dfe1dde5fdfc7a2af9)
 | Merge: c2f4398 662c319
 | Author: Takashi Iwai <tiwai@suse.de>
 | Date:   Tue Mar 24 00:35:43 2009 +0100
 |
 |     Merge branch 'topic/jack' into for-linus
 |

See:

   git log -p -m 5b56eec77498f15317f3ff5ac9101372f400c859

Not sure how that happened there. This is what Linus merged from me:

 |
 | commit 3e370b29d35fb01bfb92c2814d6f79bf6a2cb970
 | Merge: 88d1dce 5b664cb
 | Author: Ingo Molnar <mingo@elte.hu>
 | Date:   Fri Jul 18 19:31:12 2008 +0200
 |
 |    Merge branch 'linus' into x86/pci-ioapic-boot-irq-quirks
 |   
 |    Conflicts:
 |   
 |        drivers/pci/quirks.c
 |   
 |    Signed-off-by: Ingo Molnar <mingo@elte.hu>
 |

At this point those bits still appear to have been intact.

I re-created the merge commit the following way:

 git checkout c2f4398           # has old drivers/acpi/pci_irq.c
 git merge 662c319              # contains new drivers/acpi/pci_irq.c bits

 Auto-merging include/linux/input.h
 Auto-merging sound/core/jack.c
 Merge made by recursive.
 .../sound/alsa/DocBook/alsa-driver-api.tmpl        |    3 +
 include/linux/input.h                              |    1 +
 include/sound/jack.h                               |    5 ++
 sound/core/jack.c                                  |   45 +++++++++----------
 4 files changed, 30 insertions(+), 24 deletions(-)

And the resulting merge does not carry over the changes in drivers/acpi/pci_irq.c!

That is how those changes got lost. (it in essence deactivated that part of the 
feature)

Now, this appears to be either a Git bug, or some very non-obvious Git behavior.

I do remember merge troubles with that file, so maybe my merge commit 
3e370b29d35fb01bfb92c2814d6f79bf6a2cb970 introduces something that confuses Git? 
I've Cc:-ed Linus and Junio.

( Sidenote, in hindsight that particular chunk does not look particularly clean so 
  if we re-add it please clean it up to be less #ifdeffy and to have the extern
  declaration in some header, get Acks from the ACPI and PCI people again, etc. )

Thanks,

	Ingo
