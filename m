From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] GPIO/ACPI: DesignWare: Add GPIO-signaled ACPI events
 support for power button
Date: Wed, 17 Feb 2016 10:53:45 +0200
Message-ID: <20160217085345.GR1742@lahna.fi.intel.com>
References: <1455694090-41713-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5632 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933706AbcBQIxu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Feb 2016 03:53:50 -0500
Content-Disposition: inline
In-Reply-To: <1455694090-41713-1-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

On Wed, Feb 17, 2016 at 03:28:10PM +0800, qiujiang wrote:
> This patch modifies the DesignWare GPIO controller driver to
> support the GPIO-signaled ACPI Events. This is used for power
> button function on ARM server.
> 
> To make it work, the _AEI and _EVT object must be defined in
> the corresponding GPIO driver's dsdt table in UEFI as follow:
> 
> Device(GPI0) {
>         Name(_HID, "HISI0181")
> 	Name(_ADR, 0) // _ADR: Address
>         Name(_UID, 0)
> 
> 	Name (_CRS, ResourceTemplate ()  {
> 		Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
> 		Interrupt (ResourceConsumer, Level, ActiveHigh,
> 		Exclusive,,,) {344}
> 	})
> 
> 	Device(PRTa) {
> 		Name (_DSD, Package () {
> 			Package () {
> 				Package () {"reg",0},
> 				Package () {"snps,nr-gpios",32},
> 		}
> 		})
> 	}
> 
> 	Name (_AEI, ResourceTemplate () {
> 		GpioInt(Edge, ActiveLow, ExclusiveAndWake, PullUp, ,
> 		" \\_SB.GPI0") {8}
> 	})
> 
> 	Method (_E08, 0x0, NotSerialized) {
> 		Notify (\_SB.PWRB, 0x80)
> 	}
> }
> 
> Signed-off-by: qiujiang <qiujiang@huawei.com>

ACPI parts look fine by me.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
