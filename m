From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/3] platform/x86: Add support for Dollar Cove TI
 power button
Date: Thu, 24 Aug 2017 12:07:26 +0300
Message-ID: <20170824090726.GI2327@lahna.fi.intel.com>
References: <20170824081141.5018-1-tiwai@suse.de>
 <20170824081141.5018-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170824081141.5018-3-tiwai@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Johannes Stezenbach <js@sig21.net>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 24, 2017 at 10:11:40AM +0200, Takashi Iwai wrote:
> +static struct platform_device_id dc_ti_pwrbtn_id_table[] = {

const?

Regardless,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
