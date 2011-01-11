From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: Make cpuidle_enable_device() call poll_idle_init()
Date: Tue, 11 Jan 2011 01:02:22 +0100
Message-ID: <201101110102.22204.rjw@sisk.pl>
References: <201101080029.20744.rjw@sisk.pl> <alpine.LFD.2.02.1101101754320.7945@x980>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48219 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903Ab1AKACp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jan 2011 19:02:45 -0500
In-Reply-To: <alpine.LFD.2.02.1101101754320.7945@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>

On Tuesday, January 11, 2011, Len Brown wrote:
> >  /**
> >   * cpuidle_enable_device - enables idle PM for a CPU
> >   * @dev: the CPU
> > @@ -176,6 +215,8 @@ int cpuidle_enable_device(struct cpuidle
> >  		ret = __cpuidle_register_device(dev);
> >  		if (ret)
> >  			return ret;
> > +	} else {
> > +		poll_idle_init(dev);
> >  	}
> 
> how about calling poll_idle_init() unconditionally here
> and deleting the call to it from within __cpuidle_register_device()?

Fine by me, as long as poll_idle_init() is called before the conditional. :-)

Thanks,
Rafael
