From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: MAINTAINERS: update a file name in drivers/acpi/
Date: Tue, 1 Dec 2015 11:58:40 +0300
Message-ID: <20151201085840.GA26852@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Hans de Goede <hdegoede@redhat.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We renamed drivers/acpi/video.c to drivers/acpi/acpi_video.c in commit
14ca7a47d0ab ('acpi-video-detect: video: Make video_detect code part of
the video module').

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index f3de001..736a103 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -318,7 +318,7 @@ M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
 W:	https://01.org/linux-acpi
 S:	Supported
-F:	drivers/acpi/video.c
+F:	drivers/acpi/acpi_video.c
 
 ACPI WMI DRIVER
 L:	platform-driver-x86@vger.kernel.org
