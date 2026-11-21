Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795298329;
	b=sreUHjTIEb63EFefF48D6/5yH8rKlqZVmFTzZ0/j9cHGh/eKR/kGqxJIAK6p9zhVmKka
	 t7CF0yduN8eOOoV3xQhIiCDGikw0sKufEeaODd0OSJZSGtrJ42hYlHi6XXdiN3yqfl297
	 hePTEUkLeJZTmM0CZB45/NI9+X7acHffuG5IcIOBCXd0QM2BvoVCrCRtPPfIXLWVlIKSz
	 B6KsBFe5NDgVDmn5OkA6Qpr+GVuqMpSxvQE7ICNG4E7dKFuk/FDLaNK2No6cSefLCyq1V
	 SPyPnZqNay8eJH52+rx2Fz//Bm6EafGrMV8gyrPSUI2j5h5hZnfBMpVeEJKk2tpl/oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795298329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=46VDdhvfENPzlaXJtPGRjqKkSBNfoMZg5S+SSN5ITC4=;
	b=IjzuUmd975GrbSfUww5VSAVSvgJzt4bZYsUC0oeO7NiOK/GJ5QSHysH7sX2Uo3FVjMS6
	 7vpvBoHLkKDKz7BeoWuM7tUDyvNNW/mpRgDjc8DmgN+eInTrhDKl6Y/6sDGgRcyl2X9Ju
	 jK0KasjInjv3zNEVY7+Ga2Gh04mpfOVAwruIrK9FD8J9hkOX3MRXmanTl/nO1ISL2krtE
	 N9BfDbfdPgQjBzlRDStRi0jZEhuo2NsQcQ9zSIFfT+uyzisXmKsC/M29snxSuXdjLJkFe
	 vudaNxkSci52W6Qa1/UkPVf9mYx3WAnRPFbBCu00JocNKhda0uC9MUdMt5V2wDDsGAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bJoyM5hI;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796C3606A32A
	for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 21:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 796C3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bJoyM5hI
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3866a784546so2354042eec.0
        for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 13:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795298327; x=1795903127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=46VDdhvfENPzlaXJtPGRjqKkSBNfoMZg5S+SSN5ITC4=;
        b=bJoyM5hIwxNrj1Qx6L6ywM19qg3W9QDVQjNGn1u9sUw0J35VmcgG3TY1Dfgkz+GB3k
         8+ldL+il//9AvFrc9Hkzd/I3hIIQE0HfcKYcZe0I1cqge2D5qz33UW2MyPTpi13m5pZD
         06Wz033gRZ4gdt/2D18hFUBx4cZTJqw38jDmAyHuQYuG2pad/mt765kNoT/4W/YK/aHY
         fRaEkWh+jh806hu1PxZH04s6H6Or3CWfoQ5sXTVwXGJncXtwqeRgfpz9ls4r5IS70KgL
         BFU88ppAaT/NgZqVJI4+WM7qNVp/2JpJTfJ/AXkZDNvX6ZIGfA2v1USFXYy3Ao292wXc
         NJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795298327; x=1795903127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=46VDdhvfENPzlaXJtPGRjqKkSBNfoMZg5S+SSN5ITC4=;
        b=Q3FBn3f4h7CLFkDiTV5efcvT8vTtRX+AyaHVIPWImIfILiCedPsgS8N/fvcfjpeUup
         8bu4EnUnXFRqN5QeaRYcrUedxhkwj9u8mySxSy21cY4cmWHUGuP6y7umIwmXG/jerutU
         7v6r8GyeWVTQGtb5znF8QKgGv9PylvHUkQkRPjaoePQp2h1Xd7IKQcOXV4RiBTRFKchJ
         jFXy6AYLjilhmo0FuZcBFj9iTuLzpj6DYMJ9g7uT472DS68+YJScvoBy9L/oVJnFqqow
         XXlJMXDix5plZu0lJjQJqCjT/dec73NLJ0JFrjt7g9l7pLdR45Zvx9AMddC6yD1ss1l6
         8Ftg==
X-Forwarded-Encrypted: i=1; AL+hErFluQTan00CNmHFrx7o+qV3RHcnt1qczACC8m5QcdT5IXZFiKsgdCRZVCneOcx6UrxowgW9/X8TsHNk@vger.kernel.org
X-Gm-Message-State: APuU4Z+c5xQIIEEGU3HL+hrlhcl4aPIbtYJOWCN3nPo981y54UjE61SC
	m7Gi4k/ZOttsh1P2jLXfliQ7DUqkMuye8A+iStOlCOEopN22SHMDWLc=
X-Gm-Gg: AZFdTZemPaaBrLOZL7O8g9SK51POiTFoeuFfXWxocqJSluKIQcOdSEowUrqwhRSLPCX
	OC4zxCKDUhFlWky4NsfccqVWnaY3ghMg59CNlPElE8ik278Yss2Q/yYJV1OXsG1uTHTMuUYTq7/
	S9SiHoRAMKvIocNBlIM61XYd6ROQXPSY+eydTiiCu6mkZDntJynnSbgRD94OwQBLLYIfGxYL12p
	N0Qq7evOKZE+XxXQAHjWd6jF7OWKbVAOS7kac+QhoUEoROc3uVBCQiCoC+ON8Ckekbb9D/5pisw
	mrE+j+ICGd3xCqA/2EIriaS9uvKZU41/vIH82I2kAoq4BIdy2jr28KvpiqwIf6Tc2pF2JoWYFmi
	gGD4PEKfx72XKHjHduoswIxjPM1ODDjYe/BJsnTjXYtDO0LxF+sJxaGjHmMBv55nvtbl+9ty2Vq
	z8tCrnaXAxUO2VuDM9ok7yFFpK9esfa98994JWIMcc7fjsMdAytsNxEsujtC8EE4NAqvaJS71BG
	6e9FFbgh0l+l31f0TnkfqprO5TWPdcBP055whmO1cDe1I0jFjbez54roe0UjjgxbfN9Q4vqoRpr
	4jsk7RuDcQLUHaCXgoFbiwsoTFCrnltC/j/rx9vJFtMWG5WJJK6WLb8xeisk8+dpzl6IDte+eYr
	1Ig/otO+O
X-Received: by 2002:a05:693c:8813:10b0:385:cbc5:7eeb with SMTP id 5a478bee46e88-385cbc595acmr5922819eec.15.1795298327326;
        Sat, 21 Nov 2026 13:58:47 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009.tailbdca44.ts.net ([223.228.8.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567ea2cc5sm19646544eec.29.2026.11.21.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:58:46 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Antoine Sidem <sidemantoine@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] ACPI: processor: Use Apple-specific methods for P/C-states
Date: Sat, 21 Nov 2026 16:58:38 -0500
Message-ID: <20261121215841.1286-1-atharvatiwarilinuxdev@gmail.com>
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

Changes in v3:
- Used method variable instead of using_
- Used bool instead of int for functions

Changes in v2:
- Improved description of the patch
- Replaced goto's and if statement's with new functions
- Added support to differentiate _PSS and APSS in debug info/error info
- Added support to differentiate _CST and ACST in debug info/error info
- Used Package instead of variable for ACST description

Link to v2:
https://lore.kernel.org/all/20261113131243.28214-1-atharvatiwarilinuxdev@gmail.com/

Link to v1:
https://lore.kernel.org/all/20261015204450.1270-1-atharvatiwarilinuxdev@gmail.com/

Tested-by: Antoine Sidem <sidemantoine@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/acpi/acpi_processor.c    | 79 +++++++++++++++++++++-----------
 drivers/acpi/processor_perflib.c | 43 +++++++++++++----
 2 files changed, 85 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5fbab5417..65e52cd52 100644
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
 
+static bool acpi_processor_apple_acst(acpi_handle handle, struct acpi_buffer *buffer)
+{
+	acpi_status status;
+
+	if (!x86_apple_machine)
+		return false;
+
+	status = acpi_evaluate_object(handle, "ACST", NULL, buffer);
+	if (ACPI_FAILURE(status)) {
+		buffer->length = ACPI_ALLOCATE_BUFFER;
+		buffer->pointer = NULL;
+		return false;
+	}
+
+	return true;
+}
 /**
  * acpi_processor_evaluate_cst - Evaluate the processor _CST control method.
  * @handle: ACPI handle of the processor object containing the _CST.
@@ -837,28 +854,34 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 	acpi_status status;
 	u64 count;
 	int last_index = 0;
-	int i, ret = 0;
+	int i, ret = 0, base = 0;
+	const char *method = "_CST";
 
-	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(handle, "No _CST\n");
-		return -ENODEV;
+	if (acpi_processor_apple_acst(handle, &buffer)) {
+		base = 1; /* ACST is a 4 field package we need to skip the first field */
+		method = "ACST";
+	} else {
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
+		acpi_handle_warn(handle, "Invalid %s output\n", method);
 		ret = -EFAULT;
 		goto end;
 	}
 
-	count = cst->package.elements[0].integer.value;
+	count = cst->package.elements[base].integer.value;
 
 	/* Validate the number of C-states. */
-	if (count < 1 || count != cst->package.count - 1) {
-		acpi_handle_warn(handle, "Inconsistent _CST data\n");
+	if (count < 1 || count != cst->package.count - 1 - base) {
+		acpi_handle_warn(handle, "Inconsistent %s data\n", method);
 		ret = -EFAULT;
 		goto end;
 	}
@@ -882,24 +905,24 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		memset(&cx, 0, sizeof(cx));
 
-		element = &cst->package.elements[i];
+		element = &cst->package.elements[base + i];
 		if (element->type != ACPI_TYPE_PACKAGE) {
-			acpi_handle_info(handle, "_CST C%d type(%x) is not package, skip...\n",
-					 i, element->type);
+			acpi_handle_info(handle, "%s C%d type(%x) is not package, skip...\n",
+					 method, i, element->type);
 			continue;
 		}
 
 		if (element->package.count != 4) {
-			acpi_handle_info(handle, "_CST C%d package count(%d) is not 4, skip...\n",
-					 i, element->package.count);
+			acpi_handle_info(handle, "%s C%d package count(%d) is not 4, skip...\n",
+					 method, i, element->package.count);
 			continue;
 		}
 
 		obj = &element->package.elements[0];
 
 		if (obj->type != ACPI_TYPE_BUFFER) {
-			acpi_handle_info(handle, "_CST C%d package element[0] type(%x) is not buffer, skip...\n",
-					 i, obj->type);
+			acpi_handle_info(handle, "%s C%d package element[0] type(%x) is not buffer, skip...\n",
+					 method, i, obj->type);
 			continue;
 		}
 
@@ -907,8 +930,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		obj = &element->package.elements[1];
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			acpi_handle_info(handle, "_CST C[%d] package element[1] type(%x) is not integer, skip...\n",
-					 i, obj->type);
+			acpi_handle_info(handle, "%s C[%d] package element[1] type(%x) is not integer, skip...\n",
+					 method, i, obj->type);
 			continue;
 		}
 
@@ -947,8 +970,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 				cx.entry_method = ACPI_CSTATE_HALT;
 				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
 			} else {
-				acpi_handle_info(handle, "_CST C%d declares FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
-						 i);
+				acpi_handle_info(handle, "%s C%d declares FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
+						 method, i);
 				continue;
 			}
 		} else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -956,8 +979,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
 				 cx.address);
 		} else {
-			acpi_handle_info(handle, "_CST C%d space_id(%x) neither FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
-					 i, reg->space_id);
+			acpi_handle_info(handle, "%s C%d space_id(%x) neither FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
+					 method, i, reg->space_id);
 			continue;
 		}
 
@@ -966,8 +989,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		obj = &element->package.elements[2];
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			acpi_handle_info(handle, "_CST C%d package element[2] type(%x) not integer, skip...\n",
-					 i, obj->type);
+			acpi_handle_info(handle, "%s C%d package element[2] type(%x) not integer, skip...\n",
+					 method, i, obj->type);
 			continue;
 		}
 
@@ -975,8 +998,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		obj = &element->package.elements[3];
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			acpi_handle_info(handle, "_CST C%d package element[3] type(%x) not integer, skip...\n",
-					 i, obj->type);
+			acpi_handle_info(handle, "%s C%d package element[3] type(%x) not integer, skip...\n",
+					 method, i, obj->type);
 			continue;
 		}
 
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 9e25d6124..0844147d9 100644
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
 
+static bool acpi_evaluate_apple_apss(acpi_handle handle, struct acpi_buffer *buffer)
+{
+	acpi_status status;
+
+	if (!x86_apple_machine)
+		return false;
+
+	status = acpi_evaluate_object(handle, "APSS", NULL, buffer);
+	if (ACPI_FAILURE(status)) {
+		buffer->length = ACPI_ALLOCATE_BUFFER;
+		buffer->pointer = NULL;
+		return false;
+	}
+
+	return true;
+}
+
 static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -323,16 +341,21 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	union acpi_object *pss = NULL;
 	int i;
 	int last_invalid = -1;
+	const char *method = "_PSS";
 
-	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		acpi_evaluation_failure_warn(pr->handle, "_PSS", status);
-		return -ENODEV;
+	if (acpi_evaluate_apple_apss(pr->handle, &buffer))
+		method = "APSS";
+	else {
+		status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_evaluation_failure_warn(pr->handle, "_PSS", status);
+			return -ENODEV;
+		}
 	}
 
 	pss = buffer.pointer;
 	if (!pss || pss->type != ACPI_TYPE_PACKAGE) {
-		pr_err("Invalid _PSS data\n");
+		pr_err("Invalid %s data\n", method);
 		result = -EFAULT;
 		goto end;
 	}
@@ -360,7 +383,8 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 		status = acpi_extract_package(&(pss->package.elements[i]),
 					      &format, &state);
 		if (ACPI_FAILURE(status)) {
-			acpi_handle_warn(pr->handle, "Invalid _PSS data: %s\n",
+			acpi_handle_warn(pr->handle, "Invalid %s data: %s\n",
+					 method,
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
+			       method, pr->id, px->core_frequency);
 			if (last_invalid == -1)
 				last_invalid = i;
 		} else {
@@ -402,7 +426,8 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 
 	if (last_invalid == 0) {
 		pr_err(FW_BUG
-			   "No valid BIOS _PSS frequency found for processor %d\n", pr->id);
+			   "No valid BIOS %s frequency found for processor %d\n",
+			   method, pr->id);
 		result = -EFAULT;
 		kfree(pr->performance->states);
 		pr->performance->states = NULL;
-- 
2.55.0

