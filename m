From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [resend PATCH] driver core: property: support for generic
 property
Date: Mon, 9 Mar 2015 16:43:19 +0200
Message-ID: <20150309144319.GA25137@kuha.fi.intel.com>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44930 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbbCIOpa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Mar 2015 10:45:30 -0400
Content-Disposition: inline
In-Reply-To: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Mon, Jan 26, 2015 at 03:17:40PM +0200, Heikki Krogerus wrote:
> This extends the unified device property interface by adding
> "Generic Property" to it for cases where device tree or ACPI
> are not being used.
> 
> That makes the unified device property interface cover also
> most of the cases where information is extracted from custom
> platform_data in the drivers. So if before we had to check
> separately is there custom platform_data for a driver:
> 
> 	if (pdata)
> 		bar = pdata->bar;
> 	else
> 		device_property_read_u32(dev, "foo", &bar);
> 
> we can now drop that check and simply always use the unified
> device property interface.
> 
> That makes it possible to drop a lot of boiler plate from
> the drivers, plus quite a few header files under
> include/linux/ describing those driver specific platform
> data structures can be removed.

Gentle ping on this.


-- 
heikki
