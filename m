From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] acpi-video: Put the Acer Aspire V5-471G on the use_native_backlight dmi list
Date: Wed, 30 Apr 2014 15:37:20 +0200
Message-ID: <1398865041-12071-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59788 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964797AbaD3Nhb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2014 09:37:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org

Hi All,

I know that there are plans to enable use_native_backlight by default, so
this may not be necessary:
http://www.spinics.net/lists/dri-devel/msg57228.html

But this is a problem right now, and those plans are for 3.16 which is still
quite far away, so lets stick with quirks for now so we can at least give
people something working. Moreover, that plan has been tried before and it
did not end well:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/

So lets just keep the quirk list up2date for now, until we've a better
solution.

Regards,

Hans
