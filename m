Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73D386C39
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662340; cv=none; b=LreVrDUAZPrdtLRhwpscbuvZteu7TaJPhzGuyAZaZqiVNTy+rDGKVOzYL7yj9U7YVerzEwZr+9YLyNGTZmlFQW4FVx3mvuldvUAkT+Yy5jDfWunGKJPtyKsdux8jKGy4jdVzlzSpPJ1An2wobFePCNjmBSFmeeABljwfrMcVGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662340; c=relaxed/simple;
	bh=ebiu9YEQbXkOUWJIAEBHloa+6lFq4cUZAbjxjNgOz5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5TOcl4N4lJDQ+Xx3dpkhnIbXPQu2aVPcBhf+gOXb3uyXwp+uajoFVkKNeM71Y2AiMEIU6HaSmJICNKFdH6l9Httkt2oIdyI2aAKxSxtVRAs2Dz0MItU20C68muhKD9ITD2PC4McyWWkwXQrcMgwIYdRRIXF18MpZSKYiJ8Hjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiBU/zl+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiBU/zl+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4720f3bf164so2993595f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784662337; x=1785267137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KW2NvbPcpsJ4x/MthRN20VzLSnOiLA7Uw1JEXiIhMQg=;
        b=YiBU/zl+XCTYu43XgiUGqKitfPQBDl9W2yf+6LlQXJOS8sLRf/wqvME/cXUUmhCrKw
         ND/ohyiK6oKjCJVVMxYQ+pq6WCao03jM4cfSPQVYeOi2lDsFelD12AGxD+JMALGxwJJ6
         N6nkhkCw2jG+gMtYEbOouo50ilxsec6T0SrfpOsyvL25/o4ZTgi59X+M+93xshSd0ITp
         gKt+DRHv25BYbBMcSEXOsngHCQEFemgvSvcoRCJA67j0LkwbOobmqqJzZVgPau9vcRyz
         iZ81O25x2XnxqcXp9rfnaONMi0AGH2hh5ElMco4N7vxKlLa4eVKtBaExTzaFIC92jpsk
         YFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662337; x=1785267137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KW2NvbPcpsJ4x/MthRN20VzLSnOiLA7Uw1JEXiIhMQg=;
        b=B0wRj8HzdHL0o0WaDdnQAViUxc+eOYJoM4CTVZP6MUV19imIjgjLnEeOmdG0g3Fknz
         zR7XAdkTitfRJje7AP+A4r2KH1sgdP4F5NSQflBWMrUMQmMQFuCg8IgWW53l104WbFCZ
         ef/c+rhEvkN+OGy+lTjROnOwrj6PA7KY8ezd+RTY7VXAy4DIk0MHtEN12GPYpTOjgKPb
         FpHedCePbKntDINRg6NmWpq9YL9Q7soMum3YR3g7sRLecAnOVKAieaUgjDZrxFVU2HUh
         WVXUPv+ytHMbLnnCv/PPQmtRvhiTTXqIfStEDkzoZj3x6mPoAXAHFFJn8Ny3ZTCgHEPs
         hcww==
X-Forwarded-Encrypted: i=1; AHgh+RpqoyXhbSffHWue8Bq2DzUXb8jEt+DDT8TcVB7lxtLzA0ykF1IyZLvY7/YiYKLMqV575KWpjKZNwrTa@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIS/2qsGBfD4YNaGIWMIMIbguLthMbZJFjWc8bWyfjyp0FMWM
	OeK5PH+RvPzusYaScwDtUgDjl6yYPOhNYQPbMRSYRlV9zhyDhG0mlwY1
X-Gm-Gg: AfdE7ckt3LSUyxEV0zAFJMN3/neO29UWm1rqJnJhZ8NBCx0s1gwzMAcF+XLpTHnKANl
	21mmFDzMI6yXcg1mwXCc0wEBbxR8f8yvWlF7vlpo9reHfOI/oIbEgsjXlGtraKnModI2Hv0WUFt
	Gumd0Pv8m+AgloqT9LAqMdZLJ/GyWCa1Jzqi6vEKESdj2kkaCj6tC7wAK29BMsOTEaEoWNXWhLL
	aN64BGR5J+ObRt6KLoTYb+6G7I5xM6iLWvorkTP7Iak8hMi8MfOE2RBdRx/+7D1RtLQfn4n6UWx
	hzypFiNOEIWL1XurPhnjMeNq1Q+ZJWFaZNNODqaXBjN0wbsun8jwiQ9bUc1rZT2YUn9YZ9+UmRF
	+OCd79+KKQQ8fNMEseABBwthhEOTBetRN7afcy1WLwAJZfWAQVRR/jay1ztzyK5iaKHrHZYrUfO
	ZPT0S8Hv2bRL1saU+VtxSe+7G/58af0jluV4zI05ktMT68BMU+bXld4LtplUup/EmHb/4CQX7D
X-Received: by 2002:a05:600c:3510:b0:493:b4a3:5ab0 with SMTP id 5b1f17b1804b1-4956a50fd4cmr9873585e9.13.1784662336456;
        Tue, 21 Jul 2026 12:32:16 -0700 (PDT)
Received: from c64.fritz.box (p200301048f0fe900a0f9605663da8872.dip0.t-ipconnect.de. [2003:104:8f0f:e900:a0f9:6056:63da:8872])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b021fa6sm2319195e9.2.2026.07.21.12.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:32:14 -0700 (PDT)
From: Saverio Miroddi <saverio.pub2@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saverio Miroddi <saverio.pub2@gmail.com>
Subject: [PATCH] ACPI: bus: Avoid misleading _OSC missing-feature errors
Date: Tue, 21 Jul 2026 21:29:14 +0200
Message-ID: <20260721192914.1166891-1-saverio.pub2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI specification defines OSC_CAPABILITIES_MASK_ERROR to mean that
firmware cleared capability bits requested by the operating system. Some
firmware sets this status during the control request while returning every
requested capability unchanged. On the affected system, the requested and
returned masks were both 0x006a7eff.

Commit e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC
platform features") made all control-response errors produce error-level
messages. Consequently, the inconsistent response above now claims that
features may be missing even though none were removed.

Track whether the response actually clears a requested bit and omit the
error-level messages only if OSC_CAPABILITIES_MASK_ERROR is the sole
error and no capability was cleared. Keep the dynamic-debug diagnostic and
leave the negotiated capability mask and all other error cases unchanged.

Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
Signed-off-by: Saverio Miroddi <saverio.pub2@gmail.com>
---
 drivers/acpi/bus.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a30a904f6535..c13128cbc2f6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -335,7 +335,8 @@ static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
 		.length = bufsize * sizeof(u32),
 	};
 	struct acpi_buffer output;
-	u32 *retbuf, test;
+	u32 *retbuf, test, errors;
+	bool capabilities_masked = false;
 	guid_t guid;
 	int ret, i;
 
@@ -395,16 +396,24 @@ static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
 	 * Clear the feature bits in capbuf[] that have not been acknowledged.
 	 * After that, capbuf[] contains the resultant feature mask.
 	 */
-	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++)
+	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++) {
+		if (capbuf[i] & ~retbuf[i])
+			capabilities_masked = true;
+
 		capbuf[i] &= retbuf[i];
+	}
 
-	if (retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK) {
+	errors = retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK;
+	if (errors) {
 		/*
-		 * Complain about the unexpected errors and print diagnostic
-		 * information related to them.
+		 * Some firmware sets OSC_CAPABILITIES_MASK_ERROR without clearing
+		 * any requested capability.  Only complain if another error is
+		 * present or a capability was actually masked.
 		 */
-		acpi_handle_err(handle, "_OSC: errors while processing control request\n");
-		acpi_handle_err(handle, "_OSC: some features may be missing\n");
+		if (errors != OSC_CAPABILITIES_MASK_ERROR || capabilities_masked) {
+			acpi_handle_err(handle, "_OSC: errors while processing control request\n");
+			acpi_handle_err(handle, "_OSC: some features may be missing\n");
+		}
 		acpi_osc_error_check(handle, &guid, rev, &cap, retbuf);
 	}
 
-- 
2.54.0

