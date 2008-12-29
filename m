From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] ACPI: Do not modify SCI_EN directly
Date: Mon, 29 Dec 2008 23:16:06 +0200
Message-ID: <1230585366.4667.26.camel@maxim-laptop>
References: <200812291919.07663.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:36912 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbYL2VQN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Dec 2008 16:16:13 -0500
In-Reply-To: <200812291919.07663.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Mon, 2008-12-29 at 19:19 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> According to the ACPI specification the SCI_EN flag is controlled by
> the hardware, which sets this flag to inform the kernel that ACPI is
> enabled.  For this reason, we shouldn't try to modify SCI_EN
> directly.  Also, we don't need to do it in irqrouter_resume(), since
> lower-level resume code takes care of enabling ACPI in case it hasn't
> been enabled by the BIOS before passing control to the kernel (which
> by the way is against the ACPI specification).


Hi,=20

I am an unfortunate owner of an acer notebook ( aspire 5720 if this
matters) and it doesn't come back after second suspend, subsequently  I
figured out that bios doesn't pass control to linux at all, after secon=
d
resume, and moreover, a suspend to disk , 'fixes' this and enables me t=
o
do another suspend/resume cycle. This is a poor man workaround I use
now.

I already told about this here, and many peoples from here (including
you) tried to help me, but unfortunately this is very weird issue, and
nether me nor you can do much about, it is all about guesswork,
something, at least something is 'armed' on resume, so it confuses bios
then (it could be that yet, the critical part that confuses bios happen=
s
in second suspend time)

Needless to say that nothing useful appears in the logs, and everything
seems to work fine following each successful resume (both disk and ram)=
=2E

so I have a question, do you have a git branch to pull that includes al=
l
patches like this to test, so I build it weekly, and who knows, maybe
something like above will fix it.

Anyway I would gladly test any patch that you suspect might be involved
here.


Also, I tried to do a I/O port and PCI config dump before and after a
resume, aka in 'armed' and 'unarmed' state.

While there were many I/O port registers changes, and I yet to process
it bit after bit (and unfortunately there are plenty of undocumented
stuff), I noticed a meaningful change between bad and good state:


>From ICH8 manual:

"PIRQ[n]_ROUT=E2=80=94PIRQ[A,B,C,D] Routing Control Register

and

PIRQ[n]_ROUT=E2=80=94PIRQ[E,F,G,H]

Interrupt Routing Enable (IRQEN) =E2=80=94 R/W.
0 =3D The corresponding PIRQ is routed to one of the ISA-compatible
interrupts
      specified in bits[3:0].
1 =3D The PIRQ is not routed to the 8259.

NOTE: BIOS must program this bit to 0 during POST for any of the PIRQs
that are being used. The value of this bit may subsequently be changed
by the OS when setting up for I/O APIC interrupt delivery mode."


bit #7 of all those regs is '1' in good state, and '0' in bad state.

I tried to change it back, but this didn't help, so I post this just in
case, I don't think it is useful.


Best regards,
	Maxim Levitsky



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
