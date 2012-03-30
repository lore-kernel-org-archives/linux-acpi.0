From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] ACPI & Power Management patches for Linux-3.4-merge
Date: Fri, 30 Mar 2012 12:32:04 -0700
Message-ID: <CA+55aFx8XT0biUUWfTRf1VJC_2dgcqV5Lr3AxQG0ze+B0gSC9A@mail.gmail.com>
References: <4F759B4A.5010807@kernel.org> <CA+55aFxHpGhs72T6BNSaHJiZVRSKg8LTtWm7728RzP=+mrGTmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56598 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761075Ab2C3Tc1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 15:32:27 -0400
In-Reply-To: <CA+55aFxHpGhs72T6BNSaHJiZVRSKg8LTtWm7728RzP=+mrGTmQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Lee <rob.lee@linaro.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Fri, Mar 30, 2012 at 12:16 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But there's been at least three merges that submaintainers did for me
> this merge window where I looked at their merge and said "No, that's
> wrong, and I would have done it better". Two of those were the nice
> kind of "I left it unmerged, but here's my example merge if you want
> to take it", so the wrong merges didn't ever show up in the tree. But
> yours is now no longer even the top commit in your pile of fixes, so
> now I apparently have to take that *known*incorrect* merge and fix it
> up with an evil merge of my own.

Ugh. I'm undoing my merge rather than do that evil merge that fixes up yours.

So I have three choices:

 (a) I can just re-do your merge, and lose the two commits you had on top of it

 (b) I can create a new local branch with your pre-merged state, and
cherry-pick the two commits on top of that, and then merge that, and
then fake out the pull request.

 (c) I can ask you to do that fix up (rebase those two commits on top
of the state before the broken merge), and then you can ask me to pull
again, without the merge - same as (b) really, but I don't have to
fake the pull request message when I create the merge.

I think I'll do (c), but then probably fall back on (a) if I don't
hear from you. (b) gets me the tree I want, but I don't like faking
pull requests - I've occasionally pulled less than requested (exactly
because I didn't like the top merge), but I try to avoid actually
adding modified commits on top.

                  Linus
