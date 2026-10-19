Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421682;
	b=GqTD1tn2yd5XJwQUBbaQgOVQE3NQHy7TWMWjV6rQOQgbWXNyQzUdg640dRgw5mfpnbOs
	 P4x3bRtItRmG8LeYWSJMWNluWxYd1X4ohceo28GC/rZ7R5/6LCN+LGsGcRECgsbE+rFsK
	 hoNUZjTYRltlVY/ypyGMDtqr54NrXEgLD/avdyY7XQ4532UncWv0aUOK0X6mALegRKyJ9
	 13t8nZwa9CBo402lgWaIR/peJFSiM5xil0nYXekxFPj/B0quGSn4okfuV0URfJibvsmjg
	 djt8rStu/GSjDD5Y8b269PuTJgigvWNZFjKceqyV4CIWtFVfFTlw7qjAsSv8WUJDruQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421682;
	h=Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Bar:X-Rspamd-Report:X-Rspamd-Score:
	 DKIM-Signature;
	bh=rwhf8EAuiOMaypHO3detYAeDV9E3dgFxaDUeqSzQJsM=;
	b=EXuEyp5mW2SQNAEFxUQNYNaTE1waqP59HweNi8kvmii4J4eyOBwSOfKgU6Fo1UNeD5AC
	 n31tKFc0ew5CfmpsWfd0i67JnL/Bzxtzd0r0a60Etftmf/uorHsG+K1N8xOVA4Xsfqb7b
	 /MP/FehmeKsuVlYBcQnBtEU+Qg0xmhK7LBDr+EJUXScHDJVknc7KfLZAu9cuE5jsaGeXE
	 RFrYCOMbJmVQLrLE76Y2GzOJHUAFN3lBd9qM5hMeHxJSpBW71wCE5REunBCFcqjuZClmN
	 2rUytnwYn2TGRrx6jzQIkBqc/weyz8oerR/T6ECHEumrxEhTcY42UCVrFHomfFubbvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=Evzt9PyL;
	dmarc=pass header.from=lausen.nl;
	spf=pass smtp.mailfrom=lausen.nl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD38606EFC1
	for <linux-acpi.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=Evzt9PyL
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E9332907
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421682; cv=none; b=Sx7IJzdEHr3l5ZbNQMqsU5dbqM/EHUwtiMEsdu+XWfarONLgoPHEseVF1Lw97DlEe0eFYDNgq15+ccqVLyn+SOSUTP6FbK6jZuy1kZm8a2jsKHCkBBCeVxQcY3A1SFp5FCw2WuLSxwhcbMArNsTYHKZscnyzQKWFmxTY/bhBQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421682; c=relaxed/simple;
	bh=oRhTvAdmIe1fqBlfvU3hzri5hH3R1/FUZpcl7jrPQMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUvW1AuxjEQUnBZWJPsnVVHkw80+/+Vf8xe2nhkKGZpHCEZV3cHFujiT6fTm/E7nSHnixwaKfrF91p3WrCuNujc+Ai73/5RJG0zwQBIDejPW5ZSlD/eCDFNFz7XuP6w2a5QZObs4g4gdKHQWEuo0KK/CdBYAEwrgsejzQrQb/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=Evzt9PyL; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id C98566113F
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 16:54:38 +0200 (CEST)
Received: (qmail 28483 invoked by uid 990); 19 Oct 2026 14:54:38 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 16:54:38 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: leonard@lausen.nl,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	acpica-devel@lists.linux.dev,
	Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Ivan Hu <ivan.hu@canonical.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ACPI: x86: Repair broken PEG0._STA on Samsung Galaxy Book 930XDB
Date: Mon, 19 Oct 2026 16:54:19 +0200
Message-ID: <20261019145421.47181-4-leonard@lausen.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019145421.47181-1-leonard@lausen.nl>
References: <20261019145421.47181-1-leonard@lausen.nl>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=oRhTvAdmIe1fqBlfvU3hzri5hH3R1/FUZpcl7jrPQMA=;
	b=Evzt9PyLxiU16qEy0E+1gYVsbgBsgzFJ9Ppf0eqTOpnvmlqRwOAhtX1MU7KrHxeF0maXbb+uyl
	EfH7p801/7WGvMoRc1NEhZ/k+BSLn3hOIhARLvRi5xJ3EOC8Lpuga1NqfFei0Eli27ge2qNLI+n9
	Nrol1351+teKkBYstcQAxGyiuKNPT64ZuBZ5UcoZ9+/7cCQeXnmV4XFE27RwUbBsLnwRqTovWQST
	Gx47O1s/0Go5ak2kAwI9O9meBL0fhW+wzFLniJqwl8NLY3vUQ2kMrVFYwZDfJiIBEqSHcrNVHyiU
	QIWGhFtJ82H5R2JNoPw+CfngicHgIEGTpT8WJfhtMw8ZkC/gnvkdRPkwfdo5bGIfvSuXs9qYBUKL
	BXWbYVU6HQLX2d5tXkg7lGpHM4f7y2yzHfalCX9vxdwV9TUlGpFbWkl4Ohqvg1SGfnQ8qm1whGVA
	WpmHXtQOop6M91AGhb3oaCJQIuUYPM/DMS4U06ENJuw6/WS84cUUoZ9rtfSAeyUdySKd+2luK1yc
	Fj5NIUcSAtO+IB+HZBCHccDFh0Le7Jy4LKwM0/XJTWVvDC2Miy3noG+3gjXzG+XMzgAyjLrT+qe0
	eQChxqs7qQC2g/Dlaj6edcZF/Kx1+lt1Mlj2IwcsjMzRP4TKekOOF9pBYp/M5LzOCWrdriywPu5o
	0=

The SaSsdt table on the Samsung Galaxy Book 930XDB with BIOS
P11RFX.067.230331.SP declares PG0E as an external object at the namespace
root. PEG0._STA nevertheless encodes PG0E as an unqualified NameSeg.

Namespace lookup from PEG0 finds the unrelated empty Package at
\_SB.PC00.PG0E before the intended integer field at \PG0E. Comparing
that Package with One aborts _STA with AE_AML_OPERAND_TYPE.

A regular acpi_device status override is too late to prevent this.
ACPICA evaluates _STA while initializing namespace objects, before
struct acpi_device exists, and acpi_get_devices() evaluates it again
without going through acpi_bus_get_status().

Replace only PEG0._STA after the tables have been loaded and before ACPI
objects are initialized. The replacement retains the firmware logic but
uses an absolute path for \PG0E, so every _STA evaluation follows the
intended namespace object. Match the vendor and full DMI product string,
930XDB/931XDB/930XDY.

Signed-off-by: Leonard Lausen <leonard@lausen.nl>
---
 drivers/acpi/bus.c       |  2 ++
 drivers/acpi/x86/utils.c | 53 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h  |  2 ++
 3 files changed, 57 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 808c6746be14..555270fb49dd 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1376,6 +1376,8 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
+	acpi_quirk_override_broken_methods();
+
 	/*
 	 * ACPI 2.0 requires the EC driver to be loaded and work before the EC
 	 * device is found in the namespace.
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 418951639f51..661267a5f8ba 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -67,6 +67,59 @@ struct override_status_id {
 #define NOT_PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
 	ENTRY(0, "", NULL, path, cpu_vfm, dmi)
 
+/*
+ * The firmware method is equivalent to this ASL, except that it references
+ * PG0E without the root prefix and resolves to an unrelated Package object:
+ *
+ * Method (\_SB.PC00.PEG0._STA, 0, NotSerialized)
+ * {
+ *     If ((\PG0E == One))
+ *         Return (0x0F)
+ *
+ *     Return (Zero)
+ * }
+ *
+ * acpi_install_method() requires a complete table containing one method.  The
+ * AML below was generated from the ASL above with iasl 20250404.
+ */
+static u8 samsung_930xdb_peg0_sta[] __initdata = {
+	0x53, 0x53, 0x44, 0x54, 0x48, 0x00, 0x00, 0x00,
+	0x02, 0xc8, 0x4c, 0x49, 0x4e, 0x55, 0x58, 0x20,
+	0x50, 0x45, 0x47, 0x30, 0x53, 0x54, 0x41, 0x20,
+	0x01, 0x00, 0x00, 0x00, 0x49, 0x4e, 0x54, 0x4c,
+	0x04, 0x04, 0x25, 0x20, 0x14, 0x23, 0x5c, 0x2f,
+	0x04, 0x5f, 0x53, 0x42, 0x5f, 0x50, 0x43, 0x30,
+	0x30, 0x50, 0x45, 0x47, 0x30, 0x5f, 0x53, 0x54,
+	0x41, 0x00, 0xa0, 0x0b, 0x93, 0x5c, 0x50, 0x47,
+	0x30, 0x45, 0x01, 0xa4, 0x0a, 0x0f, 0xa4, 0x00,
+};
+
+static const struct dmi_system_id acpi_method_override_dmi_ids[] __initconst = {
+	{
+		.ident = "Samsung Galaxy Book 930XDB/931XDB/930XDY",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "930XDB/931XDB/930XDY"),
+		},
+	},
+	{}
+};
+
+void __init acpi_quirk_override_broken_methods(void)
+{
+	acpi_status status;
+
+	if (!dmi_check_system(acpi_method_override_dmi_ids))
+		return;
+
+	status = acpi_install_method(samsung_930xdb_peg0_sta);
+	if (ACPI_FAILURE(status))
+		pr_warn(FW_BUG "Failed to replace broken PEG0._STA: %s\n",
+			acpi_format_exception(status));
+	else
+		pr_info(FW_BUG "Replaced broken PEG0._STA method\n");
+}
+
 static const struct override_status_id override_status_ids[] = {
 	/*
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a10a591c18b2..ebdd197dbbc4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -713,10 +713,12 @@ int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
 #ifdef CONFIG_X86
+void acpi_quirk_override_broken_methods(void);
 bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status);
 bool acpi_quirk_skip_acpi_ac_and_battery(void);
 int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip);
 #else
+static inline void acpi_quirk_override_broken_methods(void) { }
 static inline bool acpi_device_override_status(struct acpi_device *adev,
 					       unsigned long long *status)
 {
-- 
2.55.0

