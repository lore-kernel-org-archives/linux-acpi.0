From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [RESEND PATCH 0/2] device property: fix for two bugs
Date: Tue,  8 Mar 2016 15:44:35 +0200
Message-ID: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50106 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932315AbcCHNom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Mar 2016 08:44:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Youn <John.Youn@synopsys.com>, linux-acpi@vger.kernel.org

Hi Rafael,

I'm resending these for your convenience.

> The fwnode->secondary is causing problems when a property_set is
> providing the primary fwnode.
> 
> Both of these fixes are a bit clumsy looking IMO, but I didn't have
> better ideas. I think the second one fixing the use-after-free bug
> should ideally be taken care of in set_secondary_fwnode() instead of
> device_remove_property_set(), but I didn't have any ideas how to do
> that.

There were no better ideas that would have worked from anybody, so
I'm proposing we go forward with these for now.


Heikki Krogerus (2):
  device property: fwnode->secondary may contain ERR_PTR(-ENODEV)
  device property: fix for a case of use-after-free

 drivers/base/property.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.7.0

