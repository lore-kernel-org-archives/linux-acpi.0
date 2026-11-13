Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575572;
	b=NMa7knbWmNGqBGXSG/MoiQsAhZw7Df1Q7oNNJJA1pX+lNwKalY13B38eJlqg9D38DZgv
	 zAToHO+8asl5QDv4BSxbPu4UpafX3ihyNuOj3bOEcQl/KIdJc4TU3U40M4tcBPszxywjL
	 qBUQJYBzYY05xfmXysGbUNh2kEyAFJfmaDqlZ+pJjZ3YfdHeFxgE7rp0gZY/OUoK0us4M
	 nrC6TyT2gytLvgamlqnNJfcJc59M9FsBIWeC4+P7KyLzfRdVsCTXPLux2VLyyROslm64O
	 CCAIlDgLhE4pY2iC5xVms7V6h7JkwqeB2BSIrBJMOuQMHIq1nTUuVKeqScOcWuCh0Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8PiBOHe9Tj+hW0OzsLVTDu5yoYjdKw6FZzkrALHidwQ=;
	b=IJDfWjGFw6H7BY6NOZM8aT64q6baraVyWKB0ASu/fFDZoAgfuLS24ES7CNk1RleeRG4s
	 3isY5syZNwkO8LFJ2uIEOEGEV7CKST1aP0CbAQWG0YsPx0cjb98mWRkEK+lDq4SG2o4z0
	 UpvseQlIuzsoHN7EBSDXqHMkNebMdRZrgAZaFqEMkauZvBJYu4kG7q1aQqroXpTCMdm7U
	 /65T7/6Z/ZJpuK+0kvWMnaFPhHZwtk9sQuuZFW103SQO0N/jnR8b2NV0S5vOotxUGkrTM
	 psaFU7cXbcH2WnC2AR5FpBL4GogDmUHCEoE92rTvJOBFYKrhwO1pYcvJ8r1STT717Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8iTE0pO;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D5606A32E
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 13:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 012D5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8iTE0pO
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b244fb7fffso897525c88.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 05:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794575571; x=1795180371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8PiBOHe9Tj+hW0OzsLVTDu5yoYjdKw6FZzkrALHidwQ=;
        b=B8iTE0pOCImi9swzNfOAkjgmdLZCmCK+3TJdQf6/8RpDUNaY8c0IkTeo7IkhBzuCmg
         FQlGZQCbhQ0ZNYbFvUFUHbQmKqwvO5o6TjyeVpSZgV/vBep85dI7tbPVYk/GLWO2QoLM
         AzV4AYJlEl57A+thuBklzyIIr4Jaz50tDzt2FO0q5v8giUiBcPIg+pW9VWWduHJ5nZok
         2a99iAAtX4OPpOHZ2oZTVk3HefgJb9I94IGy/zIdnoZsXW5R6K52EVySzlmxtBXd7ouG
         wT1XQtK/NSEqL9Flt6T4SCSckFW7ixc0RZ8Ai4BwUyD+T76Lkc8mDhM28hnZ7zVYP0eu
         GUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575571; x=1795180371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8PiBOHe9Tj+hW0OzsLVTDu5yoYjdKw6FZzkrALHidwQ=;
        b=uAk2d3scdNYbXBP6QapotcBe8gm9AlS7F3VLCZf9rloywholhYFkQrmhOC5XXBqmcI
         BP+H99WLS7nbtXIU4EFnJw8c7AzDVd81Hh0ijxFecfz3gvgMNrzVZW6Vsvj7OZmVCSLK
         BWuQgmb6uda+kQu+vdL0snqeAePfxrUBCSuLP0hgQgPkL5DkwyzwMesOXlKONgGqZFAu
         /wFwfeqUgdJpodxRSkFUo4Fx61UyVQyyBNDWPOPvDPKlELoxIbSHNzJcXfhG9sABY4Wg
         BP0fv1Cbrx0+pde7+6RG1WcwW2GbOQ0M2ur9qyAOo/PgG7R7D5kgYP4jsxui4Jr4D1s1
         Xedg==
X-Forwarded-Encrypted: i=1; AL+hErFfMEFiOYXcUAfUrAbjBi+isQRuvciCVNXC+oQZtciYIaF/hpfV7vyksOatCuP2x+RjQPs7VCXFhf9S@vger.kernel.org
X-Gm-Message-State: APuU4Z+fxnYUilmHK0EWsGpPo0jUdWlZ8q/Jyf92TZGblA+bSCND3bGH
	KVOfpZNqmZHvt9uVrypNzr3vPvj3WrEHTY7ni/6nRM1yL/G27f7lxDxv8RSnGNc=
X-Gm-Gg: AYBFou1iL433CxBHjYgcJa3mUm+14uDjovKAoVIclQkX4vFLYzim1T4Uoghx1QSyiur
	eWz3W6tIanL9TBpFYeeey+xyDxwmVVkP5jEB4sNA7VfbrK8NQxTVOuHfdyOgVQGoyXAM3Kxjo7m
	8ivL+cy35TB/QBokKxhHRMz4gdBvSoErz3ZcPsyqGp8X2DK/0rYkyev2umrUZUK1xWcPffUjIss
	Mkd51GauQzpJKK25Bt2AVe1kO3is5oBEepKqTLiGeCJ+T3Bm2ZbO27D8LGK+9HvnwirARbfioVr
	UnYMK1k74rA1vNDBF+JHcjdh5mWlwD2hwTlhEme7omEHr8j1VGPmtJHIFuUc4wHYd2/a+FSkhQq
	vGd1BEaWvvcyNHDafaOggPIiT0QmsYRacWExk2AfTF9G6CG9BMq/fqKTOGEumKTXIA55VEtknd2
	Wt275ifyThCa19wiFbzRPVblTFfC+MoMVbZbC9O3IuWSXMt5Wt5gUXGUju9N02jjqQCj2tdxpTP
	/pkDh9FYoFM3bJYfFP6GIzrKQ6Dx6OGodiNNaZJ2BgInNtImUdn0HQU3hg1otqyX76SBMTLdvIb
	xWuiVfXfKV5yWJPjMsRcU7sL43W1+xL1afYdwH7ZPZouY6UlHd6jGMqHOq+fpH5yRg==
X-Received: by 2002:a05:701b:418c:10b0:1a8:ff0b:a4e1 with SMTP id a92af1059eb24-1b5030fc737mr2542914c88.18.1794575570865;
        Fri, 13 Nov 2026 05:12:50 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.205.242.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm7830420c88.14.2026.11.13.05.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:12:50 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ACPI: processor: Use Apple-specific methods for P/C-states
Date: Fri, 13 Nov 2026 08:12:40 -0500
Message-ID: <20261113131243.28214-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Use APSS and ACST instead of _PSS and _CST when available on Intel Macs
as they include better P/C-States.
These methods are used in macOS (X86PlatformPlugin.kext),
and when not found we fallback to generic _PSS and _CST methods.

Changes in v2:
- Improved description of the patch
- Replaced goto's and if statement's with new functions
- Added support to differentiate _PSS and APSS in debug info/error info
- Added support to differentiate _CST and ACST in debug info/error info
- Used Package instead of variable for ACST description

Link to v1:
https://lore.kernel.org/all/20261015204450.1270-1-atharvatiwarilinuxdev@gmail.com/

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/acpi/acpi_processor.c    | 80 +++++++++++++++++++++-----------
 drivers/acpi/processor_perflib.c | 43 +++++++++++++----
 2 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5fbab5417..bbe471b3c 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
 
 #include <acpi/processor.h>
@@ -815,6 +816,22 @@ bool acpi_processor_claim_cst_control(void)
 }
 EXPORT_SYMBOL_NS_GPL(acpi_processor_claim_cst_control, "ACPI_PROCESSOR_IDLE");
 
+static int acpi_processor_apple_acst(acpi_handle handle, struct acpi_buffer *buffer)
+{
+	acpi_status status;
+
+	if (!x86_apple_machine)
+		return 0;
+
+	status = acpi_evaluate_object(handle, "ACST", NULL, buffer);
+	if (ACPI_FAILURE(status)) {
+		buffer->length = ACPI_ALLOCATE_BUFFER;
+		buffer->pointer = NULL;
+		return 0;
+	}
+
+	return 1;
+}
 /**
  * acpi_processor_evaluate_cst - Evaluate the processor _CST control method.
  * @handle: ACPI handle of the processor object containing the _CST.
@@ -837,28 +854,35 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 	acpi_status status;
 	u64 count;
 	int last_index = 0;
-	int i, ret = 0;
+	int i, ret = 0, base = 0;
+	bool using_acst = false;
 
-	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(handle, "No _CST\n");
-		return -ENODEV;
+	using_acst = acpi_processor_apple_acst(handle, &buffer);
+	if (using_acst)
+		base = 1; /* ACST is a 4 field package we need to skip the first field */
+
+	if (!using_acst) {
+		status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_debug(handle, "No _CST\n");
+			return -ENODEV;
+		}
 	}
 
 	cst = buffer.pointer;
 
-	/* There must be at least 2 elements. */
-	if (!cst || cst->type != ACPI_TYPE_PACKAGE || cst->package.count < 2) {
-		acpi_handle_warn(handle, "Invalid _CST output\n");
+	/* There must be at least 2 elements for _CST and at least 3 elements for ACST. */
+	if (!cst || cst->type != ACPI_TYPE_PACKAGE || cst->package.count < base + 2) {
+		acpi_handle_warn(handle, "Invalid %s output\n", using_acst ? "ACST" : "_CST");
 		ret = -EFAULT;
 		goto end;
 	}
 
-	count = cst->package.elements[0].integer.value;
+	count = cst->package.elements[base].integer.value;
 
 	/* Validate the number of C-states. */
-	if (count < 1 || count != cst->package.count - 1) {
-		acpi_handle_warn(handle, "Inconsistent _CST data\n");
+	if (count < 1 || count != cst->package.count - 1 - base) {
+		acpi_handle_warn(handle, "Inconsistent %s data\n", using_acst ? "ACST" : "_CST");
 		ret = -EFAULT;
 		goto end;
 	}
@@ -882,24 +906,24 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		memset(&cx, 0, sizeof(cx));
 
-		element = &cst->package.elements[i];
+		element = &cst->package.elements[base + i];
 		if (element->type != ACPI_TYPE_PACKAGE) {
-			acpi_handle_info(handle, "_CST C%d type(%x) is not package, skip...\n",
-					 i, element->type);
+			acpi_handle_info(handle, "%s C%d type(%x) is not package, skip...\n",
+					 using_acst ? "ACST" : "_CST", i, element->type);
 			continue;
 		}
 
 		if (element->package.count != 4) {
-			acpi_handle_info(handle, "_CST C%d package count(%d) is not 4, skip...\n",
-					 i, element->package.count);
+			acpi_handle_info(handle, "%s C%d package count(%d) is not 4, skip...\n",
+					 using_acst ? "ACST" : "_CST", i, element->package.count);
 			continue;
 		}
 
 		obj = &element->package.elements[0];
 
 		if (obj->type != ACPI_TYPE_BUFFER) {
-			acpi_handle_info(handle, "_CST C%d package element[0] type(%x) is not buffer, skip...\n",
-					 i, obj->type);
+			acpi_handle_info(handle, "%s C%d package element[0] type(%x) is not buffer, skip...\n",
+					 using_acst ? "ACST" : "_CST", i, obj->type);
 			continue;
 		}
 
@@ -907,8 +931,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		obj = &element->package.elements[1];
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			acpi_handle_info(handle, "_CST C[%d] package element[1] type(%x) is not integer, skip...\n",
-					 i, obj->type);
+			acpi_handle_info(handle, "%s C[%d] package element[1] type(%x) is not integer, skip...\n",
+					 using_acst ? "ACST" : "_CST", i, obj->type);
 			continue;
 		}
 
@@ -947,8 +971,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 				cx.entry_method = ACPI_CSTATE_HALT;
 				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
 			} else {
-				acpi_handle_info(handle, "_CST C%d declares FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
-						 i);
+				acpi_handle_info(handle, "%s C%d declares FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
+						 using_acst ? "ACST" : "_CST", i);
 				continue;
 			}
 		} else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -956,8 +980,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
 				 cx.address);
 		} else {
-			acpi_handle_info(handle, "_CST C%d space_id(%x) neither FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
-					 i, reg->space_id);
+			acpi_handle_info(handle, "%s C%d space_id(%x) neither FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
+					 using_acst ? "ACST" : "_CST", i, reg->space_id);
 			continue;
 		}
 
@@ -966,8 +990,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		obj = &element->package.elements[2];
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			acpi_handle_info(handle, "_CST C%d package element[2] type(%x) not integer, skip...\n",
-					 i, obj->type);
+			acpi_handle_info(handle, "%s C%d package element[2] type(%x) not integer, skip...\n",
+					 using_acst ? "ACST" : "_CST", i, obj->type);
 			continue;
 		}
 
@@ -975,8 +999,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		obj = &element->package.elements[3];
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			acpi_handle_info(handle, "_CST C%d package element[3] type(%x) not integer, skip...\n",
-					 i, obj->type);
+			acpi_handle_info(handle, "%s C%d package element[3] type(%x) not integer, skip...\n",
+					 using_acst ? "ACST" : "_CST", i, obj->type);
 			continue;
 		}
 
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 9e25d6124..9b9533649 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -17,6 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/platform_data/x86/apple.h>
 #include <acpi/processor.h>
 #ifdef CONFIG_X86
 #include <asm/cpufeature.h>
@@ -313,6 +314,23 @@ static void amd_fixup_frequency(struct acpi_processor_px *px, int i)
 	}
 }
 
+static int acpi_evaluate_apple_apss(acpi_handle handle, struct acpi_buffer *buffer)
+{
+	acpi_status status;
+
+	if (!x86_apple_machine)
+		return 0;
+
+	status = acpi_evaluate_object(handle, "APSS", NULL, buffer);
+	if (ACPI_FAILURE(status)) {
+		buffer->length = ACPI_ALLOCATE_BUFFER;
+		buffer->pointer = NULL;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -323,16 +341,21 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	union acpi_object *pss = NULL;
 	int i;
 	int last_invalid = -1;
+	bool using_apss;
 
-	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		acpi_evaluation_failure_warn(pr->handle, "_PSS", status);
-		return -ENODEV;
+	using_apss = acpi_evaluate_apple_apss(pr->handle, &buffer);
+
+	if (!using_apss) {
+		status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_evaluation_failure_warn(pr->handle, "_PSS", status);
+			return -ENODEV;
+		}
 	}
 
 	pss = buffer.pointer;
 	if (!pss || pss->type != ACPI_TYPE_PACKAGE) {
-		pr_err("Invalid _PSS data\n");
+		pr_err("Invalid %s data\n", using_apss ? "APSS" : "_PSS");
 		result = -EFAULT;
 		goto end;
 	}
@@ -360,7 +383,8 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 		status = acpi_extract_package(&(pss->package.elements[i]),
 					      &format, &state);
 		if (ACPI_FAILURE(status)) {
-			acpi_handle_warn(pr->handle, "Invalid _PSS data: %s\n",
+			acpi_handle_warn(pr->handle, "Invalid %s data: %s\n",
+					 using_apss ? "APSS" : "_PSS",
 					 acpi_format_exception(status));
 			result = -EFAULT;
 			kfree(pr->performance->states);
@@ -384,8 +408,8 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 		if (!px->core_frequency ||
 		    (u32)(px->core_frequency * 1000) != px->core_frequency * 1000) {
 			pr_err(FW_BUG
-			       "Invalid BIOS _PSS frequency found for processor %d: 0x%llx MHz\n",
-			       pr->id, px->core_frequency);
+			       "Invalid BIOS %s frequency found for processor %d: 0x%llx MHz\n",
+			       using_apss ? "APSS" : "_PSS", pr->id, px->core_frequency);
 			if (last_invalid == -1)
 				last_invalid = i;
 		} else {
@@ -402,7 +426,8 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 
 	if (last_invalid == 0) {
 		pr_err(FW_BUG
-			   "No valid BIOS _PSS frequency found for processor %d\n", pr->id);
+			   "No valid BIOS %s frequency found for processor %d\n",
+			   using_apss ? "APSS" : "_PSS",  pr->id);
 		result = -EFAULT;
 		kfree(pr->performance->states);
 		pr->performance->states = NULL;
-- 
2.55.0

