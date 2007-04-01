From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Sun, 1 Apr 2007 19:46:25 -0300
Message-ID: <20070401224625.GB28561@khazad-dum.debian.net>
References: <460E0158.7090705@goop.org> <8f8ff01d0703310033y74421cfcl747ece1be003471@mail.gmail.com> <460F511E.2090102@goop.org> <20070401163204.GB5762@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:32954 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752776AbXDAWq2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Apr 2007 18:46:28 -0400
Content-Disposition: inline
In-Reply-To: <20070401163204.GB5762@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Alexey Starikovskiy <aystarik@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sun, 01 Apr 2007, Pavel Machek wrote:
> ACPI is misdesigned, and lm_sensors can't cope with that.

Err, HOW exactly are you accessing the ThinkPad i2c buses directly? Or did
Lenovo change completely the hardware project of thinkpads in the X60?

Or did anyone add an lm-sensors that attach to the ACPI EC ports now?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
