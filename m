From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC 2/5] devcore adds generic wakeup event handler
Date: Wed, 22 Oct 2008 13:24:06 +0800
Message-ID: <20081022052406.GB15271@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com> <20080911063823.083409592@sli10-desk.sh.intel.com> <200810192106.58828.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26612 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbYJVFY2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Oct 2008 01:24:28 -0400
Content-Disposition: inline
In-Reply-To: <200810192106.58828.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "david-b@pacbell.net" <david-b@pacbell.net>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>

On Mon, Oct 20, 2008 at 03:06:58AM +0800, Rafael J. Wysocki wrote:
> On Thursday, 11 of September 2008, Shaohua Li wrote:
> > The default action to handle wakeup event. Currently just prints something,
> > maybe we should call .resume(). The routine will be called in task context.
> >
> > ---
> >  drivers/base/power/main.c |    6 ++++++
> >  include/linux/pm.h        |    2 ++
> >  2 files changed, 8 insertions(+)
> >
> > Index: linux/drivers/base/power/main.c
> > ===================================================================
> > --- linux.orig/drivers/base/power/main.c      2008-09-11 10:56:26.000000000 +0800
> > +++ linux/drivers/base/power/main.c   2008-09-11 10:56:39.000000000 +0800
> > @@ -785,3 +785,9 @@ void __suspend_report_result(const char
> >       }
> >  }
> >  EXPORT_SYMBOL_GPL(__suspend_report_result);
> > +
> > +void device_receive_wakeup_event(struct device *dev)
> > +{
> > +     printk("Device %s invokes wakeup event\n", dev->bus_id);
> > +}
> > +EXPORT_SYMBOL(device_receive_wakeup_event);
> > Index: linux/include/linux/pm.h
> > ===================================================================
> > --- linux.orig/include/linux/pm.h     2008-09-11 10:56:29.000000000 +0800
> > +++ linux/include/linux/pm.h  2008-09-11 10:56:39.000000000 +0800
> > @@ -440,6 +440,8 @@ static inline int device_suspend(pm_mess
> >
> >  #endif /* !CONFIG_PM_SLEEP */
> >
> > +void device_receive_wakeup_event(struct device *dev);
> > +
> >  /*
> >   * Global Power Management flags
> >   * Used to keep APM and ACPI from both being active
> 
> Do you anticipate any particular use of this function?
maybe calls .resume() to wakeup a device.
