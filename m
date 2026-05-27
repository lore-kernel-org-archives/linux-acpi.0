Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476C477984;
	Wed, 27 May 2026 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905561; cv=none; b=d/2pIDtj3nsC+40x3UTjeGx8mc2HEGk0PZImu3pQvvcStois7oIl1ssJpGJxT+gnvhD/ZaDAreeEYb3bFWxNQ6MTVgtJ/Its68fJLJndb7TLFVG3Ydgocnf0WgRtHnnyfN8ftvdI55c58Pr0qgw6u1WvsOxYlkKa/KSOiJZYw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905561; c=relaxed/simple;
	bh=bcmIcqly8qdder1eEto101Qwlq5pDpSx5XLHE2z9jd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6njZtj+CypRsHrCYZSFExbRZW4FeElamcfvJrOoDd8+w0IbFWNLW7skkd03EW14RFosHrATsRzfa/99aO91mradRM4eCGn60GvzCXN2znq0a7Qa1poQNCZTBsJOPGGRDIvINsDsHlQQHI3DPqs92u8cXlT4Bi+CAQy+Gc0C9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+NGw2Wj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+NGw2Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200CE1F000E9;
	Wed, 27 May 2026 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905560;
	bh=s5LMcDEs3JSeu1JLUDHCIzhH0OYfx1WrcF9PnRSQI1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+NGw2Wj1u8/Xx9OHxY3cnFh/PMFIAdnUrUGvS+njF3atzBkqTq6UFWVYiO9+wxNw
	 5CkZ46dpLDAGDtdK4evgOj4s0IsJZbyz3D9f1cjdD5STfNM3zLT0LihDvHVRreZlkL
	 JNbDaK1wfMa2/mtanlXFafMAmtC8W3jCj6rMmGQyorreNPsrkLhtEghdEZgfp1+p6S
	 3gUiLyJ3MoqMMBMLUfe5ogBLC54IeFkE2WPuaPcw7sw85WO08bX9w3tYnFxNhlvMyH
	 8nmp82zJbO+/2EIowy6Gt620Q+RQuPerLcSDPWDxvxb6gLooJ7XFTwiRRzfHYV2GzX
	 llmM/OWm6LFRg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 05/27] ACPICA: Add modern standby DSM GUIDs
Date: Wed, 27 May 2026 19:54:43 +0200
Message-ID: <3415679.aeNJFYEL58@rafael.j.wysocki>
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

From: Daniel Schaefer <dhs@frame.work>

Add AMD, Intel and Microsoft GUIDs for Low-power S0 Idle _DSM.

Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications
Link: https://github.com/torvalds/linux/blob/v6.18/drivers/acpi/x86/s2idle.c
Link: https://github.com/acpica/acpica/commit/cae0082158e4
Signed-off-by: Daniel Schaefer <dhs@frame.work>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acuuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index b2e29da6ba0a..ccc536f4bbb5 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -63,6 +63,11 @@
 #define UUID_CACHE_PROPERTIES           "6DC63E77-257E-4E78-A973-A21F2796898D"
 #define UUID_PHYSICAL_PROPERTY          "DDE4D59A-AA42-4349-B407-EA40F57D9FB7"
 
+/* Modern Standby */
+#define UUID_LPS0_MICROSOFT             "11E00D56-CE64-47CE-837B-1F898F9AA461"
+#define UUID_LPS0_INTEL                 "C4EB40A0-6CD2-11E2-BCFD-0800200C9A66"
+#define UUID_LPS0_AMD                   "E3F32452-FEBC-43CE-9039-932122D37721"
+
 /* Miscellaneous */
 
 #define UUID_PLATFORM_CAPABILITIES      "0811b06e-4a27-44f9-8d60-3cbbc22e7b48"
-- 
2.51.0




