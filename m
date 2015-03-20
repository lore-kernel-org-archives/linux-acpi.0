From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] acpi: video: Add enable native backlight quirk for Lenovo Ideapad Z570
Date: Fri, 20 Mar 2015 09:59:59 +0100
Message-ID: <1426842000-560-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59324 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbbCTJAE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Mar 2015 05:00:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

Hi All,

Here is a patch fixing the backlight issues on Lenovo Ideapad Z570 laptops
discussed a while back.

Note that this patch depends on Aaron Lu's
"acpi: video: Allow forcing native backlight on non win8 machines" patch.

Regards,

Hans
