From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch 2.6.21-rc5-git 1/3] new platform_enable_wake() hook; use it in PCI
Date: Mon, 23 Apr 2007 12:51:06 +0000
Message-ID: <20070423125106.GA4077@ucw.cz>
References: <200704051248.56703.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3660 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161522AbXDWMvU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Apr 2007 08:51:20 -0400
Content-Disposition: inline
In-Reply-To: <200704051248.56703.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

Hi!

>  static inline int device_suspend(pm_message_t state)
> --- g26.orig/drivers/base/power/main.c	2007-04-04 13:03:33.000000000 -0700
> +++ g26/drivers/base/power/main.c	2007-04-04 13:03:34.000000000 -0700
> @@ -29,6 +29,9 @@ LIST_HEAD(dpm_off_irq);
>  DECLARE_MUTEX(dpm_sem);
>  DECLARE_MUTEX(dpm_list_sem);
>  
> +int (*platform_enable_wakeup)(struct device *dev, int is_on) = NULL;

Static variables do not need zero initializers.

Otherwise it looks ok.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
