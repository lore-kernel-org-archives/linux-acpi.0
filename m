From: Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 08 Jan 2006 11:33:49 -0800
Message-ID: <7vace61plu.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	<46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <46a038f90601081119r39014fbi995cc8b6e95774da-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Martin Langhoff's message of "Mon, 9 Jan 2006 08:19:50 +1300")
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On 1/9/06, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> Perhaps the tools should try to support what "a lot of people"
>> expect, rather than making "a lot of people" do extra work
>> because of the tools?
>
> I think it does. All the tricky stuff that David and Junio have been
> discussing is actually done very transparently by
>
>     git-rebase <upstream>
>
> Now, git-rebase uses git-format-patch <options> | git-am <options> so
> it sometimes has problems merging.

Careful.  I do not think rebase works across merges at all.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
