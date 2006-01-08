From: Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 08:19:50 +1300
Message-ID: <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 1/9/06, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Perhaps the tools should try to support what "a lot of people"
> expect, rather than making "a lot of people" do extra work
> because of the tools?

I think it does. All the tricky stuff that David and Junio have been
discussing is actually done very transparently by

    git-rebase <upstream>

Now, git-rebase uses git-format-patch <options> | git-am <options> so
it sometimes has problems merging. In that case, you can choose to
either resolve the problem (see the doco for how to signal to git-am
that you've resolved a conflict) or to cancel the rebase. If you
choose to cancel the rebase, do

   cp .git/refs/heads/{<headname>,<headnamebadrebase>}
   cat .git/HEAD_ORIG > .git/refs/heads/<headname>
   git-reset --hard
   rm -fr .dotest

and you'll be back to where you started. Perhaps this could be rolled
into something like git-rebase --cancel to make it easier, but that's
about it. The toolchain definitely supports it.

cheers,


martin
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
