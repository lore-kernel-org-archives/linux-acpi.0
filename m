From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/12] PM / core: Add NEVER_SKIP and SMART_PREPARE driver
 flags
Date: Mon, 16 Oct 2017 08:31:22 +0200
Message-ID: <20171016063122.GB28732@kroah.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <1998650.Q52BuGQTI4@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdJPGbP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Oct 2017 02:31:15 -0400
Content-Disposition: inline
In-Reply-To: <1998650.Q52BuGQTI4@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

On Mon, Oct 16, 2017 at 03:29:02AM +0200, Rafael J. Wysocki wrote:
> +static inline void dev_pm_set_driver_flags(struct device *dev, unsigned int flags)
> +{
> +	dev->power.driver_flags = flags;
> +}

Should this function just set the specific bit?  Or is it going to be ok
to set the whole value, meaning you aren't going to care about turning
on and off specific flags over the lifetime of the driver/device, you
are just going to set them once and then just test them as needed?

thanks,

greg k-h
