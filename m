From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [GIT PATCH] thinkpad-acpi changes for 2.6.27 merge window
Date: Sun, 20 Jul 2008 23:16:41 -0300
Message-ID: <20080721021641.GA8435@khazad-dum.debian.net>
References: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:57498 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758753AbYGUCQv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jul 2008 22:16:51 -0400
Content-Disposition: inline
In-Reply-To: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Tue, 01 Jul 2008, Henrique de Moraes Holschuh wrote:
> It depends on the rfkill changes in net-next-2.6 (already in
> linux-next).  Usually, I provide a git tree for pulling and also send
> the patches.  Due to the linux-next dependency, this one is going out
> just as patches.
> 
> Please stage these patches for merging during the 2.6.27 merge window or
> on early -rc1, AFTER the rfkill changes land in mainline.

FYI, the rfkill changes that this patchset need have been merged in mainline
a few hours ago.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
