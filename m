From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/7] ACPI: thinkpad-acpi: add brightness_force parameter
Date: Tue, 30 Oct 2007 17:55:14 -0200
Message-ID: <20071030195514.GA17225@khazad-dum.debian.net>
References: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br> <1193773585-17202-4-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36628 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752451AbXJ3TzS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 15:55:18 -0400
Content-Disposition: inline
In-Reply-To: <1193773585-17202-4-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 30 Oct 2007, Henrique de Moraes Holschuh wrote:
> Add a "brightness_force" module parameter that allows the local admin to
> force the backlight support to not be enabled.

Err, brightness_enable.  The patch is correct, though.  I will send an
updated one which fixes the description, just in case.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
