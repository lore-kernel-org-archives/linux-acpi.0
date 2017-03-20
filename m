From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] device property: Move FW type specific
 functionality to FW specific files
Date: Mon, 20 Mar 2017 15:57:01 -0500
Message-ID: <CAL_Jsq+HGNCbiHw8dD0R+zj+GfGxaypk7di0sbxNr4bZsjqxbA@mail.gmail.com>
References: <1489671289-20406-1-git-send-email-sakari.ailus@linux.intel.com> <1489671289-20406-4-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754805AbdCTU5Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Mar 2017 16:57:25 -0400
In-Reply-To: <1489671289-20406-4-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Mar 16, 2017 at 8:34 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> The device and fwnode property API supports Devicetree, ACPI and pset
> properties. The implementation of this functionality for each firmware
> type was embedded in the fwnode property core. Move it out to firmware
> type specific locations, making it easier to maintain.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c |  87 +++++++++++++++
>  drivers/acpi/scan.c     |   1 +
>  drivers/base/property.c | 280 +++++++++++++++++++-----------------------------
>  drivers/of/base.c       |  99 +++++++++++++++++

This is the opposite direction everything else has been moving. For
example, I2C parsing is in drivers/i2c. But I guess this is a bit
different.

In any case, please move this to drivers/of/property.c (and perhaps
move all of of_property_* there too).

Rob
