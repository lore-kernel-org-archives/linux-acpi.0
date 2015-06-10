From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 00/32] acpi-video: Rewrite backlight interface selection logic
Date: Wed, 10 Jun 2015 15:01:00 +0200
Message-ID: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932613AbbFJNBj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jun 2015 09:01:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

Hi All,

Here is the long promised rewrite / cleanup of the acpi-video
(and platform/x86) backlight interface selection logic.

Reviewers do not be alarmed by the large number of patches, the gist
of the series is in patches 6-13, the earlier ones are a few simple
prepararion patches, and the later ones all port over drivers to the
new API one at a time.

I've had to jump through some hoops to make it possible to still build the
acpi_video code as a module. One downside of this is that the kernel
commandline parameters have a changed prefix now. If people do not like
this, an alternative would to change CONFIG_ACPI_VIDEO from a tristate to
a bool, iow either build it in, or do not build it at all.

Regards,

Hans
