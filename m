From: Thomas Renninger <trenn@suse.de>
Subject: Check for ACPI backlight support otherwise use vendor ACPI drivers - version 3
Date: Thu, 17 Jul 2008 19:32:04 +0200
Message-ID: <1216315935-20998-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39668 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757734AbYGQRcR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 13:32:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: linux-acpi@vger.kernel.org

Minor cleanup changes to version 2:

   - Remove all IGD stuff
   - beautify bit mask defines


