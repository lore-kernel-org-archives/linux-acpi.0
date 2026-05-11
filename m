Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889EC37BE6A;
	Mon, 11 May 2026 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529152; cv=none; b=FhU4eJPipukXtpYcrheXEQFoO8DRdK04c62xscYON1radjHZLZwbK/Aee2gPlVzpkDhj4hIdhxi8WDXfzMO9rwWoCbSnLS9YuaSou3ilD2AHiA97EvYp9xBCyzsKuQJPw7B3A3XPEUdtj/2X52C/ZZcdX9B1uQQ79E+0aQmA6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529152; c=relaxed/simple;
	bh=zrR/yJPdUMBTcmr+qedJbEInUJQQw3Sq7s26smZu7w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nOMJVzfLATgiZhkuE2tMSkQHzFyS4sPaH/ibOVDqHLqmHqtxv6O2t658gD84QOUvmq4iySCuWrg+5mhQB/s7iSSvsDR6lw9SD5ckflNJjneCYZOcR7XPLdz0wmUQ5KDMBP8rKrq9TG3QGZF7mLfMp7wdY0wZyx3zyNOY8miOmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1jga7u+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1jga7u+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A17C2BCB0;
	Mon, 11 May 2026 19:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778529152;
	bh=zrR/yJPdUMBTcmr+qedJbEInUJQQw3Sq7s26smZu7w8=;
	h=From:To:Cc:Subject:Date:From;
	b=r1jga7u+X8y7pnzp7fiBVDhY0cX25/Erp/4+rMvoytNBiPHxm2or5c/pKi18cMSR7
	 OVfSNj845m4eaM8DZbwh1cPlIgXyuEIQ2Lou/7YTpFxEE5pucyLBwOw3camu5h6+xC
	 5x61RHpM6xr+/dD9FQw+w2lPSM7YgIh8xWpgXdwU6tj69v2rzVtU+7w30MAchDwJKG
	 cB7golAmQs6+2mgUOJ94JyGtHGcXQwEUMk6FgbmCuGlXHBhjy8GbNT1EmqljUNJjn1
	 yyN4AzIsOTf2/57jvDgYAInjf79w1Or4tTAafNJDn5wVeIqC47wq7gUnlDuBIJkNUe
	 iNNE1TcYGLWkA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, Andrea Ho <Andrea.Ho@advantech.com.tw>,
 Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>,
 Shravan Sudhakar <s.shravan@intel.com>, AceLan Kao <acelan.kao@canonical.com>
Subject:
 [PATCH v1] platform/x86: Add ACPI_COMPANION() checks against NULL to probe
Date: Mon, 11 May 2026 21:52:26 +0200
Message-ID: <4731840.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
against NULL to multiple platform/x86 drivers where they are missing.

Cc: stable@vger.kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/adv_swbutton.c            |    6 +++++-
 drivers/platform/x86/hp/hp_accel.c             |    3 +++
 drivers/platform/x86/intel/hid.c               |    6 +++++-
 drivers/platform/x86/intel/int1092/intel_sar.c |    7 ++++++-
 drivers/platform/x86/intel/vbtn.c              |    6 +++++-
 5 files changed, 24 insertions(+), 4 deletions(-)

--- a/drivers/platform/x86/adv_swbutton.c
+++ b/drivers/platform/x86/adv_swbutton.c
@@ -48,10 +48,14 @@ static int adv_swbutton_probe(struct pla
 {
 	struct adv_swbutton *button;
 	struct input_dev *input;
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	acpi_handle handle;
 	acpi_status status;
 	int error;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	button = devm_kzalloc(&device->dev, sizeof(*button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
--- a/drivers/platform/x86/hp/hp_accel.c
+++ b/drivers/platform/x86/hp/hp_accel.c
@@ -300,6 +300,9 @@ static int lis3lv02d_probe(struct platfo
 	int ret;
 
 	lis3_dev.bus_priv = ACPI_COMPANION(&device->dev);
+	if (!lis3_dev.bus_priv)
+		return -ENODEV;
+
 	lis3_dev.init = lis3lv02d_acpi_init;
 	lis3_dev.read = lis3lv02d_acpi_read;
 	lis3_dev.write = lis3lv02d_acpi_write;
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -688,12 +688,16 @@ static bool button_array_present(struct
 
 static int intel_hid_probe(struct platform_device *device)
 {
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	unsigned long long mode, dummy;
 	struct intel_hid_priv *priv;
+	acpi_handle handle;
 	acpi_status status;
 	int err;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	intel_hid_init_dsm(handle);
 
 	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_HDMM_FN, &mode)) {
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -245,15 +245,20 @@ static void sar_get_data(int reg, struct
 static int sar_probe(struct platform_device *device)
 {
 	struct wwan_sar_context *context;
+	acpi_handle handle;
 	int reg;
 	int result;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	context = kzalloc_obj(*context);
 	if (!context)
 		return -ENOMEM;
 
 	context->sar_device = device;
-	context->handle = ACPI_HANDLE(&device->dev);
+	context->handle = handle;
 	dev_set_drvdata(&device->dev, context);
 
 	result = guid_parse(SAR_DSM_UUID, &context->guid);
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -275,12 +275,16 @@ static bool intel_vbtn_has_switches(acpi
 
 static int intel_vbtn_probe(struct platform_device *device)
 {
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	bool dual_accel, has_buttons, has_switches;
 	struct intel_vbtn_priv *priv;
+	acpi_handle handle;
 	acpi_status status;
 	int err;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	dual_accel = dual_accel_detect();
 	has_buttons = acpi_has_method(handle, "VBDL");
 	has_switches = intel_vbtn_has_switches(handle, dual_accel);



