From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 13:28:50 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 
>I know a lot of people react to this kind of usage with "what's the
>point of the source control system if you're just messing with patches
>in and out of the tree all the time" But as a subsystem maintainer,
>you deal with a lot of changes and it's important to get a pristine
>clean history when you push things to Linus.
>
>In fact, I do this so much that Linus's tree HEAD often equals my
>origin when he pulls.
>
>Merges really suck and I also hate it when the tree gets cluttered
>up with them, and Linus is right, ACPI is the worst offender here.
>
>Yes, we can grep the merges out of the shortlog or whatever, but that
>merging crap is still physically in the tree.
>
>Just don't do it.  Merge into a private branch for testing if you
>don't want to rebuild trees like I do, but push the clean tree to
>Linus.

Perhaps the tools should try to support what "a lot of people"
expect, rather than making "a lot of people" do extra work
because of the tools?

Call me old fashioned, but I believe that tools are supposed to
make work easier, not harder.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
