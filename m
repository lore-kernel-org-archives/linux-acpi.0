From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] Documentation / ACPI: Fix location of GPIO documentation
Date: Wed, 21 May 2014 16:58:25 +0300
Message-ID: <1400680705-11078-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Commit fd8e198cfcaa ("Documentation: gpiolib: document new interface")
moved Documentation/gpio.txt to Documentation/gpio/gpio-legacy.txt and added
new documents for descriptor-based interface so fix the the location here to
point Documentation/gpio/ since that what commit ccb6fbb99020
("Documentation / ACPI: update to GPIO descriptor API") was looking for.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 Documentation/acpi/enumeration.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index 2a1519b87177..fd786ea13a1f 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -296,7 +296,7 @@ specifies the path to the controller. In order to use these GPIOs in Linux
 we need to translate them to the corresponding Linux GPIO descriptors.
 
 There is a standard GPIO API for that and is documented in
-Documentation/gpio.txt.
+Documentation/gpio/.
 
 In the above example we can get the corresponding two GPIO descriptors with
 a code like this:
-- 
2.0.0.rc2

