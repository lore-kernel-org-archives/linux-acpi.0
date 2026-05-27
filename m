Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84E466B66;
	Wed, 27 May 2026 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905498; cv=none; b=RfNB00SBPBARRTi3J2BR07qawUyMPQaGBmRob6iA+qlp6ERQTAwCLIMKQc5C1Ex4vLrjBZrOW2xHAI/hWBMXk7iU6Ak2GvKHkYE1AqVDXcAerx85sia0BSWzy+0lFGalbed0vylliN+Y30uOOahicTRqq3IEYqcOTaIKkYu7vs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905498; c=relaxed/simple;
	bh=txWHjCzp4V9MC3z8ULe/m5yosdHr6N18mF/Os2BG3G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EK+BLSvGit2/oUg7mNJiPTNtxmDnabTdxvlFmgw/wYpcKh8j/39/G0r8lWV3XVgbZ8vv7aVR4O9eGBoUs+qbIBuNIVUkMv0wHqTQqSXLuo7uZ4GUqxoG6/bkjVCSRknmaxuZB99yVIXTzecO3NY6nJcSthlmT2UsV864+adoi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR/bp2HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR/bp2HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF991F000E9;
	Wed, 27 May 2026 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905497;
	bh=+tdMUr7jhex22G1b38udoZExft4On9tO+2Vp5FHNuH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QR/bp2HSB8kiX3OmV07CubKv8wepGycYj1UZDSgykqarASIbacTrjzY6R7LVa892v
	 Rki08JD8q93lzV4/kJy+YFhP76NS+IG0DPGd6PteCnKuhQEgjh6Z5UfCYjGGzhk2em
	 gzS/z15ec3ITv5GAIIuEjOF2hHucLoxWwVnFvg5L8E6jSvdL3eCwCqATweAilTG8Nj
	 qFm0fLiiDKlLnwopKmgXk8b5Pd7fCpDVX0TJSz9CdxiazqYqEBhKv8fiFNM7jS7U0q
	 barsYCIoBRb8Afy48zDhF/jf/bEAryz08VbmMrTyNpgMcEKMfnKwerC4T1MFoUezhK
	 pPsKLYWT7l5eA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 25/27] ACPICA: Update version to 20260408
Date: Wed, 27 May 2026 20:08:44 +0200
Message-ID: <1881459.TLkxdtWsSY@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Saket Dumbre <saket.dumbre@intel.com>

Update ACPI_CA_VERSION to match the 20260408 upstream release.

Link: https://github.com/acpica/acpica/commit/232ff3f8ae1a
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 7719597c05ef..349d07ae2d44 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20251212
+#define ACPI_CA_VERSION                 0x20260408
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.51.0




