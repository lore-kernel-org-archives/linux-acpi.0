From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OLPC rtc-cmos support
Date: Sun, 8 Jul 2007 13:47:34 -0700
Message-ID: <200707081347.35231.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <200707081210.51145.david-b@pacbell.net> <20070708201747.GA13115@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:46680 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756665AbXGHUrh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2007 16:47:37 -0400
In-Reply-To: <20070708201747.GA13115@dmt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org


> > > +	(void)platform_device_register(&olpc_rtc_device);
> > > +
> > > +	device_init_wakeup(&olpc_rtc_device.dev, 1);
> > 
> > ... do the init_wakeup before registering the device, so
> > there can never be confusion about whether a probe() will
> > see that part of device config ...
> 
> For some reason doing things in that order causes wake_on/wake_off
> to not be called...

I see ... because platform_device_register() will device_initialize()
which clobbers that state, before doing platform_device_add().  I
wonder what bugs are lurking thereby.  :(


> Thanks again for the comments.

This last version looks clean and OK, so long as the driver registers
after that arch_initcall().

Really, no day field in the alarm for that particular southbridge?
Too bad.  And a bit surprising ... I thought current versions of
ACPI required the up-to-one-month enhancement to mc146818.

- Dave

