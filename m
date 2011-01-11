From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpuidle: Make cpuidle_enable_device() call poll_idle_init()
Date: Tue, 11 Jan 2011 10:37:00 +0100
Message-ID: <201101111037.00543.trenn@suse.de>
References: <201101080029.20744.rjw@sisk.pl> <201101110102.22204.rjw@sisk.pl> <201101110105.54166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57770 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015Ab1AKJhD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Jan 2011 04:37:03 -0500
In-Reply-To: <201101110105.54166.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

On Tuesday 11 January 2011 01:05:53 Rafael J. Wysocki wrote:
> On Tuesday, January 11, 2011, Rafael J. Wysocki wrote:
> > On Tuesday, January 11, 2011, Len Brown wrote:
> > > >  /**
> > > >   * cpuidle_enable_device - enables idle PM for a CPU
> > > >   * @dev: the CPU
> > > > @@ -176,6 +215,8 @@ int cpuidle_enable_device(struct cpuidle
> > > >  		ret = __cpuidle_register_device(dev);
> > > >  		if (ret)
> > > >  			return ret;
> > > > +	} else {
> > > > +		poll_idle_init(dev);
> > > >  	}
> > > 
> > > how about calling poll_idle_init() unconditionally here
> > > and deleting the call to it from within __cpuidle_register_device()?
> > 
> > Fine by me, as long as poll_idle_init() is called before the conditional. :-)
> 
> In fact, it even doesn't need to be called before the conditional.
> 
> So fine by me anyway.
What exactly was broken?
Is it only sysfs values?
Looks like an uninitialized "poll" state can cause cpuidle
to not enter "poll" state when it should or enter "poll" when
it should not.
Hm, if cpuidle would try to call state[0]->enter,
it might even segfault?
Even not that many machines might be affected because most won't
implement runtime C-state changes, shouldn't this still be
submitted for stable@ kernels?

Thanks,

    Thomas
