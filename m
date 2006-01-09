From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 00:53:12 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>On 1/9/06, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> Perhaps the tools should try to support what "a lot of people"
>> expect, rather than making "a lot of people" do extra work
>> because of the tools?
>
>I think it does. All the tricky stuff that David and Junio have been
>discussing is actually done very transparently by
>
>    git-rebase <upstream>
>
>Now, git-rebase uses git-format-patch <options> | git-am <options> so
>it sometimes has problems merging. In that case, you can choose to
>either resolve the problem (see the doco for how to signal to git-am
>that you've resolved a conflict) or to cancel the rebase. If you
>choose to cancel the rebase, do
>
>   cp .git/refs/heads/{<headname>,<headnamebadrebase>}
>   cat .git/HEAD_ORIG > .git/refs/heads/<headname>
>   git-reset --hard
>   rm -fr .dotest
>
>and you'll be back to where you started. Perhaps this could be rolled
>into something like git-rebase --cancel to make it easier, but that's
>about it. The toolchain definitely supports it.

This is completely insane.
Do you have any idea what "sometimes has problems merging" means
in practice?  It means the tools are really nifty in the trivial
case but worse than worthless when you need them the most.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
