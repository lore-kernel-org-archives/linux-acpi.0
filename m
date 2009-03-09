From: Leo Antunes <leo@costela.net>
Subject: Re: [help] strange fan problems, partially solved in DSDT
Date: Tue, 10 Mar 2009 00:42:22 +0100
Message-ID: <3281e35e0903091642j16a1a3aak7350eb2251aafd18@mail.gmail.com>
References: <49B11032.1080706@costela.net> <1236568710.2820.70.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:46296 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbZCIXmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2009 19:42:25 -0400
Received: by bwz26 with SMTP id 26so1403023bwz.37
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2009 16:42:22 -0700 (PDT)
In-Reply-To: <1236568710.2820.70.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hi,

On Mon, Mar 9, 2009 at 4:18 AM, Zhang Rui <rui.zhang@intel.com> wrote:
>
> > The fan also didn't seem to react to the processor temperature, sud=
denly
> > springing to full-power when it reached the 80C trip point (which w=
asn't
> > even reported in trip_points) and never switching off again.
> >
> > These problems manifested with 2.6.2{6,8,9-rc7}.
> so the problem exists in all the kernels you have tried, right?

Yes, exactly, but I have only tried the described "solution" with
2.6.29-rc{5,6,7}.

> > My questions are:
> > - am I right in assuming the EC could be playing behind ACPI's back=
 and
> > controlling the fan speed by itself, only depending on ACPI to reac=
t
> > when issued the _Q11 event?
> I think so, EC needs a notification (ACPI interrupt) to change the fa=
n
> speed when temperature changes.

Pardon my ignorance, but what's actually generating these interrupts?
If ACPI's not even aware of the right trip points, I'd assume it's
something not directly connected to it asking the ACPI code to fiddle
with bits in the EC, but then why doesn't the BIOS implement it
completely out of sight? And more importantly, without depending on
the OS implementation for it.
Is there a point I'm not seeing in this, or are the BIOS-maker's
decisions also unclear to you?

> > - should this problem be understood as a failure in the DSDT for no=
t
> > explicitly initializing something; a failure in ACPI for not implic=
itly
> > initializing something or a failure in the hardware/BIOS for depend=
ing
> > on partially non-ACPI behavior to control fan speed?
> Not sure it's a hardware/software problem.
> =EF=BB=BFI don't know what difference "=EF=BB=BFStore(\_SB.PCI0.LPC.E=
C0.FNST, Debug)"
> brings us.
> Alexey, can you have a look at this problem please?

Thanks for the help!

Cheers

--
Leo Antunes
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
