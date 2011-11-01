From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: ACPI ERROR SMBus or IPMI write requires Buff of len 66, found
 32...???? linux-3.0.0
Date: Tue, 1 Nov 2011 08:05:49 -0600
Message-ID: <CAErSpo4GaQfoBWs2iPk1ppx69Ccnz3dZvt31vSp8R7zka8a6=g@mail.gmail.com>
References: <4EAF1021.2090004@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34669 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab1KAOGL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2011 10:06:11 -0400
Received: by ggnb1 with SMTP id b1so7066472ggn.19
        for <linux-acpi@vger.kernel.org>; Tue, 01 Nov 2011 07:06:10 -0700 (PDT)
In-Reply-To: <4EAF1021.2090004@tlinx.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

[+cc linux-acpi]

On Mon, Oct 31, 2011 at 3:16 PM, Linda Walsh <lkml@tlinx.org> wrote:
>
>
> Was looking through boot log messages, and this one seemed 'new'...

Can you confirm that this error did not occur on a previous version?
What is the most recent version where it did not occur?

> is this saying that the device requires 66, but the driver allocated =
32
> bytes?
>
> Or the opposite: i.e. driver requires 66 (according to some new stand=
ard**)
> but the
> device from 2009, has the 2009 standard of 32?
>
> Just a WAG, but 20110413 looks like a date, that is certainly newer t=
han the
> system, though
> it has had firmware upgrades (though none in the past 6 months or so.=
=2E.)...

20110413 is basically the version number of the ACPI CA in Linux.
Generally, we don't remove support for old things, so if it worked in
the past, it should still work with newer versions.

> Seems like a weird thing to be changed across drivers while not provi=
ding
> for some backward
> compat, but that's purely based on a notion that there's a driver/hw =
version
> mismatch now
> when before, there were no such error messages (maybe the error messa=
ge is
> new, and it's
> always been broken? ;-) )...
>
> as subj says linux-3.0.0, stock vanilla + the latest IMQ networkfilte=
r
> patch.
> X64
>
> [ =A0 13.722612] ACPI Error: SMBus or IPMI write requires Buffer of l=
ength 66,
> found length 32 (20110413/exfield-285)
> [ =A0 13.733078] ACPI Error: Method parse/execution failed [\_SB_.PMI=
0._GHL]
> (Node ffff880616962b18), AE_AML_BUFFER_LIMIT (20110413/psparse-536)
> [ =A0 13.746189] ACPI Error: Method parse/execution failed [\_SB_.PMI=
0._PMC]
> (Node ffff880616962a78), AE_AML_BUFFER_LIMIT
> [ =A0 13.755322] dca service started, version 1.12.1[ =A0 13.761822]
> =A0(20110413/psparse-536)
> [ =A0 13.765509] ACPI Exception: AE_AML_BUFFER_LIMIT, Evaluating _PMC
> (20110413/power_meter-773)

=46or completeness, it'd be nice to see the complete dmesg log.  In thi=
s
case, it looks AML-related, so an acpidump would also be useful.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
