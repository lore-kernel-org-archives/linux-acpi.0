From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI: Use reference counting only for GPEs enabled at runtime
Date: Wed, 23 Jun 2010 12:28:36 +0200
Message-ID: <201006231228.36340.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41458 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab0FWKfY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jun 2010 06:35:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>

Hi,

The following two patches rework the GPE code so that reference counting is
only used for GPEs enabled at run time.

As a result, the third argument of acpi_{enable|disable}_gpe() is removed,
which simplifies the runtime GPE handling quite a bit.  The "wakeup"
GPEs are handled with the help of a new function that only manipulates their
enable bits in their registers' enable_for_wake masks and is only called in
two places in drivers/acpi/wakeup.c.

Please apply.

Rafael

