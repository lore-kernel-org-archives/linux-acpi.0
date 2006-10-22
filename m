From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] do not compile Sony Vaio extras as a module per default
Date: Sun, 22 Oct 2006 12:54:30 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0610221254220.3696@yvahk01.tjqt.qr>
References: <20061022063924.GA7177@gollum.tnic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:39554 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932363AbWJVK4L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Oct 2006 06:56:11 -0400
In-Reply-To: <20061022063924.GA7177@gollum.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: petkov@math.uni-muenster.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


>--- current/drivers/acpi/Kconfig.orig	2006-10-21 10:02:23.000000000 +0200
>+++ current/drivers/acpi/Kconfig	2006-10-21 10:02:30.000000000 +0200
>@@ -262,7 +262,6 @@ config ACPI_SONY
> 	tristate "Sony Laptop Extras"
> 	depends on X86 && ACPI
> 	select BACKLIGHT_CLASS_DEVICE
>-	default m
> 	  ---help---
> 	  This mini-driver drives the ACPI SNC device present in the
> 	  ACPI BIOS of the Sony Vaio laptops.

Reason?


	-`J'
-- 
