From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / video: Change the default for video.use_native_backlight to 1
Date: Thu, 05 Jun 2014 22:27:05 +0200
Message-ID: <8608294.Ycsy0EoIBs@vostro.rjw.lan>
References: <1397160803-24297-1-git-send-email-matthew.garrett@nebula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61872 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750840AbaFEUJv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jun 2014 16:09:51 -0400
In-Reply-To: <1397160803-24297-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <matthew.garrett@nebula.com>, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Now that we're hoping to have resolved all of the problems with
video.use_native_backlight=1 make that the default at last.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Having forgotten that the Hans' patches didn't actually flip the
default for this I kind of pre-anounced it in my last pull request,
which was a mistake that I apologize for.  That said, since everyone
involved seemed to be supportive, I'm going to apply this one and
push it to Linus next week.

Please let me know if there are any objections.

Rafael


---
 drivers/acpi/video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/video.c
===================================================================
--- linux-pm.orig/drivers/acpi/video.c
+++ linux-pm/drivers/acpi/video.c
@@ -82,7 +82,7 @@ module_param(allow_duplicates, bool, 064
  * For Windows 8 systems: used to decide if video module
  * should skip registering backlight interface of its own.
  */
-static int use_native_backlight_param = -1;
+static int use_native_backlight_param = 1;
 module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
 static bool use_native_backlight_dmi = false;
 

