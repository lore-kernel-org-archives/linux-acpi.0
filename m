From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 00/21] ACPI-video: Fine-tuning for several function
 implementations
Date: Mon, 5 Sep 2016 18:42:19 +0200
Message-ID: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:56606 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbcIEQmo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 12:42:44 -0400
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 18:22:11 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (21):
  Use kmalloc_array() in acpi_video_get_levels()
  Return directly after a failed device query
  Delete an error message for a failed kzalloc() call
  Rename jump labels in acpi_video_get_levels()
  Delete an unnecessary initialisation in acpi_video_get_levels()
  Move four assignments in acpi_video_get_levels()
  Rename jump labels in acpi_video_bus_add()
  Improve a size determination in acpi_video_bus_add()
  Rename jump labels in acpi_video_register()
  Return directly after a failed input_allocate_device()
  Rename jump labels in acpi_video_bus_add_notify_handler()
  Delete unnecessary if statement in acpi_video_switch_brightness()
  Improve a jump target in acpi_video_switch_brightness()
  Improve a size determination in acpi_video_device_enumerate()
  Delete an unnecessary initialisation in acpi_video_device_enumerate()
  Rename jump labels in acpi_video_device_enumerate()
  Delete an unnecessary initialisation in acpi_video_init_brightness()
  Rename jump labels in acpi_video_init_brightness()
  Rename a jump label in acpi_video_device_lcd_query_levels()
  Improve a size determination in acpi_video_dev_register_backlight()
  Improve a size determination in acpi_video_bus_get_one_device()

 drivers/acpi/acpi_video.c | 114 +++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 62 deletions(-)

-- 
2.10.0

