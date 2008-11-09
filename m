From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [GIT PATCH] thinkpad-acpi regression fix for
	2.6.28-rc
Date: Sun, 9 Nov 2008 11:22:44 -0200
Message-ID: <20081109132244.GA12794@khazad-dum.debian.net>
References: <20081109113011.GB8329@khazad-dum.debian.net> <1226235242-11130-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:46898 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730AbYKINWs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Nov 2008 08:22:48 -0500
Content-Disposition: inline
In-Reply-To: <1226235242-11130-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 09 Nov 2008, Henrique de Moraes Holschuh wrote:
> This patch should fix a reported regression on fan_resume (not
> on bugzilla, report on the LKML and ibm-acpi-devel).

Spoke too soon.  Bugzilla #11982.  I've sent the patch there as well.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
