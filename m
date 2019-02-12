From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in
 platform_get_irq()
Date: Tue, 12 Feb 2019 11:08:35 +0200
Message-ID: <20190212090835.GD7875@lahna.fi.intel.com>
References: <20190207185917.167829-1-egranata@google.com>
 <20190211190112.209286-1-egranata@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211190112.209286-1-egranata@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: egranata@chromium.org
Cc: hdegoede@redhat.com, dtor@chromium.org, andy.shevchenko@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org, enric.balletbo@collabora.com, linux-kernel@vger.kernel.org, gwendal@chromium.org, linux-acpi@vger.kernel.org, briannorris@chromium.org, andriy.shevchenko@linux.intel.com, egranata@google.com
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 11, 2019 at 11:01:12AM -0800, egranata@chromium.org wrote:
> From: Enrico Granata <egranata@chromium.org>
> 
> ACPI 5 added support for GpioInt resources as a way to provide
> information about interrupts mediated via a GPIO controller.
> 
> Several device buses (e.g. SPI, I2C) have support for retrieving
> an IRQ specified via this type of resource, and providing it
> directly to the driver as an IRQ number.
> 
> This is not currently done for the platform drivers, as platform_get_irq()
> does not try to parse GpioInt() resources. This requires drivers to
> either have to support only one possible IRQ resource, or to have code
> in place to try both as a failsafe.
> 
> While there is a possibility of ambiguity for devices that exposes
> multiple IRQs, it is easy and feasible to support the common case
> of devices that only expose one IRQ which would be of either type
> depending on the underlying system's architecture.
> 
> This commit adds support for parsing a GpioInt resource in order
> to fulfill a request for the index 0 IRQ for a platform device.
> 
> Signed-off-by: Enrico Granata <egranata@chromium.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
