From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] ACPI / LPSS: clock improvements
Date: Wed, 03 Sep 2014 23:49:36 +0200
Message-ID: <1489921.xCuLvLtM1j@vostro.rjw.lan>
References: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61936 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754017AbaICVaQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 17:30:16 -0400
In-Reply-To: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Tuesday, September 02, 2014 10:55:06 AM Heikki Krogerus wrote:
> Minor improvements mainly related to how the clocks are handled.
> 
> 
> Heikki Krogerus (4):
>   ACPI / LPSS: introduce flags
>   ACPI / LPSS: drop clkdev_name member from lpss_device_desc
>   ACPI / LPSS: support for 133MHz I2C source clock on Baytrail
>   ACPI / LPSS: remove struct lpss_shared_clock
> 
>  drivers/acpi/acpi_lpss.c | 145 ++++++++++++++---------------------------------
>  1 file changed, 43 insertions(+), 102 deletions(-)

Series queued up for 3.18, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
