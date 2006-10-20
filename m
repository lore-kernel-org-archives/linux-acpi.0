From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 0/2] acpi: driverregistration again can report ENODEV
Date: Fri, 20 Oct 2006 11:59:41 +0200
Message-ID: <1161338381.32262.114.camel@queen.suse.de>
References: <20061020092547.519734000@neutrino.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:6874 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932243AbWJTJ7r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 05:59:47 -0400
In-Reply-To: <20061020092547.519734000@neutrino.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fseidel@suse.de
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, 2006-10-20 at 11:25 +0200, fseidel@suse.de wrote:
> Currently acpi_bus_register_driver only reports an error
> (-ENODEV) if acpi_disabled is true,
> but many acpi drivers also depend on a negative error
> value if no driver could be attached to a device
> (as e.g. driver/acpi/asus_acpi.c).
> This patch adds this again (without changing return type
> of acpi_driver_attach for this).

Looks fine to me.

acpi_bus_register_driver must return -ENODEV when no device with
matching HID was found. E.g. battery also should currently get always
loaded even a system never has one.

driver_attach returned the amount of found devices in past, this was
changed recently (can't find the patch/mail) right now. This change
broke things and should get corrected by these patches.

   Thomas

