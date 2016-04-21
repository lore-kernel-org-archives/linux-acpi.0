From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] device property: don't bother the drivers with struct property_set
Date: Thu, 21 Apr 2016 02:15:08 +0200
Message-ID: <9220737.yhvp89BWgp@vostro.rjw.lan>
References: <1459252343-105426-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43186 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751335AbcDUAMR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Apr 2016 20:12:17 -0400
In-Reply-To: <1459252343-105426-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org

On Tuesday, March 29, 2016 02:52:23 PM Heikki Krogerus wrote:
> Since device_add_property_set() now always takes a copy of
> the property_set, and also since the fwnode type is always
> hard coded to be FWNODE_PDATA, there is no need for the
> drivers to deliver the entire struct property_set. The
> function can just create the instance of it on its own and
> bind the properties from the drivers to it on the spot.
> 
> This renames device_add_property_set() to
> device_add_properties(). The function now takes struct
> property_entry as its parameter instead of struct
> property_set.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This patch has been applied to linux-pm.git and is available from its
device-properties branch

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 device-properties

as commit f4d05266032346531b9f889e26aa31a0cf2a9822

  device property: don't bother the drivers with struct property_set

on top of 9735a22799b9214d17d3c231fe377fc852f042e9

  Linux 4.6-rc2

Thanks,
Rafael

