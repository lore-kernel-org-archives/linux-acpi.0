From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 00:06:11 +0100
Message-ID: <20060108230611.GP3774@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601081111190.3169-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 08, 2006 at 11:41:28AM -0800, Linus Torvalds wrote:
>...
> What I object to is that there were _also_ two automated merges within ten 
> hours or each other, with absolutely _zero_ development in your tree in 
> between. Why did you do that in your development tree? By _definition_ you 
> had done zero development. You just tracked the development in _my_ tree.
>...

My impression is that you and Len are talking at different levels.

I can't speak for Len, but let me try to describe a problem in this area 
I don't know the solution for:

Consider I want to do the following:
1. update my tree daily from your tree
2. include 10 patches per week into my tree
3. ask you once a month to pull from my tree

How should step 1 be done?

In CVS, I'd do a "cvs update -dP ."
In cogito, the equivalent command seems to be "cg-update".

CVS has no problems if I have changed MAINTAINERS in one place and it 
changes daily in your tree in other places, but how do I do the same in 
git/cogito without creating the merges you don't want to see?

The solution might be described somewhere in TFM, but this is the class 
of problems people like me run into when the goal is simply a git tree 
to both track your tree and send changes to you without any interest in 
advanced SCM knowledge.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
