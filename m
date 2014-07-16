From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend] acpi-video: Add use_native_backlight quirk for HP ProBook 4540s
Date: Wed, 16 Jul 2014 13:28:33 +0200
Message-ID: <1405510114-13437-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932720AbaGPL2i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 07:28:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

Hi Rafael,

I see that you've been adding some more use_native_backlight quirks here:
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/log/?h=acpi-video

It seems this one has fallen through the cracks, hence this resend.

Thanks,

Hans
