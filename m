From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] thinkpad-acpi late changes for the merge window
Date: Wed, 22 Oct 2008 18:16:08 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810221815230.3010@localhost.localdomain>
References: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37539 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbYJVWS4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2008 18:18:56 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9500K8BV6ZS721@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 22 Oct 2008 17:16:11 -0500 (CDT)
In-reply-to: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

1-4 applied.
(bugzilla version of "attempt to preserve fan state on resume" replaced)

thanks,
-Len


On Sat, 18 Oct 2008, Henrique de Moraes Holschuh wrote:

> 
> Len,
> 
> This patchset has the changes for thinkpad-acpi that I would like to see merged
> for 2.6.28 (while the window is still open).
> 
> It includes the patch for http://bugzilla.kernel.org/show_bug.cgi?id=11331,
> which is the same as the one you already got in acpi-test as far as code goes,
> but it might have differences in the changelog.   If you prefer what you
> already merged into acpi-test, just skip patch 01.
> 
> Please consider sending the patchset to Linus for merge on mainline.
> 
> As usual, available for git pull from:
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test
> 
> Shortlog:
> 
> Henrique de Moraes Holschuh (2):
>       ACPI: thinkpad-acpi: attempt to preserve fan state on resume
>       ACPI: thinkpad-acpi: Remove firmware backlight delays for Intel ACPI IGD OpRegion
> 
> Mariusz Kozlowski (1):
>       ACPI: thinkpad-acpi: trivial fix of error message
> 
> Pascal Terjan (1):
>       ACPI: thinkpad-acpi: Remove duplicate line
> 
> Thank you!
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
