From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad-acpi: setup hotkey polling after changing
 hotkey_driver_mask
Date: Mon, 8 Feb 2010 22:37:06 -0200
Message-ID: <20100209003706.GC21680@khazad-dum.debian.net>
References: <1265567528-1180-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38885 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281Ab0BIAhJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2010 19:37:09 -0500
Content-Disposition: inline
In-Reply-To: <1265567528-1180-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 07 Feb 2010, Thadeu Lima de Souza Cascardo wrote:
> Brightness notification does not work until the user writes to
> hotkey_mask attribute. That's because the polling thread will only run

Hmm, maybe this has something to do with it...
http://bugzilla.kernel.org/show_bug.cgi?id=15118

> if hotkey_user_mask is set and someone is reading the input device or if
> hotkey_driver_mask is set. In this second case, this condition is not
> tested after the mask is changed, because the brightness and volume
> drivers are started after the hotkey drivers.
> 
> This fix test for the polling condition that ends up starting the
> polling thread after hotkey_driver_mask is set in brightness and volume
> init functions.

tpacpi_hotkey_driver_mask_set() has to do whatever is required to get the
events to work.

I am looking into this problem now.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
