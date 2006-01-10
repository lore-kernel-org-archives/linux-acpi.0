From: Alex Riesen <raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 16:31:19 +0100
Message-ID: <81b0412b0601100731p46ec276btfe04382a9e53bd5c@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
	 <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
	 <7vu0cdjhd1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7vu0cdjhd1.fsf-u5dp/1a/izZijMVVUgEtmwqrb7wDvxM8@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 1/9/06, Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org> wrote:
> 2. Fix "git checkout <branch>" so that it does a reasonable thing
>    even when a dirty path is different in current HEAD and
>    destination branch.  Then I could:
>
>         $ git checkout symref ;# this would not work in the current git
>             # it would die like this:
>             # $ git checkout symref
>             # fatal: Entry 'gitweb.cgi' not uptodate. Cannot merge.

That is actually very interesting. I already wished sometimes to be
able to switch branches with a dirty working directory (and usually
ended up with git diff+checkout+apply).
Even if it results in a merge and conflict markers in files it looks
like a very practical idea!

>         $ git diff ;# just to make sure inevitable automated merge
>                     # did the right thing
>         $ git commit -a -m "Fix symref fix"
>             # I could collapse them into one instead, like this:
>             # $ git reset --soft HEAD^
>             # $ git commit -a -C ORIG_HEAD
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
