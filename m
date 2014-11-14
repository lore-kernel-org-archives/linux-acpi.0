From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 0/4] ACPI / LPSS: fix system hangup on BYT
Date: Sat, 15 Nov 2014 00:27:53 +0100
Message-ID: <6931265.npcFGj0zDg@vostro.rjw.lan>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62393 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933574AbaKNXGy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2014 18:06:54 -0500
In-Reply-To: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Scott Ashcroft <scott.ashcroft@talk21.com>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>

On Wednesday, November 05, 2014 06:34:44 PM Andy Shevchenko wrote:
> The Intel BayTrail based machines have different configuration of the Low Power
> Sub System (LPSS) IP. The LPSS contains few host controllers, such as I2C, SPI,
> I2C and common DMA IP to serve DMA transfers. Unfortunately the DMA IP has no
> power control accessible for software / OS. It goes automatically down whenever
> last device goes to sleep and turned on when one of them is turned on. When
> user tries to access the powered off DMA device the system hangs.
> 
> This patch series addressing the issue. Rafael suggested to create a 'proxy'
> device which makes DMA to be powered on on the certain points of time.
> 
> Vinod, we would like to push this via Rafael's tree, so, please Ack or NAck the
> patch 4/4.
> 
> Scott, do you have a chance to test this patch series against last linux-pm
> tree on HP laptops? I would appreciate your Tested-by tag.
> 
> Andy Shevchenko (4):
>   ACPI / LPSS: add all LPSS devices to the specific power domain
>   ACPI / LPSS: allow to use specific PM domain during ->probe()
>   ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA
>   dmaengine: dw: enable runtime PM
> 
>  drivers/acpi/acpi_lpss.c | 94 +++++++++++++++++++++++++++++++++---------------
>  drivers/dma/dw/core.c    | 11 ++++++
>  2 files changed, 76 insertions(+), 29 deletions(-)

I've queued up the series for 3.19, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
