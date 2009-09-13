From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] acpi: fix trivial warning
Date: Sun, 13 Sep 2009 22:38:26 +0300
Message-ID: <1252870707-4824-5-git-send-email-felipe.contreras@gmail.com>
References: <1252870707-4824-1-git-send-email-felipe.contreras@gmail.com>
 <1252870707-4824-2-git-send-email-felipe.contreras@gmail.com>
 <1252870707-4824-3-git-send-email-felipe.contreras@gmail.com>
 <1252870707-4824-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:55396 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbZIMTjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Sep 2009 15:39:32 -0400
In-Reply-To: <1252870707-4824-4-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

drivers/acpi/acpica/tbfadt.c: In function =E2=80=98acpi_tb_create_local=
_fadt=E2=80=99:
arch/x86/include/asm/string_32.h:74: warning: array subscript is above =
array bounds

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 include/acpi/actypes.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 37ba576..e312be7 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -438,8 +438,8 @@ typedef unsigned long long acpi_integer;
=20
 #define ACPI_SET_BIT(target,bit)        ((target) |=3D (bit))
 #define ACPI_CLEAR_BIT(target,bit)      ((target) &=3D ~(bit))
-#define ACPI_MIN(a,b)                   (((a)<(b))?(a):(b))
-#define ACPI_MAX(a,b)                   (((a)>(b))?(a):(b))
+#define ACPI_MIN(a,b)                   min(a, b)
+#define ACPI_MAX(a,b)                   max(a, b)
=20
 /* Size calculation */
=20
--=20
1.6.5.rc1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
