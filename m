Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEC40FD80;
	Wed,  1 Apr 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051718; cv=none; b=rJJCzmAGTktjB9VTBTkHfZjEwXOE8rsWnc7prIycy4ZrSJ5len2+BSRH9V69KzEKVklVUWmqYKY+RGThPWRt3SimBGGH4DQ0/OWTfeC1bxisIo710mO9rOI7HKf7DVy5LGjQCEolmHUp8uKAEY2hZ6jCgbRYn4gnlhp6lTOa5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051718; c=relaxed/simple;
	bh=NFB41pPA6f/7A5PHWNbQqqX5PlPZtLdTFWoDq9pGwK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNiT5UKV7P+aHjDSglcGCU0ffph9HUDaUQ+cleEuH+qVg9Vt7J4Kcfp78Qbdj2soi3dsymcBuA2BS7QPU/kHq/242v++1SltbyfMm/KUT0Y0/lYf13mTe0huksZckpX5x5w7VrUvhUVQ4JejC7Th3ofqUqviJIpVYQtwMB7q8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=OZQvlxJ4; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="OZQvlxJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1775051708;
	bh=I1lUWlzYdB/I2mHyptMNDzuVUsdBLK/NaYGXjCfmnCM=;
	h=From:To:Cc:Subject:Date:From;
	b=OZQvlxJ4i408VRhdBVoDSOZjrwpuYFDbpOMzEsyTRW2fF8rI0ebhmURHbqOodFASC
	 H4TYHG8mo/8uUM3a+uBbOiAiFU6AxT+mhmEh0vEmUide/Ws+KzAr6K8GV4mzcEEadY
	 Jv0xI0zIHCl9XjSav1ro3YB2GyjamYfFEQf9L3zE=
Received: from stargazer (unknown [IPv6:2409:8a4c:e10:180:5633:9efb:acb8:d769])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 2B6B765992;
	Wed,  1 Apr 2026 09:55:04 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev,
	Zixing Liu <liushuyu@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: Enable FPDT on LoongArch
Date: Wed,  1 Apr 2026 21:53:12 +0800
Message-ID: <20260401135311.1737958-2-xry111@xry111.site>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FPDT provides system- and application-readable performance statistics,
useful for profiling and analyzing boot-time performance. FPDT table
support is now available as a pending patch at the EDK II upstream [1]
and has been tested on real hardware such as Loongson XA61200_V1.1 and
XB612B0_V1.2 with patched firmware.

We have also cross checked systemd-analyze(1) against a stop watch and
the `dp' command in EFI Shell to see that the timing information are
correct.

Now that the functionality of FPDT is verified on LoongArch hardware,
list LOONGARCH as a possible dependency, allowing it to be enabled.

Link: https://github.com/tianocore/edk2/pull/12378 [1]
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 6f4b545f7377..f165d14cf61a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -96,7 +96,7 @@ config ACPI_SPCR_TABLE
 
 config ACPI_FPDT
 	bool "ACPI Firmware Performance Data Table (FPDT) support"
-	depends on X86_64 || ARM64
+	depends on X86_64 || ARM64 || LOONGARCH
 	help
 	  Enable support for the Firmware Performance Data Table (FPDT).
 	  This table provides information on the timing of the system
-- 
2.53.0

