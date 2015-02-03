From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V2] acpi:apd:add AMD ACPI2Platform device support for x86
 system.
Date: Tue, 3 Feb 2015 11:53:07 +0200
Message-ID: <20150203095307.GB1465@lahna.fi.intel.com>
References: <1422870652.2528.6.camel@kxue-X58A-UD3R>
 <20150202130356.GS22740@lahna.fi.intel.com>
 <1422925495.2528.12.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30077 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbbBCJxM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Feb 2015 04:53:12 -0500
Content-Disposition: inline
In-Reply-To: <1422925495.2528.12.camel@kxue-X58A-UD3R>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Xue <Ken.Xue@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Feb 03, 2015 at 09:04:55AM +0800, Ken Xue wrote:
> as you said, platform_drv_probe calls dev_pm_domain_attach(). but
> platform_drv_probe just is a default probe routine. Not all platform
> device drivers use this probe routine. so, codes here may be still
> necessary.

Are you saying that for platform devices there is some other path to get
a driver probed, other than platform_drv_probe()? Can you point me to
it?
