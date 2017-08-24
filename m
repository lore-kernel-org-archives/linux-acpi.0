From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Thu, 24 Aug 2017 12:03:57 +0300
Message-ID: <20170824090357.GH2327@lahna.fi.intel.com>
References: <20170824081141.5018-1-tiwai@suse.de>
 <20170824081141.5018-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170824081141.5018-2-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Johannes Stezenbach <js@sig21.net>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 24, 2017 at 10:11:39AM +0200, Takashi Iwai wrote:
> This patch adds the MFD driver for Dollar Cove TI PMIC (ACPI INT33F5)
> that is found on some Intel Cherry Trail devices.
> The driver is based on the original work by Intel, found at:
>   https://github.com/01org/ProductionKernelQuilts
> 
> This is a minimal version for adding the basic resources.  Currently,
> only ACPI PMIC opregion and the external power-button are used.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
