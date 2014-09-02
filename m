From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/4] ACPI / LPSS: clock improvements
Date: Tue, 2 Sep 2014 13:46:45 +0300
Message-ID: <20140902104645.GP5466@lahna.fi.intel.com>
References: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59692 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbaIBKqz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2014 06:46:55 -0400
Content-Disposition: inline
In-Reply-To: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org

On Tue, Sep 02, 2014 at 10:55:06AM +0300, Heikki Krogerus wrote:
> Minor improvements mainly related to how the clocks are handled.
> 
> 
> Heikki Krogerus (4):
>   ACPI / LPSS: introduce flags
>   ACPI / LPSS: drop clkdev_name member from lpss_device_desc
>   ACPI / LPSS: support for 133MHz I2C source clock on Baytrail
>   ACPI / LPSS: remove struct lpss_shared_clock
> 

Nice cleanup!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

for the whole series.
