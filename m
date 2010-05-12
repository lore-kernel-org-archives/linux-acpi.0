From: Len Brown <lenb@kernel.org>
Subject: Re: Automatic S1 sleep
Date: Wed, 12 May 2010 01:57:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005120133190.5297@localhost.localdomain>
References: <4BE97FC9.4040302@cfl.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:38142 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab0ELF6T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2010 01:58:19 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2A00AMXLWGN4X8@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 May 2010 00:57:52 -0500 (CDT)
In-reply-to: <4BE97FC9.4040302@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-acpi@vger.kernel.org

> I have been looking into the possibility of having the system
> automatically enter and exit S1 to save power when idle, but actively in
> use. For instance, while you are only browsing the web on your laptop,
> your eyes spend 15 seconds scanning the page while the system is
> otherwise, doing nothing but wait for your next input.  It would be nice
> if it could seamlessly enter S1 during this time to save power, and exit
> when you press a key, move the mouse, or receive a message on IRC.
>
> Unlike S3, S1 keeps the Vcc power plane on and all devices remain in D0
> or D1, so the screen remains on and visible, so it should be possible to
> use this state transparently without the user even being aware of it.
> Since everything remains on, no hardware needs reinitialized when
> resuming from S1.

I'm not aware of any ACPI systems that can keep the display enabled
when in S1 (or S3).  If you've been able to get into this state,
I'd like to know more about it.

Please measure the power difference between S0 and S1 -- don't assume
that S1 consumes less power than S0.  Also, note that the latency
difference between S1 and S3 may effectively be 0.

cheers
-Len Brown, Intel Open Source Technology Center
