From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/6] thinkpad-acpi: add internal hotkey event API
Date: Wed, 10 Mar 2010 17:33:21 -0300
Message-ID: <20100310203321.GC21704@khazad-dum.debian.net>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
 <1253466567-4285-6-git-send-email-hmh@hmh.eng.br>
 <alpine.LFD.2.00.0909201410000.2492@sony>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33475 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757004Ab0CJUd1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Mar 2010 15:33:27 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0909201410000.2492@sony>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, 21 Sep 2009, Len Brown wrote:
> drivers/platform/x86/thinkpad_acpi.c:2224: warning: 
> ?tpacpi_hotkey_driver_mask_set? defined but not used

Yeah, the patch that uses that lost the 2.6.32 merge window (it was to go in
through the backlight tree) and ended up merged in 2.6.33.

Since it is something we need in 2.6.32-stable to help userspace, I will try
to get it in through -stable.  But I am waiting for the current stable queue
to drain first, as there are some thinkpad-acpi bug fixes in it.  When those
are in, I will try to queue the backlight events patch (that uses
tpacpi_hotkey_driver_mask_set()).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
