From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v1 0/4] ACPI / LPSS: fix system hangup on BYT
Date: Fri, 07 Nov 2014 17:30:42 +0100
Message-ID: <545CF3B2.3000101@intel.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>	 <2488602.4jdJudSMmE@vostro.rjw.lan> <1415367994.472.25.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37925 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbaKGQaq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2014 11:30:46 -0500
In-Reply-To: <1415367994.472.25.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Scott Ashcroft <scott.ashcroft@talk21.com>, Mika Westerberg <mika.westerberg@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>

On 11/7/2014 2:46 PM, Andy Shevchenko wrote:
> On Fri, 2014-11-07 at 01:37 +0100, Rafael J. Wysocki wrote:
>> On Wednesday, November 05, 2014 06:34:44 PM Andy Shevchenko wrote:
>>> The Intel BayTrail based machines have different configuration of the Low Power
>>> Sub System (LPSS) IP. The LPSS contains few host controllers, such as I2C, SPI,
>>> I2C and common DMA IP to serve DMA transfers. Unfortunately the DMA IP has no
>>> power control accessible for software / OS. It goes automatically down whenever
>>> last device goes to sleep and turned on when one of them is turned on. When
>>> user tries to access the powered off DMA device the system hangs.
>>>
>>> This patch series addressing the issue. Rafael suggested to create a 'proxy'
>>> device which makes DMA to be powered on on the certain points of time.
>>>
>>> Vinod, we would like to push this via Rafael's tree, so, please Ack or NAck the
>>> patch 4/4.
>>>
>>> Scott, do you have a chance to test this patch series against last linux-pm
>>> tree on HP laptops? I would appreciate your Tested-by tag.
>>>
>>> Andy Shevchenko (4):
>>>    ACPI / LPSS: add all LPSS devices to the specific power domain
>>>    ACPI / LPSS: allow to use specific PM domain during ->probe()
>>>    ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA
>>>    dmaengine: dw: enable runtime PM
>> I'm essentially fine with this series, but I'm not sure what the status of
>> the Scott's testing is.  Can you please tell me and Scott what in particular
>> you wanted him to test?
> He complained that HP laptop didn't reboot nicely and hangs the system
> until he blacklisted dw_dmac driver.
>

The patch series fixes runtime PM, though, so how is that related to 
reboot exactly?

Rafael

