From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] Documentation / acpi: refer to correct file for
 acpi_platform_device_ids[] table
Date: Sat, 9 Feb 2013 05:45:51 +0200
Message-ID: <20130209034551.GS20771@intel.com>
References: <1360332421-32140-1-git-send-email-mika.westerberg@linux.intel.com>
 <38872303.yk2lQjq1aC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42360 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab3BIDl7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2013 22:41:59 -0500
Content-Disposition: inline
In-Reply-To: <38872303.yk2lQjq1aC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sat, Feb 09, 2013 at 12:14:27AM +0100, Rafael J. Wysocki wrote:
> On Friday, February 08, 2013 04:07:01 PM Mika Westerberg wrote:
> > When the ACPI platform device code was converted to the new ACPI scan
> > handler facility, the the acpi_platform_device_ids[] was moved to
> > drivers/acpi/acpi_platform.c. Update the documentation accordingly.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Applied.

Thanks!

> When you post any patches touching ACPI, please send CCs of them to
> linux-acpi as well.

Sure.

In this case I just CC'd what get_maintainer.pl gave me and somehow it
missed linux-acpi totally.
