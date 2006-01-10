From: Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 19:38:07 +1300
Message-ID: <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org>
	 <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99D82C29-4F19-4DD3-A961-698C3FC0631D-ee4meeAH724@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org>
Cc: Luben Tuikov <ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 1/10/06, Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org> wrote:
> If they all work, then we know precisely that it's the
> interactions between them, which also makes debugging a lot easier.

The more complex your tree structure is, the more the interactions are
likely to be part of the problem. Is git-bisect not useful in this
scenario?

cheers,


martin
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
