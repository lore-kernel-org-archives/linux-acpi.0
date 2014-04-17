From: Semen Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH] acpi: respect const qualifier
Date: Thu, 17 Apr 2014 18:53:26 +0300
Message-ID: <1397750006-17463-1-git-send-email-semen.protsenko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:45986 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbaDQPxj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Apr 2014 11:53:39 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so835187eek.32
        for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2014 08:53:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes next warning:

<------------------------------- cut here -----------------------------=
---->
drivers/acpi/property.c: In function =E2=80=98acpi_free_properties=E2=80=
=99:
drivers/acpi/property.c:35:2: warning: passing argument 1 of =E2=80=98a=
cpi_os_free=E2=80=99
                              discards =E2=80=98const=E2=80=99 qualifie=
r from pointer
                              target type [enabled by default]

  ACPI_FREE(adev->properties);
<------------------------------- cut here -----------------------------=
---->

The problem is next:

 - acpi_free_properties() calls ACPI_FREE(), passing "const *"
   parameter to it
 - ACPI_FREE() is macro for acpi_os_free()
 - acpi_os_free() takes "void *" parameter
 - acpi_os_free() calls kfree()
 - but kfree() requires "const void *" parameter

So acpi_os_free() should require "const void *" parameter as well.

Signed-off-by: Semen Protsenko <semen.protsenko@linaro.org>
---
 include/acpi/platform/aclinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/ac=
linux.h
index 93c55ed..c6fa763 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -174,7 +174,7 @@ static inline void *acpi_os_allocate_zeroed(acpi_si=
ze size)
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate_zeroed
 #define USE_NATIVE_ALLOCATE_ZEROED
=20
-static inline void acpi_os_free(void *memory)
+static inline void acpi_os_free(const void *memory)
 {
 	kfree(memory);
 }
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
