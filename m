From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] thinkpad-acpi queue for 2.6.31
Date: Wed, 17 Jun 2009 22:50:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906172249200.8921@localhost.localdomain>
References: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:34418 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbZFRCvU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2009 22:51:20 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLE00A8IYL0UMV1@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 17 Jun 2009 21:51:02 -0500 (CDT)
In-reply-to: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Sat, 30 May 2009, Henrique de Moraes Holschuh wrote:

> Len,
> 
> This patchset has some changes for thinkpad-acpi that I would like to see
> merged for 2.6.31.   I will likely have a few more during the merge
> window.
> 
> Shortlog:
> 
> Henrique de Moraes Holschuh (5):
>       thinkpad-acpi: store fw version with strict checking
>       thinkpad-acpi: add quirklist engine
>       thinkpad-acpi: fix BEEP ACPI handler warnings
>       thinkpad-acpi: enhance led support
>       thinkpad-acpi: silence bogus warning when ACPI video is disabled
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
