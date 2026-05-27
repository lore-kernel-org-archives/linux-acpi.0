Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E247ECE7;
	Wed, 27 May 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905552; cv=none; b=GBOpuaasgbWej+pxqHgPPLydmr4P+GABeIsWm1VjdXgdBUEWOF35LUOxI46yzezAKEpEttDQ9hOhd2kB9zgiyb5k3kgFHpcABlL6af4QE4a+cXMMl6g9WMqLAidpg8szLD8o49hOdDeum33tVZf1zCd7ChCUD6jTyoHjhka7mkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905552; c=relaxed/simple;
	bh=SmeZO0kWjcbbegs1DEobA0oESaNOcJSAqrNEHJiTR5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxBV7Y0p+XsmO+R5e8NGvTyFMbN2SShI0R2ZNDuGGQstgAfe6jmzKDXinVkKF8s9hJHluNv3iRvWZJhMXYbF3SsTXFn2iY3wpILNEUF+Ip8a4gJoc06azbFPkQJO2LxHdkh9kZbEfzKQmvyLFOX742x+SDEWHTyUKOAvj9vxJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtIkjGzl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtIkjGzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046201F000E9;
	Wed, 27 May 2026 18:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905551;
	bh=IjVd74RQUzUNcsbKTv7FsIJYDfDuq3kOlRZhyv+dDMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtIkjGzlagQULMSzkKUs3haEbqt+na7ccRTN7uYQLWv4NZ3FBbm80e/B99cCizmeo
	 FNXlRRsdlvQtdYFYptZmQZffb6L7RxLKwj4k1ueRmWBWX0SU80FQZ6dVF3RVxtYALt
	 YmSogX0YlKrQJAhQxsgk26DZ3c5qnDLXPsBX7PLek+3So74LQIwiIP+XKI90SIkXo7
	 J+dFlTmaywTnbE7o9vs+8fH4cAppyJb4o8pa/5pr7T0obOSql5sxqQNKhFQ4eH1jH2
	 mc9XX4QrRAG+AdWUHfRI4Xd6uzMDmeCoyYch1RxqWA6yVsVClugfRVBf/FOdgHVul8
	 13GE8IsbQvXWQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 08/27] ACPICA: Fetch LVR I2C resource descriptor
Date: Wed, 27 May 2026 19:56:38 +0200
Message-ID: <23121545.EfDdHjke4D@rafael.j.wysocki>
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

Add LVR I2C resource entry to acpi_rs_convert_i2c_serial_bus[].

Link: https://github.com/acpica/acpica/commit/c40411823510
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rsserial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 279bfa27da94..3e4a1fe81ef6 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -315,7 +315,7 @@ struct acpi_rsconvert_info acpi_rs_convert_csi2_serial_bus[14] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[17] = {
+struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[18] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_SERIAL_BUS,
 	 ACPI_RS_SIZE(struct acpi_resource_i2c_serialbus),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_i2c_serial_bus)},
@@ -391,6 +391,10 @@ struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[17] = {
 	 AML_OFFSET(i2c_serial_bus.type_specific_flags),
 	 0},
 
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.i2c_serial_bus.lvr),
+	 AML_OFFSET(i2c_serial_bus.type_specific_flags) + 1,
+	 0},
+
 	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.i2c_serial_bus.connection_speed),
 	 AML_OFFSET(i2c_serial_bus.connection_speed),
 	 1},
-- 
2.51.0




