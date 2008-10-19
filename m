From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 2/5] devcore adds generic wakeup event handler
Date: Sun, 19 Oct 2008 21:06:58 +0200
Message-ID: <200810192106.58828.rjw@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com> <20080911063823.083409592@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43084 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbYJSTC1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 15:02:27 -0400
In-Reply-To: <20080911063823.083409592@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, david-b@pacbell.net, dbrownell@users.sourceforge.net

On Thursday, 11 of September 2008, Shaohua Li wrote:
> The default action to handle wakeup event. Currently just prints something,
> maybe we should call .resume(). The routine will be called in task context.
> 
> ---
>  drivers/base/power/main.c |    6 ++++++
>  include/linux/pm.h        |    2 ++
>  2 files changed, 8 insertions(+)
> 
> Index: linux/drivers/base/power/main.c
> ===================================================================
> --- linux.orig/drivers/base/power/main.c	2008-09-11 10:56:26.000000000 +0800
> +++ linux/drivers/base/power/main.c	2008-09-11 10:56:39.000000000 +0800
> @@ -785,3 +785,9 @@ void __suspend_report_result(const char 
>  	}
>  }
>  EXPORT_SYMBOL_GPL(__suspend_report_result);
> +
> +void device_receive_wakeup_event(struct device *dev)
> +{
> +	printk("Device %s invokes wakeup event\n", dev->bus_id);
> +}
> +EXPORT_SYMBOL(device_receive_wakeup_event);
> Index: linux/include/linux/pm.h
> ===================================================================
> --- linux.orig/include/linux/pm.h	2008-09-11 10:56:29.000000000 +0800
> +++ linux/include/linux/pm.h	2008-09-11 10:56:39.000000000 +0800
> @@ -440,6 +440,8 @@ static inline int device_suspend(pm_mess
>  
>  #endif /* !CONFIG_PM_SLEEP */
>  
> +void device_receive_wakeup_event(struct device *dev);
> +
>  /*
>   * Global Power Management flags
>   * Used to keep APM and ACPI from both being active

Do you anticipate any particular use of this function?

Rafael
