From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] do not compile Sony Vaio extras as a module per default
Date: Sun, 22 Oct 2006 09:10:54 -0700
Message-ID: <20061022091054.3fc8596b.rdunlap@xenotime.net>
References: <20061022063924.GA7177@gollum.tnic>
	<Pine.LNX.4.61.0610221254220.3696@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:3483 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751136AbWJVQJT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Oct 2006 12:09:19 -0400
Received: from midway.site ([71.117.236.95]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sun, 22 Oct 2006 09:09:15 -0700
In-Reply-To: <Pine.LNX.4.61.0610221254220.3696@yvahk01.tjqt.qr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: petkov@math.uni-muenster.de, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 22 Oct 2006 12:54:30 +0200 (MEST) Jan Engelhardt wrote:

> 
> >--- current/drivers/acpi/Kconfig.orig	2006-10-21 10:02:23.000000000 +0200
> >+++ current/drivers/acpi/Kconfig	2006-10-21 10:02:30.000000000 +0200
> >@@ -262,7 +262,6 @@ config ACPI_SONY
> > 	tristate "Sony Laptop Extras"
> > 	depends on X86 && ACPI
> > 	select BACKLIGHT_CLASS_DEVICE
> >-	default m
> > 	  ---help---
> > 	  This mini-driver drives the ACPI SNC device present in the
> > 	  ACPI BIOS of the Sony Vaio laptops.
> 
> Reason?

This is the third such patch/request that I recall for this
one.  It's =m for Andrew (one of his machines).
Otherwise the patch makes sense and should be merged...

---
~Randy
