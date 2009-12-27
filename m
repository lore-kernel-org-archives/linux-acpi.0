From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] thinkpad-acpi fixes for 2.6.32-rc2
Date: Sat, 26 Dec 2009 22:41:40 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912262241330.14053@localhost.localdomain>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:41591 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZL0Dlz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2009 22:41:55 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVA0008KKXHOYDE@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 26 Dec 2009 21:41:42 -0600 (CST)
In-reply-to: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

applied to acpi-test

thanks,
Len Brown, Intel Open Source Technology Center

On Sat, 26 Dec 2009, Henrique de Moraes Holschuh wrote:

> Len,
> 
> This patchset fixes a few problems that have been reported,
> including the annoying build problem reported by Ingo.
> 
> It mostly updates the new ALSA functionality to be better
> behaved, and makes it optional for people who could care
> less for on-screen-display of volume hotkeys and would
> rather have a kernel that is a few kiB smaller.
> 
> Please apply.
> 
> Thanks.
> 
> Shortlog:
> Henrique de Moraes Holschuh (5):
>       thinkpad-acpi: don't take the first ALSA slot by default
>       thinkpad-acpi: don't fail to load the entire module due to ALSA problems
>       thinkpad-acpi: make volume subdriver optional
>       thinkpad-acpi: update volume documentation
>       thinkpad-acpi: improve Kconfig help text
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
