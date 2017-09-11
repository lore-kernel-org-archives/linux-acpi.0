From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v10 20/24] dt: bindings: smiapp: Document lens-focus and flash properties
Date: Mon, 11 Sep 2017 11:00:04 +0300
Message-ID: <20170911080008.21208-21-sakari.ailus@linux.intel.com>
References: <20170911080008.21208-1-sakari.ailus@linux.intel.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20170911080008.21208-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: niklas.soderlund@ragnatech.se, robh@kernel.org, hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, linux-acpi@vger.kernel.org, mika.westerberg@intel.com, devicetree@vger.kernel.org, pavel@ucw.cz, sre@kernel.org
List-Id: linux-acpi@vger.kernel.org

Document optional lens-focus and flash properties for the smiapp driver.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/devicetree/bindings/media/i2c/nokia,smia.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt b/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
index 855e1faf73e2..33f10a94c381 100644
--- a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
+++ b/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
@@ -27,6 +27,8 @@ Optional properties
 - nokia,nvm-size: The size of the NVM, in bytes. If the size is not given,
   the NVM contents will not be read.
 - reset-gpios: XSHUTDOWN GPIO
+- flash-leds: See ../video-interfaces.txt
+- lens-focus: See ../video-interfaces.txt
 
 
 Endpoint node mandatory properties
-- 
2.11.0
