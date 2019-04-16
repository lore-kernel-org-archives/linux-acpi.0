From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 11/57] docs: extcon: move it to acpi dir and convert it to ReST
Date: Mon, 15 Apr 2019 23:55:36 -0300
Message-ID: <ecd6b6bcbd5831241609f32ddf5ab484da145959.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The intel-int3496.txt file is a documentation for an ACPI driver.

There's no reason to keep it on a separate directory.

So, instead of keeping it on some random location, move it
to a sub-directory inside the ACPI documentation dir.

For now, keep it with .txt extension, in order to avoid
Sphinx build noise. A later patch should change it to .rst
and movin it to be together with other acpi docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../drivers/extcon-intel-int3496.txt}              | 14 ++++++++++----
 MAINTAINERS                                        |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)
 rename Documentation/{extcon/intel-int3496.txt => acpi/drivers/extcon-intel-int3496.txt} (66%)

diff --git a/Documentation/extcon/intel-int3496.txt b/Documentation/acpi/drivers/extcon-intel-int3496.txt
similarity index 66%
rename from Documentation/extcon/intel-int3496.txt
rename to Documentation/acpi/drivers/extcon-intel-int3496.txt
index 8155dbc7fad3..5137ca834b54 100644
--- a/Documentation/extcon/intel-int3496.txt
+++ b/Documentation/acpi/drivers/extcon-intel-int3496.txt
@@ -1,5 +1,6 @@
+=====================================================
 Intel INT3496 ACPI device extcon driver documentation
------------------------------------------------------
+=====================================================
 
 The Intel INT3496 ACPI device extcon driver is a driver for ACPI
 devices with an acpi-id of INT3496, such as found for example on
@@ -13,15 +14,20 @@ between an USB host and an USB peripheral controller.
 The ACPI devices exposes this functionality by returning an array with up
 to 3 gpio descriptors from its ACPI _CRS (Current Resource Settings) call:
 
-Index 0: The input gpio for the id-pin, this is always present and valid
-Index 1: The output gpio for enabling Vbus output from the device to the otg
+=======  =====================================================================
+Index 0  The input gpio for the id-pin, this is always present and valid
+Index 1  The output gpio for enabling Vbus output from the device to the otg
          port, write 1 to enable the Vbus output (this gpio descriptor may
          be absent or invalid)
-Index 2: The output gpio for muxing of the data pins between the USB host and
+Index 2  The output gpio for muxing of the data pins between the USB host and
          the USB peripheral controller, write 1 to mux to the peripheral
          controller
+=======  =====================================================================
 
 There is a mapping between indices and GPIO connection IDs as follows
+
+	======= =======
 	id	index 0
 	vbus	index 1
 	mux	index 2
+	======= =======
diff --git a/MAINTAINERS b/MAINTAINERS
index 8de292192227..99822421b447 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5958,7 +5958,7 @@ S:	Maintained
 F:	drivers/extcon/
 F:	include/linux/extcon/
 F:	include/linux/extcon.h
-F:	Documentation/extcon/
+F:	Documentation/acpi/drivers/extcon-intel-int3496.txt
 F:	Documentation/devicetree/bindings/extcon/
 
 EXYNOS DP DRIVER
-- 
2.20.1
