From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch 2.6.21-rc5-git 1/3] new platform_enable_wake() hook; use it in PCI
Date: Mon, 23 Apr 2007 07:23:33 -0700
Message-ID: <200704230723.33239.david-b@pacbell.net>
References: <200704051248.56703.david-b@pacbell.net> <20070423125106.GA4077@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:38381 "HELO
	smtp110.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750844AbXDWOe4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Apr 2007 10:34:56 -0400
In-Reply-To: <20070423125106.GA4077@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Monday 23 April 2007, Pavel Machek wrote:
> Hi!
> 
> >  static inline int device_suspend(pm_message_t state)
> > --- g26.orig/drivers/base/power/main.c	2007-04-04 13:03:33.000000000 -0700
> > +++ g26/drivers/base/power/main.c	2007-04-04 13:03:34.000000000 -0700
> > @@ -29,6 +29,9 @@ LIST_HEAD(dpm_off_irq);
> >  DECLARE_MUTEX(dpm_sem);
> >  DECLARE_MUTEX(dpm_list_sem);
> >  
> > +int (*platform_enable_wakeup)(struct device *dev, int is_on) = NULL;
> 
> Static variables do not need zero initializers.

That was resolved by a cleanup patch; also a glitch when
building without CONFIG_PM.

- dave
