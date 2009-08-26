From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 0/6] thermal: improvements re. forced passive cooling
Date: Wed, 26 Aug 2009 18:17:19 +0200
Message-ID: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:60665 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1749667AbZHZQRY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Aug 2009 12:17:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Sujith Thomas <sujith.thomas@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

This set three new patches in addition to four sent earlier as:
- [PATCH 0/3] acpi: improvements for Documentation/thermal/sysfs-api.txt
- [PATCH] acpi: thermal: display forced passive trip points in proc

There's one new whitespace fix in patch 1/1 from the first set;
patch 3/3 from that set was dropped as it was NACKed by Rui.

The first two patches in this series are purely documentation; the
others enhance functionality.

I've added Matthew in CC as he orginally implemented forced cooling.
Sujith Thomas is only CCed on the first two patches.

 Documentation/thermal/sysfs-api.txt |  393 ++++++++++++++++++-----------------
 drivers/acpi/thermal.c              |    7 +
 drivers/thermal/thermal_sys.c       |   17 +-
 3 files changed, 222 insertions(+), 195 deletions(-)

Cheers,
FJP

