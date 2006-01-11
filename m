From: Luben Tuikov <ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 19:32:29 -0800 (PST)
Message-ID: <20060111033229.5590.qmail@web31809.mail.mud.yahoo.com>
References: <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com>
Reply-To: ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <252A408D-0B42-49F3-92BC-B80F94F19F40-ee4meeAH724@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org>, Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Luben Tuikov <ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--- Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org> wrote:
> they're totally irrelevant.  This is why it's useful to only pull  
> mainline into your tree (EX: ACPI) when you functionally depend on  
> changes there (as Linus so eloquently expounded upon).

Sometimes the dependency is _behavioural_.  For example certain
behaviour of other modules of the kernel changed and you want
to test that your module works ok with them under different
behaviour.  In which case you may or may not have to
change your code after the fact.

    Luben

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
