From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Mon, 2 Oct 2017 19:54:03 +0300
Message-ID: <20171002165402.5ypqveemuz2ziuiq@valkosipuli.retiisi.org.uk>
References: <1501288226-27469-1-git-send-email-rajmohan.mani@intel.com>
 <1501288226-27469-4-git-send-email-rajmohan.mani@intel.com>
 <20170814203900.qobophvzcrdtv34s@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:39242 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751130AbdJBQyG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Oct 2017 12:54:06 -0400
Content-Disposition: inline
In-Reply-To: <20170814203900.qobophvzcrdtv34s@kekkonen.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

Hi Rafael,

On Mon, Aug 14, 2017 at 11:39:00PM +0300, Sakari Ailus wrote:
> On Fri, Jul 28, 2017 at 05:30:26PM -0700, Rajmohan Mani wrote:
> > The Kabylake platform coreboot (Chrome OS equivalent of
> > BIOS) has defined 4 operation regions for the TI TPS68470 PMIC.
> > These operation regions are to enable/disable voltage
> > regulators, configure voltage regulators, enable/disable
> > clocks and to configure clocks.
> > 
> > This config adds ACPI operation region support for TI TPS68470 PMIC.
> > TPS68470 device is an advanced power management unit that powers
> > a Compact Camera Module (CCM), generates clocks for image sensors,
> > drives a dual LED for flash and incorporates two LED drivers for
> > general purpose indicators.
> > This driver enables ACPI operation region support to control voltage
> > regulators and clocks for the TPS68470 PMIC.
> > 
> > Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> 
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

The other two patches from the set are in v4.14-rc1.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
