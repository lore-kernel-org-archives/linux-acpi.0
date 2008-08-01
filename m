From: Thomas Renninger <trenn@suse.de>
Subject: Check for ACPI backlight support otherwise use vendor ACPI drivers - version 4
Date: Fri,  1 Aug 2008 17:37:53 +0200
Message-ID: <1217605083-31003-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:33162 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbYHAPiI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Aug 2008 11:38:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

Modifications to version 3:
  - Stop checking for backlight capabilities on devices which cannot
    be a video device (thanks to Peter <nokos@gmx.net>
  - Do not stop checking on the first video device which has no backlight
    support (many thanks to Peter <nokos@gmx.net>
  - Removed a half wrong comment, found by Zhang Rui.

Please queue for 2.6.28.
Tell me if parts do not patch and I can repost them against
whatever is needed.

Ideally they should go in together with Matthew's/Hong's IGD
patches (which should come mainline through the dri tree), these
patches should need mine.


