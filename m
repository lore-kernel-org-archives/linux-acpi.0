From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: lost parts of "pci, acpi: reroute PCI interrupt to legacy boot
 interrupt equivalent" during merge
Date: Wed, 20 Oct 2010 08:15:11 -0700
Message-ID: <AANLkTi=LWrOKow7Nw8dr_YZTeMGncP+Vowz3EZK5vShD@mail.gmail.com>
References: <4CBEDA90020000780001E290@vpn.id2.novell.com> <20101020134848.GB7970@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59011 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753392Ab0JTPQN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Oct 2010 11:16:13 -0400
In-Reply-To: <20101020134848.GB7970@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jan Beulich <JBeulich@novell.com>, Takashi Iwai <tiwai@suse.de>, Junio C Hamano <gitster@pobox.com>, sassmann@redhat.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Oct 20, 2010 at 6:48 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> I re-created the merge commit the following way:
>
> =A0git checkout c2f4398 =A0 =A0 =A0 =A0 =A0 # has old drivers/acpi/pc=
i_irq.c
> =A0git merge 662c319 =A0 =A0 =A0 =A0 =A0 =A0 =A0# contains new driver=
s/acpi/pci_irq.c bits

The other way around. The c2f4398 version is the new one, the 662c319
is the old one. So git picks the new one.

How do I know? Look here:

   [torvalds@i5 linux]$ git merge-base -a c2f4398 662c319
   6a94cb73064c952255336cc57731904174b2c58f

and then you can do

   [torvalds@i5 linux]$ git diff --stat 6a94cb7..c2f4398 drivers/acpi/p=
ci_irq.c
    drivers/acpi/pci_irq.c |  472
+++++++++++++-----------------------------------
    1 files changed, 130 insertions(+), 342 deletions(-)
   [torvalds@i5 linux]$ git diff --stat 6a94cb7..662c319 drivers/acpi/p=
ci_irq.c
   [torvalds@i5 linux]$

Notice? The version in 662c319 is the _same_ as the merge base version
(=3D=3D the old common one). So git simply picked the version that is
clearly the newer one, ie the one in c2f4398. There's not any data
conflict or anything. and that was a trivial merge as far as that file
is concerned.

After you do the merge, you'll also have

   [torvalds@i5 linux]$ git diff c2f4398..5b56eec drivers/acpi/pci_irq.=
c
   [torvalds@i5 linux]$

ie the merge did the expected thing and picked the new one.

If something got lost, it got lost elsewhere.

                                 Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
