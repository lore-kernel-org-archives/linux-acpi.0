From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 3/3] ACPI / PMIC: Add opregion driver for Intel Dollar
 Cove TI PMIC
Date: Thu, 7 Sep 2017 09:00:39 +0100
Message-ID: <20170907080039.be4cf4xiz3aj4qf7@dell>
References: <20170904144340.27693-1-tiwai@suse.de>
 <20170904144340.27693-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170904144340.27693-4-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 04 Sep 2017, Takashi Iwai wrote:

> This patch adds the opregion driver for Dollar Cove TI PMIC on Intel
> Cherry Trail devices.  The patch is based on the original work by
> Intel, found at:
>       https://github.com/01org/ProductionKernelQuilts
> with many cleanups and rewrites.
> 
> The driver is currently provided only as built-in to follow other
> PMIC opregion drivers convention.
> 
> The re-enumeration of devices at probe is required for fixing the
> issues on HP x2 210 G2.  See bug#195689.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195689
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v4->v5:
> * no change in this driver
> v3->v4:
> * Rename dc_ti with chtdc_ti in all places
> v2->v3:
> * Rename dc_ti with chtdc_ti in all places
> * Driver/kconfig renames accordingly
> * Constification
> * Added acks by Andy and Mika
> v1->v2:
> * get_raw_temp cleanup in opregion driver, mention about register
>   endianess
> 
>  drivers/acpi/Kconfig                    |   6 ++
>  drivers/acpi/Makefile                   |   1 +
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 137 ++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 drivers/acpi/pmic/intel_pmic_chtdc_ti.c

Applied for v4.15, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
