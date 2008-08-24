From: Thomas Renninger <trenn@suse.de>
Subject: [RFC PATCH] Read name/location of thermal zone from ACPI function and pass it to hwmon
Date: Mon, 25 Aug 2008 00:11:35 +0200
Message-ID: <1219615897-21130-1-git-send-email-trenn@suse.de>
References: <20080821174852.0689681d@hyperion.delvare>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51464 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbYHXWLj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Aug 2008 18:11:39 -0400
In-Reply-To: <20080821174852.0689681d@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: khali@linux-fr.org
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

The first patch is enabling a acpi_evaluate_string helper function.

Both patches are for discussion only and beside the fact that
they should compile they are untested.

If you think this works, please give it a review and I can
rework the patch and ask the guy with this BIOS/machine to give
it a test.

      Thomas


