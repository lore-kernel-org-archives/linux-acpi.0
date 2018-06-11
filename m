From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] acpi/x86: enable touchscreen on Dell Venue Pro 7139
Date: Mon, 11 Jun 2018 11:55:18 +0300
Message-ID: <f05a1aa6e525ba26883d33fd40b85633442a83e1.camel@linux.intel.com>
References: <1528582686-18577-1-git-send-email-tristiancelestin@fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528582686-18577-1-git-send-email-tristiancelestin@fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tristian Celestin <tristiancelestin@fastmail.com>, rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2018-06-09 at 18:18 -0400, Tristian Celestin wrote:
> Permanently enable the SYNA7500 touchscreen device on the Dell
> Venue Pro 7139. The DSDT hides the touchscreen ACPI device on
> the 7139 in the same fashion as the 7130, and needs to
> be enabled in the same way.
> 

Cc: Mario.

> Signed-off-by: Tristian Celestin <tristiancelestin@fastmail.com>
> ---
>  drivers/acpi/x86/utils.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index ec5b0f1..3a13b2a 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -62,14 +62,20 @@ struct always_present_id {
>  	 */
>  	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
>  	/*
> -	 * On the Dell Venue 11 Pro 7130 the DSDT hides the
> touchscreen ACPI
> -	 * device until a certain time after
> _SB.PCI0.GFX0.LCD.LCD1._ON gets
> -	 * called has passed *and* _STA has been called at least 3
> times since.
> +	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
> +	 * the touchscreen ACPI device until a certain time
> +	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
> +	 * *and* _STA has been called at least 3 times since.
>  	 */
>  	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
>  	      }),
> +	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
> +	      }),
> +
>  	/*
>  	 * The GPD win BIOS dated 20170221 has disabled the
> accelerometer, the
>  	 * drivers sometimes cause crashes under Windows and this is
> how the

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
