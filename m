From: Len Brown <lenb@kernel.org>
Subject: Re: Power button not working on T61
Date: Fri, 10 Oct 2008 23:56:50 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810102352120.7059@localhost.localdomain>
References: <200810101319.52021.hanno@hboeck.de>
 <alpine.LFD.1.10.0810101140310.3131@localhost.localdomain>
 <200810101938.51573.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:64412 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbYJKD4y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 23:56:54 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K8K008CF2YTJ0O0@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Oct 2008 22:56:53 -0500 (CDT)
In-reply-to: <200810101938.51573.dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-15?Q?Hanno_B=F6ck?= <hanno@hboeck.de>, acpi@linux.intel.com, linux-acpi@vger.kernel.org



> You must have CONFIG_SYSFS_DEPRECIATED set, this would explain the
> difference in sysfs paths. 

yes.

turns out that was a red herring, for Hanno reports:

> It never "worked".
>
> The issue is "resolved" now, someone told me that one has to
> press about 2 sec on the button to generate an acpi event.
> This is probably caused by the bios and not fixable outside the bios.

yes, i've noticed that the button has to be held for a bit
(or pressed hard) on the T61.  I assume this is an EC thing.

-Len

