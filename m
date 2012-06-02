From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] ACPI & Power Management Patches for Linux-3.5-merge
Date: Sat, 2 Jun 2012 16:51:30 -0700
Message-ID: <CA+55aFyGqZnVvd5-ZLUkS=EE72QG1FqempZrs+vBLyCkWP6T_Q@mail.gmail.com>
References: <4FC9B39B.403@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42114 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964986Ab2FBXvv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jun 2012 19:51:51 -0400
In-Reply-To: <4FC9B39B.403@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Fri, Jun 1, 2012 at 11:32 PM, Len Brown <lenb@kernel.org> wrote:
>
> ps. Sorry for sending this request at the tails of the merge window --
> I'll try to be earlier next time.

Christ, not only is it after I really wanted to do -rc1 (held up by
the tty locking problems), but it doesn't even compile.

Find the bug (the compiler certainly did):

static inline int acpi_pm_device_sleep_state(struct device *d, int *p, int m)
{
        if (p)
                *p = ACPI_STATE_D0;
        return (m >= ACPI_STATE_D0 && <= ACPI_STATE_D3) ? m : ACPI_STATE_D0;
}

and no, it wasn't a merge error. That's what it looks like in your tree.

The commit was done yesterday. It clearly had *zero* testing.

Looking more at the pull as a result of this, I notice that almost
every commit in that tree is from yesterday, and thus cleary cannot
have been in -next. I was going to just fix up the obvious one-liner
fixup, but looking at the bigger picture I'm going to say "3.6
material" for this whole thing.

              Linus
