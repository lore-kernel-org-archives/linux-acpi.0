From: Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH V2] acpi:apd:add AMD ACPI2Platform device support for
 x86 system.
Date: Tue, 3 Feb 2015 17:55:25 +0800
Message-ID: <1422957325.18208.13.camel@kxue-X58A-UD3R>
References: <1422870652.2528.6.camel@kxue-X58A-UD3R>
	 <20150202130356.GS22740@lahna.fi.intel.com>
	 <1422925495.2528.12.camel@kxue-X58A-UD3R>
	 <20150203095307.GB1465@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150203095307.GB1465@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2015-02-03 at 11:53 +0200, mika.westerberg@linux.intel.com
wrote:
> On Tue, Feb 03, 2015 at 09:04:55AM +0800, Ken Xue wrote:
> > as you said, platform_drv_probe calls dev_pm_domain_attach(). but
> > platform_drv_probe just is a default probe routine. Not all platform
> > device drivers use this probe routine. so, codes here may be still
> > necessary.
> 
> Are you saying that for platform devices there is some other path to get
> a driver probed, other than platform_drv_probe()? Can you point me to
> it?
>From the codes, i can see there is a possibility that drv->driver.probe
may not be set in __platform_driver_register. But i really can not point
out a use case that platform device driver without probe.
so, it is safe to remove "dev_pm_domain_attach" in
"acpi_apd_platform_notify". right?
