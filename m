From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] ACPI / PMIC: Convert to use builtin_platform_driver() macro
Date: Fri, 12 Jan 2018 14:18:17 +0100
Message-ID: <10928369.BK1BejQx67@aspire.rjw.lan>
References: <20180109202658.85313-1-andriy.shevchenko@linux.intel.com> <20180110135357.GI27654@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:62294 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932976AbeALNTc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jan 2018 08:19:32 -0500
In-Reply-To: <20180110135357.GI27654@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>

On Wednesday, January 10, 2018 2:53:57 PM CET Mika Westerberg wrote:
> On Tue, Jan 09, 2018 at 10:26:58PM +0200, Andy Shevchenko wrote:
> > All of PMIC OpRegion drivers can't be modules, thus, convert them to use
> > builtin_platform_driver() macro and remove redundant MODULE_*() macros.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!

