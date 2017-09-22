From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] platform/x86: intel-hid: Power button suspend on Dell
 Latitude 7275
Date: Fri, 22 Sep 2017 16:45:43 -0700
Message-ID: <20170922234543.GB20327@fury>
References: <20170917225712.12136-1-jerome.debretagne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170917225712.12136-1-jerome.debretagne@gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?iso-8859-1?B?Suly9G1l?= de Bretagne <jerome.debretagne@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mario Limonciello <mario.limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 18, 2017 at 12:57:12AM +0200, Jérôme de Bretagne wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> On Dell Latitude 7275 the 5-button array is not exposed in the
> ACPI tables, but still notifies are sent to the Intel HID device
> object (device ID INT33D5) in response to power button actions.
> They were ignored as the intel-hid driver was not prepared to
> take care of them until recently.
> 
> Power button wakeup from suspend-to-idle was added in:
> 635173a17b03 ("intel-hid: Wake up Dell Latitude 7275 from
> suspend-to-idle"). However power button suspend doesn't work
> yet on this platform so it would be good to add it also.
> 
> On the affected platform (for which priv->array is NULL), add
> a new upfront check against the power button press notification
> (0xCE) to notify_handler(), outside the wakeup mode this time,
> which allows to report the power button press event and
> trigger the suspend. Also catch and ignore the corresponding
> power button release notification (0xCF) to stop it from being
> reported as an "unknown event" in the logs.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196115
> Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---
>  drivers/platform/x86/intel-hid.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
> index a782c78e7c63..b19f8dcf9d8c 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -226,6 +226,22 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  		return;
>  	}
>  
> +	/*
> +	 * Needed for suspend to work on some platforms that don't expose
> +	 * the 5-button array, but still send notifies with power button
> +	 * event code to this device object on power button actions.
> +	 *
> +	 * Report the power button press; catch and ignore the button release.
> +	 */
> +	if (!priv->array) {
> +		if (event == 0xce) {
> +			input_report_key(priv->input_dev, KEY_POWER, 1);
> +			input_sync(priv->input_dev);
> +			return;
> +		} else if (event == 0xcf)
> +			return;

Minor CodingStyle nit. If the if block uses parens, so does the else block. In
this case, since the if returns, just skip the else entirely.

See Documentation/process/coding-style.rst
The example immediatley *before* 3.1) Spaces.

I've made this change and queued for testing.

> +	}
> +
>  	/* 0xC0 is for HID events, other values are for 5 button array */
>  	if (event != 0xc0) {
>  		if (!priv->array ||
> 

-- 
Darren Hart
VMware Open Source Technology Center
