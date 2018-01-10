From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] ACPI / PMIC: Convert to use builtin_platform_driver()
 macro
Date: Wed, 10 Jan 2018 15:53:57 +0200
Message-ID: <20180110135357.GI27654@lahna.fi.intel.com>
References: <20180109202658.85313-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23475 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964870AbeAJNyC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jan 2018 08:54:02 -0500
Content-Disposition: inline
In-Reply-To: <20180109202658.85313-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>

On Tue, Jan 09, 2018 at 10:26:58PM +0200, Andy Shevchenko wrote:
> All of PMIC OpRegion drivers can't be modules, thus, convert them to use
> builtin_platform_driver() macro and remove redundant MODULE_*() macros.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
