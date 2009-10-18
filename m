From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/7] acpi: fix trivial warning
Date: Mon, 19 Oct 2009 01:54:33 +0300
Message-ID: <1255906474-25091-7-git-send-email-felipe.contreras@gmail.com>
References: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35800 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbZJRW6A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Oct 2009 18:58:00 -0400
In-Reply-To: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org

drivers/acpi/acpica/tbfadt.c: In function =E2=80=98acpi_tb_create_local=
_fadt=E2=80=99:
arch/x86/include/asm/string_32.h:74: warning: array subscript is above =
array bounds

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 include/acpi/actypes.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index c1a0eb4..7d989f1 100644
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
1.6.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
