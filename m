From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] sony-laptop/thinkpad-acpi: fix build error
Date: Tue, 18 Sep 2007 01:01:57 -0300
Message-ID: <20070918040157.GB10427@khazad-dum.debian.net>
References: <20070917205434.GA22458@devil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40741 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750727AbXIRECA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 00:02:00 -0400
Content-Disposition: inline
In-Reply-To: <20070917205434.GA22458@devil>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Herrmann <aherrman@arcor.de>
Cc: Len Brown <len.brown@intel.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Mon, 17 Sep 2007, Andreas Herrmann wrote:
> sony-laptop and thinkpad-acpi make use of input-core functions.
> Hence you get link errors if those drivers are built but CONFIG_INPUT
> is not set. Attached patch fixes this minor issue.

[...]

> @@ -156,6 +157,7 @@ config THINKPAD_ACPI
>  	select BACKLIGHT_CLASS_DEVICE
>  	select HWMON
>  	select NVRAM
> +	select INPUT
>  	---help---
>  	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
>  	  support for Fn-Fx key combinations, Bluetooth control, video

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
