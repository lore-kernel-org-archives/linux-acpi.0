From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/6] acpi: fix trivial warning
Date: Thu, 17 Sep 2009 00:38:42 +0300
Message-ID: <1253137123-18047-6-git-send-email-felipe.contreras@gmail.com>
References: <1253137123-18047-1-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-2-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-3-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-4-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:65443 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760110AbZIPVkd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2009 17:40:33 -0400
In-Reply-To: <1253137123-18047-5-git-send-email-felipe.contreras@gmail.com>
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
index 2d500fa..2ebd3b0 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -438,8 +438,8 @@ typedef unsigned long long acpi_integer;
=20
 #define ACPI_SET_BIT(target,bit)        ((target) |=3D (bit))
 #define ACPI_CLEAR_BIT(target,bit)      ((target) &=3D ~(bit))
-#define ACPI_MIN(a, b)                  (((a)<(b))?(a):(b))
-#define ACPI_MAX(a, b)                  (((a)>(b))?(a):(b))
+#define ACPI_MIN(a, b)                  min(a, b)
+#define ACPI_MAX(a, b)                  max(a, b)
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
