From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: Random AE_TIME exceptions
Date: Wed, 7 Oct 2009 09:12:31 +0100
Message-ID: <9b2b86520910070112v3a631014t38e4fffe70d1380c@mail.gmail.com>
References: <20091007064437.GH6196@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:50532 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933695AbZJGINJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2009 04:13:09 -0400
Received: by fxm27 with SMTP id 27so4366868fxm.17
        for <linux-acpi@vger.kernel.org>; Wed, 07 Oct 2009 01:12:31 -0700 (PDT)
In-Reply-To: <20091007064437.GH6196@wrars-comp.wrarsdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Rahmatullin <wrar@altlinux.org>
Cc: linux-acpi@vger.kernel.org

On 10/7/09, Andrey Rahmatullin <wrar@altlinux.org> wrote:
>
> This is a copy of http://bugzilla.kernel.org/show_bug.cgi?id=14332
>
> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] 20090521
> evregion-424
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC0_.BST1] (Node f7012e70), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.CBST]
> (Node f7015078), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.BAT0._BST] (Node f7013fa8), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST 20090521 battery-385
>
> or
>
> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] 20090521
> evregion-424
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC0_.EBTS] (Node f7012eb8), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC0_.UBCS] (Node f7013ee8), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.CBST]
> (Node f7015078), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.BAT0._BST] (Node f7013fa8), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST 20090521 battery-385
>
>
> It doesn't seem to cause any instabilities or failures, but still.
> It also can be interesting that these errors were printed very often when
> I tried ivd/rt2x00.git and wifi interface was up.

Have you tried 2.6.32-rc3?

2.6.32-rc1 included an important rewrite for the "EmbeddedControl"
(EC) driver.  It was reported that this caused timeouts on some
machines.  These specific timeouts were then fixed in -rc3.  So it
would be interesting to see how -rc3 affects the timeout messages you
are seeing.

Thanks
Alan.
