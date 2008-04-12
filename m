From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 08/13] ACPI: thinkpad-acpi: add sysfs led class support
	for thinklight (v3.1)
Date: Sat, 12 Apr 2008 11:51:53 -0300
Message-ID: <20080412145153.GH3402@khazad-dum.debian.net>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br> <1207799585-10112-9-git-send-email-hmh@hmh.eng.br> <20080411172402.a863c6c7.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51118 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752602AbYDLOv4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Apr 2008 10:51:56 -0400
Content-Disposition: inline
In-Reply-To: <20080411172402.a863c6c7.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Fri, 11 Apr 2008, Randy Dunlap wrote:
> Well, I would really prefer that we call LEDs "LED" instead of "led"
> in user documentation.

Needs an extra patch, since I already have lowercase led in
Documentation/laptop/thinkpad-acpi.txt, and it doesn't make sense to not
change them all.

Instead of changing this patch, I will just add a "LED" uppercase fix
patch to fix everything in one go.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
