From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup() policy inputs
Date: Mon, 28 Apr 2008 15:28:14 -0700
Message-ID: <200804281528.14629.david-b@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net> <1209386885.884.9.camel@yakui_zhao.sh.intel.com> <1209372607.3538.107.camel@rzhang-crestline.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:31730 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933799AbYD1W2R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Apr 2008 18:28:17 -0400
In-Reply-To: <1209372607.3538.107.camel@rzhang-crestline.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Thomas Renninger <trenn@suse.de>

On Monday 28 April 2008, Zhang Rui wrote:
> > > 
> > Yes. What your said is right. If your patch is applied, whether the PCI
> > device can wake the sleeping system is controlled by device driver.
> 
> This may cause some "regressions", something like system resumes
> immediately after enter S3. This should rather be a driver/device
> problem which rises a wake up event when it's suspend.
> The right thing to do is to disable the wake up flag for this device.
> The patch was dropped for this reason last time it's merged and we
> should take good care of it this time. :)
> 
> Dave,
> Maybe we should state this in the change log?

I already seem to have added that in the changelog for the last
version of the patch I sent ...

- dave

