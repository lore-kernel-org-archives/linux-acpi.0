From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 00/32] acpi-video: Rewrite backlight interface selection logic
Date: Fri, 12 Jun 2015 13:23:19 +0200
Message-ID: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi All,

Here is v2 of my rewrite / cleanup of the acpi-video (and platform/x86)
backlight interface selection logic.

The major change in v2 of this set are 2 changes to the patch titled
"acpi-video-detect: video: Make video_detect code part of the video module":

1) The __setup call for the acpi_backlight= handling is moved to
   acpi/util.c as __setup may only be used by code which is always builtin
2) video.c is renamed to acpi_video.c so that it can be combined with
   video_detect.c into video.ko

These 2 changes result in the backlight kernel commandline options after this
patch-set being 100% compatible with the old options, with the exception of
the removal of the video.use_native_backlight option as that now is folded
into acpi_backlight=[video|vendor|native|none] rather then having 2 options
which influence each other in interesting ways.

Besides that there is a small change to the dell-laptop port to the new API
removing an unnecessary #ifdef ACPI.

Regards,

Hans
