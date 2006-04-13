From: "Cleaveland, AJ Allan @ IS" <Allan.J.Cleaveland@L-3Com.com>
Subject: RE: Hibernate
Date: Thu, 13 Apr 2006 08:19:11 -0500
Message-ID: <7736DD1D5D6EDD4081B590872B56DCCC0C29F91A@gvlexch01.gvl.is.l-3com.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpout1.l-3com.com ([128.170.207.211]:21849 "EHLO
	smtpout1.L-3com.com") by vger.kernel.org with ESMTP id S964925AbWDMNT0
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 09:19:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Nigel Cunningham' <ncunningham@cyclades.com>
Cc: linux-acpi@vger.kernel.org

Nigel,

    Thank you for the suggestion.  I will look into it.  It sounds like it
might work, though since this is likely to be used by us in a variety of
settings, it may also be too restrictive for some of our uses.

Allan

-----Original Message-----
From: Nigel Cunningham [mailto:ncunningham@cyclades.com] 
Sent: Thursday, April 13, 2006 6:27 AM
To: Allan.J.Cleaveland@L-3Com.com
Cc: linux-acpi@vger.kernel.org
Subject: Re: Hibernate


Hi Allan.

On Wednesday 12 April 2006 22:50, Cleaveland, AJ Allan @ IS wrote:
> I'm trying to get hibernate to work on CentOS 4.  What I really want 
> to do is use hibernate to start-up the machine every time.  To do this 
> I would create an "image" to come out of hibernate with and set the 
> machine to always think it's coming out of hibernate, no matter how it 
> was actually shut down.  It would always use my "image", even if it 
> was placed in hibernate when it shut down.  Without rewriting other 
> people's code does anyone know of a way to do this?
>
> Thank you,
> Allan

I'm not sure I understand what you're saying correctly, but it sounds to me 
like you want something like the KeepImage feature in Suspend2. This feature

lets you suspend once, and subsequently simply powerdown rather than 
rewriting the image. To use this mode reliably, any filesystems mounted when

the image is created have to be immutable. This is because the image will 
include information about the filesystems such as superblocks, inodes, 
dentries and so on, and these data structures must match the data on disk.

On resume, you can mount other filesystems (and unmount them prior to
powering 
down again), so it is possible to save state.

Is that the sort of thing you're after? If not, could you give further 
details?

Regards,

Nigel
