From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull request] ACPI patches for 2.6.34-rc6
Date: Sat, 08 May 2010 01:19:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005080112300.5996@localhost.localdomain>
References: <alpine.LFD.2.00.1005062216430.10792@localhost.localdomain>
 <201005080117.23760.rjw@sisk.pl>
 <alpine.LFD.2.00.1005071618410.901@i5.linux-foundation.org>
 <201005080203.30634.rjw@sisk.pl>
 <alpine.LFD.2.00.1005071708010.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <alpine.LFD.2.00.1005071708010.901@i5.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

> On Sat, 8 May 2010, Rafael J. Wysocki wrote:
> > 
> > To calrify, I think the approach in the Matthew's patch is correct, but since I have
> > some bad experience with that particular thing, I prefer to make that change in
> > 2.6.35 and then move on to drop the flag entirely.
> 
> Oh,yes. I'm not suggesting we do it late in the -rc cycle. 
> 
> I just don't think the DMI table is a good idea, so in the longer run I 
> wan tto get rid of it, rather than have it grow (by quite a few entries, 
> in this case).
> 
> There are valid reasons for DMI tables in many cases, but in this case I 
> think the reason is simply that we do the wrong thing, so then we ended up 
> with a DMI table to "fix" the wrong thing we do.

Hi Linus,
Matthew, Rafael and I all agree with you on every aspect of this issue.

The DMI list is temporary.  Matthew's patch to do as you say
is already queued for 2.6.35.

I belive that Rafael was prudent in recommending we delay
the "real" fix until .35, as we discovered that the broken
machines suffered a 3-second delay on resume, polling for the SCI_EN
that the BIOS would never set, and so the proposed fix for that 
is queued for 2.6.35 as well.

thanks,
-Len
