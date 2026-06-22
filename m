Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA1343D9D;
	Mon, 22 Jun 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152595; cv=none; b=TKaMybaTZxtqqtwIDE5YBnV6RDkeFT+I4j88rjCUUk9TUw2sN9VNCLwWz9tft+zi+ZbQCqsnSZXfNPo2/uu4feG/xa32R3yxFAoOtslGEXIRNz1lxSFnwShYV+YFMSQ7r+z1MSXbuHJuH+0N+lbZvTswornd+QbeuZMEUy9rqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152595; c=relaxed/simple;
	bh=FUfgPXzdZ1rL3vEUdVHe6bB1tA8U8Jqj4O/7EQXMS1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XCYtpVELCh96E158E5qjHCyJ5Eyrak2H45aLC2ioOqVFj4YMIB37gGtqZNP9KgdB16Jh8TCYGqoxgMgFSbpFg5jf/JNaxYqqHY0ck5TepBGDUNqsBttlw4NyEMAhOFMdDLlpbv+mEIsH56LBWgFuunFO9nY8aczgU9UQECztLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOWHjFF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOWHjFF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB611F000E9;
	Mon, 22 Jun 2026 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782152593;
	bh=NjMBx25fE4r5hM+5HNA2uyDhK5Ip2tkxvUSPgLOFNVU=;
	h=From:To:Cc:Subject:Date;
	b=JOWHjFF2z+IDf2ncOiv5dp19DNNkE14myo+n+4DMkZEQZk+IkuY8dL8A4gaJwe3p7
	 oHeWDilQ9eSOmxpXGOth2eOCMxQ+p3pjglvr+vtHo8TRbkmWCun0ViuPZsppdnrdGp
	 VAaUeQ7pQDJEzE9YmuExSh1/ibaOMaP0AiaSm3cq1LO/NWfU+P6A6GOBRRv7XdtCTZ
	 WaAbi4kXu8c495FmNSthxL3qUuH4gBAYmaktS5reFXQWKimjEZskLectjFA5QwTkmT
	 a8seJ2KRfSq6VLvsfSMjvS+U4lxBAocxD4VhbVK6f9S31mrX2sQzNThhkKLZTgERV0
	 NVgrZcRbYDLcw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Thomas Renninger <trenn@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Kees Cook <kees@kernel.org>,
 "Chmielewski, Pawel" <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1] ACPICA: Unbreak tools build after switching over to strscpy_pad()
Date: Mon, 22 Jun 2026 20:23:09 +0200
Message-ID: <12923581.O9o76ZdvQC@rafael.j.wysocki>
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

Commit 97f7d3f9c9ac ("ACPICA: Replace strncpy() with strscpy_pad() in
acpi_ut_safe_strncpy()") switched over the ACPICA code in the kernel to
using strscpy_pad() instead of a combination of strncpy() and manual
NUL-termination of the destination string, but it overlooked the fact
that tools also use the code in question and strscpy_pad() is not
defined in those builds.

Address that by using the original ACPICA code in non-kernel builds.

Fixes: 97f7d3f9c9ac ("ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/79e9e913-0fb1-4110-804b-c3b5d0edafe4@kernel
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utnonansi.c |   10 ++++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -168,7 +168,17 @@ void acpi_ut_safe_strncpy(char *dest, ch
 {
 	/* Always terminate destination string */
 
+#ifdef __KERNEL__
 	strscpy_pad(dest, source, dest_size);
+#else
+	/*
+	 * strscpy_pad() is not defined in ACPICA tools builds, so use strncpy()
+	 * and directly NUL-terminate the destination string in that case.
+	 */
+	strncpy(dest, source, dest_size);
+	dest[dest_size - 1] = 0;
+#endif
 }
 
 #endif



