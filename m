Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5047DFBF;
	Wed, 27 May 2026 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905545; cv=none; b=A7l0+7wYlNqA6L93xDyMiaH4yLVGs68MeK5RnAX1lD46gEl562tbOCR5KoZ5pQYqL7Px61MGN/P7D1Xq1KmOXCVxzAvHHugrLHcL58zhqgtRd8V7Ey4HjATH2zY2Crdet2CB0/NAELB8CFKzTiOysUoRC0pvW0yF3dzPYixJe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905545; c=relaxed/simple;
	bh=c2TOFOESzLgBQq4XDItwCD5h6iwsU6CjCREH+B23Otk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGgM4pf6YIYgGa79E4shbq97rGYPfyzVnejy7tUK0rTIBbDghvNIgBaiDsN/jo2PcSZ+4KsRbZxVVxWD4d/9VRLUfM/JN/thP9qtzjdQs82AScu6McMpsfXbkgUS4CcBZ/6K63bH86TWvNGGbvG0er4KNkUbcihoGrPdCDVq3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8K0lXMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8K0lXMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7AD1F000E9;
	Wed, 27 May 2026 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905544;
	bh=6MLjkTaBlhap9X2MqFb7sqN2rflIWjnLeKt/42L4YPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O8K0lXMUsUZUyn8BvpziO1fMJfys7kxeww3I/t9kKjouqXtPJ2tZq1drsTWvXvlNi
	 /y+p6tLf5M3gngm0y0GJsxmxiX9Giyar3S4geB3Q7A/wv/gXd+abD92nfoM3ouq/3u
	 dwjfLDhNqOm8Txkogh8O2dNgT89sLZIEUqO06WslTvI2siSiNe1RA6LMh6gOGZ+xB2
	 UQ+o/LKoEDCpF9HfqDsxozwTlTxj6pAoIGJ1gfq77Mpg1S/0dV+892IP96XuE2lARR
	 HyqeRV7y6mcxLhS1omcQ6OXf2HXLplZn7ZC6pZc0P1+4xR7OSRj/a70xJrfPhD+pIG
	 arE6ZnERmyxBg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 10/27] ACPICA: Mention the LVR bits
Date: Wed, 27 May 2026 19:57:52 +0200
Message-ID: <9627007.CDJkKcVGEf@rafael.j.wysocki>
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

From: Akhil R <akhilrajeev@nvidia.com>

Add a comment mentioning the LVR byte position in the type_specific_flag.

Link: https://github.com/acpica/acpica/commit/014fa9f2dbcc
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rsserial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 1119c64795a7..7d7ee3af7272 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -391,6 +391,7 @@ struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[18] = {
 	 AML_OFFSET(i2c_serial_bus.type_specific_flags),
 	 0},
 
+	/* Read LVR from Type Specific Flags, bits[15:8] */
 	{ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.i2c_serial_bus.lvr),
 	 AML_OFFSET(i2c_serial_bus.type_specific_flags) + 1,
 	 0},
-- 
2.51.0




