From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] ACPI & Power Management Patches for Linux-3.5-rc1
Date: Tue, 5 Jun 2012 09:43:57 -0700
Message-ID: <CA+55aFzvj_0+kunG0fy1xDsTxrO-qBU7rg-6mpnFKoLq7XyROw@mail.gmail.com>
References: <4FCCD58B.30000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40324 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab2FEQoT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jun 2012 12:44:19 -0400
In-Reply-To: <4FCCD58B.30000@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Jun 4, 2012 at 8:34 AM, Len Brown <lenb@kernel.org> wrote:
> =A0 =A0 =A0Merge branch 'upstream' into bugfix-video

So I *think* this merge is a mismerge, but I want to verify with Alan.

I think the drivers/gpu/drm/gma500/psb_drv.c should be taken from
current mainline: you commented out the call to
"acpi_video_register()", and while it is true that both branches did
comment that line out, mainline actually has further changes
*afterwards* that put it back in again. Notably commit d839ede47a56
("gma500: opregion and ACPI").

So I *think* that the resolution to that merge should have been to
just take everything from mainline.

Alan? Can you check out the tree at

    git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git releas=
e

or are you still busy with the queen?

               Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
