From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 12:31:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101229390.4939@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de>
 <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org> <20060110201909.GB3911@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060110201909.GB3911-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Tue, 10 Jan 2006, Adrian Bunk wrote:
> 
> > Now, in this model, you're not really using git as a distributed system. 
> > In this model, you're using git to track somebody elses tree, and track a 
> > few patches on top of it, and then "git rebase" is a way to move the base 
> > that you're tracking your patches against forwards..
> 
> I am using the workaround of carrying the patches in a mail folder, 
> applying them in a batch, and not pulling from your tree between 
> applying a batch of patches and you pulling from my tree.

Yes, that also works.

I think "quilt" is really the right thing here, although stg may be even 
easier due to the more direct git integration. But with a smallish number 
of patches, just doing patch management by hand is obviously simply not a 
huge problem either, so extra tools may just end up confusing the issue.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
