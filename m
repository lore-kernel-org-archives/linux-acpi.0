From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Add video.use_native_backlight=1 for HP EliteBook 2014 series
Date: Mon, 28 Jul 2014 17:37:32 +0200
Message-ID: <1406561853-30723-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22687 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbaG1Phk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jul 2014 11:37:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

Hi,

Not sure how long we want to keep maintaining the video.use_native_backlight=1
whitelist now that it is the default in 3.16 .

But I've written this patch to add to the Fedora 3.15 kernel, so I thought
I might as well submit it upstream.

Regards,

Hans
