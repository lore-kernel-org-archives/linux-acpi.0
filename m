Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8140C5C0;
	Tue, 30 Jun 2026 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835388; cv=none; b=jDb0vwPKd2ZNkL4NC8nsb7bPwdkFMJVKtjU/8rapzQAyASNo9kz2kQaczmNNMaeqJeO2qFOexaDwncYA3AGWfLgqIe3JuESaJsmbZ4q5vvzNOR5FzQTzkj9Uhv32A0J4C4xzBLYttGfHL02J4z69QpSH/aEG6UB6UFxzpzaYPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835388; c=relaxed/simple;
	bh=Cgl5BmoyeuBuusw8wN/Bw0oakTCmiHv/WOb76wTKjLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F4j3fJ6eapS+1EhZL68Yd/30nrJ2m/bvWNtrHgPBlLFPmauj8eg0xtLa1yfp/fT1tS8F7jALveEwYU/AWwYIDwqYbMDGbCUN9TrnNQhG3l6ZFi27g08pLx1rG7chALVWwznE6vR/0qO0b2leiwKi96cGHVAaEHR7Ec8B2UdByuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXwnf1CW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXwnf1CW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DBF1F000E9;
	Tue, 30 Jun 2026 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782835386;
	bh=9h/q6MNWpfAqWB1n1g8tLSYhWOJ93L8f3jiaTH0zwog=;
	h=From:To:Cc:Subject:Date;
	b=HXwnf1CWGCeIZJHW5dUd2JAKTnOUkYTBxuEBrbiuILv2K3ZaBu4kno6HjaNGHdUkp
	 v4fC0QWIm2qNp9n7SD5+E1d/KlYFbj0fcRlw03DNVbEXYzVYErnqakoSyudE5GVJ6y
	 Jq+7VOb93E1TByFp9em7JBqC+5urbKgC7hyBpWNXMSmRaUMAhKrlybC/0z19gyjmn8
	 PBOe50P9uKm8Vv9902sinBMdiHl3nnoTX41w3f9cRBytb82YfNV0dDVDj/sIAcTfYJ
	 Vd47kmFpBhRscV1DuA39yUa2bSEzK0H/UIaHNaPzKhCAD/x9SYfCjm/eOUGs+QX8a8
	 cViuSYmlo8y+Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Thomas Renninger <trenn@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Kees Cook <kees@kernel.org>,
 "Chmielewski, Pawel" <pawel.chmielewski@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject:
 [PATCH v1] ACPICA: Define acpi_ut_safe_strncpy() as strscpy_pad() alias
Date: Tue, 30 Jun 2026 18:03:03 +0200
Message-ID: <12941764.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 292db66afd20 ("ACPICA: Unbreak tools build after switching over
to strscpy_pad()") added an #ifdef based on a __KERNEL_ check which is
sort of nasty to the acpi_ut_safe_strncpy() definition to unbreak ACPICA
tools builds broken by commit 97f7d3f9c9ac ("ACPICA: Replace strncpy()
with strscpy_pad() in acpi_ut_safe_strncpy()").  However, that #ifdef
is not even necessary because the tools don't call acpi_ut_safe_strncpy()
and so it doesn't need to be defined in tools builds at all.

Accordingly, define acpi_ut_safe_strncpy() as a strscpy_pad() alias for
kernel builds and drop its existing definition entirely.

Fixes: 292db66afd20 ("ACPICA: Unbreak tools build after switching over to strscpy_pad()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acutils.h     |    2 --
 drivers/acpi/acpica/utnonansi.c   |   16 ----------------
 include/acpi/platform/aclinuxex.h |    1 +
 3 files changed, 1 insertion(+), 18 deletions(-)

--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -626,8 +626,6 @@ void acpi_ut_repair_name(char *name);
 #if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION) || defined (ACPI_DEBUG_OUTPUT)
 u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source);
 
-void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size);
-
 u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source);
 
 u8
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -164,20 +164,4 @@ acpi_ut_safe_strncat(char *dest,
 	return (FALSE);
 }
 
-void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
-{
-	/* Always terminate destination string */
-
-#ifdef __KERNEL__
-	strscpy_pad(dest, source, dest_size);
-#else
-	/*
-	 * strscpy_pad() is not defined in ACPICA tools builds, so use strncpy()
-	 * and directly NUL-terminate the destination string in that case.
-	 */
-	strncpy(dest, source, dest_size);
-	dest[dest_size - 1] = 0;
-#endif
-}
-
 #endif
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -134,6 +134,7 @@ static inline void acpi_os_terminate_deb
 /*
  * OSL interfaces added by Linux
  */
+#define acpi_ut_safe_strncpy	strscpy_pad
 
 #endif				/* __KERNEL__ */
 



