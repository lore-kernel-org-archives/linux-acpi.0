From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] panasonic-laptop.c: add support for optical drive power
 control
Date: Sun, 05 Apr 2009 00:53:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904050051330.4821@localhost.localdomain>
References: <20090113163233.GA734@dezo.moloch.sk>
 <20090114060834.GN4791@prithivi.gnumonks.org>
 <20090114184227.GC3654@dezo.moloch.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:10563 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZDEExy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Apr 2009 00:53:54 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHM006022X9DD7X@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 04 Apr 2009 23:53:34 -0500 (CDT)
In-reply-to: <20090114184227.GC3654@dezo.moloch.sk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Lucina <mato@kotelna.sk>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org

On Wed, 14 Jan 2009, Martin Lucina wrote:

> Add support for power control of the built in optical drive on models
> with the required ACPI methods present.  Tested on Panasonic CF-W4.
> 
> Creates an interface in /sys/devices/platform/panasonic/cdpower, to
> which you can write "1" to switch the drive on, "0" to switch it off
> or read from to query the current state.
> 
> Signed-off-by: Martin Lucina <mato@kotelna.sk>
> 
> ---
> 
> Harald, this should address all the comments in this thread.  I've
> removed the DMI table and enable the code if _SB.{STAT,FBAY,CDDI} are
> all present.
> 
> I've not figured out how to return an actual error from the sysfs
> show/store functions so I've at least added ACPI_DEBUG_PRINT to print an
> error if the relevant methods fail.
> 
> -mato

Harald,
It's your driver.  What do you what to do with this patch.

I'd delegate http://patchwork.kernel.org/patch/2372/
to you, but you don't seem to have a patchwork account yet.

thanks,
-Len Brown, Intel Open Source Technology Center

