From: Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 17:34:25 +1300
Message-ID: <46a038f90601082034g2865b26ftc344c599e29a4655@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
	 <20060108230611.GP3774@stusta.de>
	 <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0601081909250.3169-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 1/9/06, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org> wrote:
> And then do
>
>         git-rebase linus
>
> to rebase your development branch to mine.
>
> THIS is what "rebase" is for. It sounds like what you really want to do is
> not have a development branch at all, but you just want to track my tree
> and then keep track of a few branches of your own. In other words, you
> don't really have a "real" branch - you've got an odd collection of
> patches that you really want to carry around on top of _my_ branch. No?

FWIW, I determine whether I should rebase or merge based on

 + Whether the branch/head I maintain is public. For public repos, I
*must* merge carefully as rebase "rewinds" the head and that makes a
mess of any repositor tracking me.

 + Whether the changes on my both sides are significant, and it is
semantically meaningful to have a merge. If either side had just a
couple of minor commits, rebase makes life a lot easier down the path.
If both side clearly saw parallel development, it is more sincere to
merge and let that be recorded.

 + If my attempt to rebase leads to any non-trivial conflicts or
co-dependencies, then I definitely cancel the rebase and merge.

> Now, in this model, you're not really using git as a distributed system.

I'd argue that it is not about distributed or not. It's all in what
you want to record in your history. As such, it is a communication
device -- and I want to make effective use of it. I guess the question
I ask myself is: what will communicate what's happened here most
clearly? What will be useful for people to read? In that context, a
white-lie here and there simplifying the history a bit where it's not
interesting counts as a good thing.

cheers,


martin
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
