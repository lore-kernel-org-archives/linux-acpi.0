From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/7] acer-wmi patches for 2.6.27
Date: Thu, 26 Jun 2008 00:23:56 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806260022540.3279@localhost.localdomain>
References: <20080621080903.26920.14225.stgit@pacifica>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:62870 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbYFZEYL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2008 00:24:11 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K31001EHYW18829@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Jun 2008 23:24:02 -0500 (CDT)
In-reply-to: <20080621080903.26920.14225.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org



> The following series is the latest set of updates for acer-wmi.
> 
> For the most part, these are just a few minor tweaks, fixes for Fujitsu Siemens laptops,
> and the addition of some debugfs output for future reverse engineering.
> 
> -Carlos
> ---
> 
> Carlos Corbacho (7):
>       acer-wmi: Remove version number
>       acer-wmi: Add debugfs file for device detection
>       acer-wmi: Disable device autodetection on Fujitsu Siemens Amilo Li2732
>       acer-wmi: Add EC quirk for Fujitsu Siemens Amilo Li 1718
>       acer-wmi: Respect framebuffer blanking in backlight
>       acer-wmi: Blacklist backlight on Acer Aspire 1520 & 1360 series
>       acer-wmi: Remove LED colour comment from documentation
> 
> 
>  Documentation/laptops/acer-wmi.txt |    2 
>  drivers/misc/acer-wmi.c            |  145 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 135 insertions(+), 12 deletions(-)
> 

Thanks Carolos,
1-7 applied to acpi-test.

-len

