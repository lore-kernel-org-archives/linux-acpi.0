From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] thinkpad-acpi queue for 2.6.30
Date: Sat, 04 Apr 2009 03:36:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904040336400.16220@localhost.localdomain>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:30601 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbZDDHg4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 03:36:56 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHK00E7NFTEA2YI@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 04 Apr 2009 02:36:51 -0500 (CDT)
In-reply-to: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Sat, 4 Apr 2009, Henrique de Moraes Holschuh wrote:

> Len,
> 
> This patchset has the changes for thinkpad-acpi that I would like to
> see merged for 2.6.30 (while the window is still open).
> 
> It contains the patch for
> http://bugzilla.kernel.org/show_bug.cgi?id=11750, and a few
> enhancements.
> 
> Shortlog:
> 
> Henrique de Moraes Holschuh (12):
>       thinkpad-acpi: update copyright notices
>       thinkpad-acpi: drop ibm-acpi alias
>       thinkpad-acpi: documentation cleanup
>       thinkpad-acpi: cleanup debug helpers
>       thinkpad-acpi: add missing log levels
>       thinkpad-acpi: add new debug helpers and warn of deprecated atts
>       thinkpad-acpi: remove HKEY disable functionality
>       thinkpad-acpi: restrict access to some firmware LEDs
>       thinkpad-acpi: enhanced debugging messages for rfkill subdrivers
>       thinkpad-acpi: enhanced debugging messages for the hotkey subdriver
>       thinkpad-acpi: enhanced debugging messages for the fan subdriver
>       thinkpad-acpi: rework brightness support
> 
> -- 
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
