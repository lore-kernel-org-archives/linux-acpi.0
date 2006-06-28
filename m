From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: Acer smart battery: acpi_sbs and linux-2.6.17
Date: Wed, 28 Jun 2006 11:43:50 +0200
Message-ID: <m23bdpeht5.fsf@phoenix.squirrel.nl>
References: <449F18D9.7060507@rrz.uni-koeln.de>
	<m2zmfyykrz.fsf@phoenix.squirrel.nl>
	<m2veqmy6eb.fsf@phoenix.squirrel.nl>
	<44A1AF40.3020701@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:47368 "EHLO
	smtp-vbr16.xs4all.nl") by vger.kernel.org with ESMTP
	id S1030499AbWF1Jnw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jun 2006 05:43:52 -0400
Received: from phoenix.squirrel.nl (sioban.xs4all.nl [82.92.147.177])
	by smtp-vbr16.xs4all.nl (8.13.6/8.13.6) with ESMTP id k5S9ho5K054186
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jun 2006 11:43:51 +0200 (CEST)
	(envelope-from jv@squirrel.nl)
In-Reply-To: <44A1AF40.3020701@rrz.uni-koeln.de> (Berthold Cogel's message
 of "Wed, 28 Jun 2006 00:20:48 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Berthold Cogel <cogel@rrz.uni-koeln.de> writes:

>> But I seem to have lost the ability to hibernate/resume. I consistently
>> get "swsusp: not enough free memory". Does 2.6.17 take so much more
>> memory than 2.6.16?
>
> For my System it's only about 1 MB difference in runlevel 1 with
> 2.6.17.1 compared with 2.6.16.20.

I've gone back to 2.6.16, and didn't notice a significant difference
in 'free' figures so the size increment is probably neglectible.
But I can only hibernate when I stop X first, while with 2.6.16 I'm
could hibernate with a fully loaded (X, WM, Emacs, Xterms) system.

BTW I hibernate with 

  cd /sys/power; echo shutdown > disk; echo disk > state

I don't use the pm-hibernate program (doesn't seem to make a
difference, except that I cannot choose a kernel upon boot).

> But I'm using suspend to disk with suspend2.

I've been told that swsusp2 and swsusp share the same memory
limitation: at least half of the memory must be freeable for suspend
to be able to continue. But it could be a problem with swsusp that it
somehow isn't able to free enough memory.

Since 2.6.16 swsusp does everything I need, I never tried swsusp2.
Last time I looked it seemed work in fast progress, much like a moving
target. Besides I'd like to stick as closely as possible to my
standard Fedora kernel so I can still use the prebuilt kernel modules.

-- Johan
