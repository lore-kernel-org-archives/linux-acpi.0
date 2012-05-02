From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 11/13] gma500: fix -Wmissing-include-dirs warnings
Date: Wed, 02 May 2012 19:16:49 +0100
Message-ID: <20120502181635.26650.26956.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56309 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606Ab2EBSRe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:17:34 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

cc1: warning: include/drm: No such file or directory [enabled by default]

It's reproducible if you build with O=/some/obj/dir and W=1.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/Makefile b/drivers/gpu/drm/gma500/Makefile
index efdad01..dd7d6b5 100644
--- a/drivers/gpu/drm/gma500/Makefile
+++ b/drivers/gpu/drm/gma500/Makefile
@@ -1,7 +1,7 @@
 #
 #	KMS driver for the GMA500
 #
-ccflags-y += -Iinclude/drm
+ccflags-y += -I$(srctree)/include/drm
 
 gma500_gfx-y += gem_glue.o \
 	  accel_2d.o \

