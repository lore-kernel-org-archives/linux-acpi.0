From: Len Brown <lenb@kernel.org>
Subject: Re: How to help with sony-laptop on Vaio VGN-TT11
Date: Thu, 08 Jan 2009 15:35:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901081534190.4505@localhost.localdomain>
References: <496634F2.3080505@iworks.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:50952 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427AbZAHUf4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 15:35:56 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD600EXO6JEP1N0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 08 Jan 2009 14:35:44 -0600 (CST)
In-reply-to: <496634F2.3080505@iworks.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Wallner <mike@iworks.at>
Cc: linux-acpi@vger.kernel.org

On Thu, 8 Jan 2009, Michael Wallner wrote:

> Hi,
> 
> I own a new Sony Vaio VGN-TT11 laptop and wonder how I could help to
> make sony-laptop better support this model.  Where to go from here?
> 
> I'm especially interested in getting the backlight to work as I'm unable
> to work with Linux on this machine unless I would like to become blind.
> 
> Thanks a lot,
> Mike

I've recently got a VGN-z540 and was impressed at how bright it is too:-)

they hotkeys do not work,
however, echo into /sys/class/backlight/*/brightness files works,
do you have those files?

cheers,
Len Brown, Intel Open Source Technology Center
