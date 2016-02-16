From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH] GPIO/ACPI: DesignWare: Add GPIO-signaled ACPI events
 support for power button
Date: Tue, 16 Feb 2016 14:49:01 +0200
Message-ID: <20160216124901.GM1742@lahna.fi.intel.com>
References: <1454653542-122055-1-git-send-email-qiujiang@huawei.com>
 <20160216092449.GE1742@lahna.fi.intel.com>
 <56C3195A.7050001@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C3195A.7050001@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jiang Qiu <qiujiang@huawei.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 16, 2016 at 08:43:06PM +0800, Jiang Qiu wrote:
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
> 			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> 			Package () {
> 				Package () {"reg",0},
> 				Package () {"snps,nr-gpios",32},
> 			}
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

OK, it looks sane to me. Thanks for sharing.
