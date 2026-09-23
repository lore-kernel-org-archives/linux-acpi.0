Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4035335B9
	for <linux-acpi@vger.kernel.org>; Wed, 23 Sep 2026 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171777; cv=none; b=JwYTfLpv6aKzQLep805kH/dxsC1u15HqTGSHKG7Y1Du9obUc4zdQbXDIYBI/249ixw/rUD8haz2c6F3ElkpS3QNsVI18uu+kRCoMB5UNx3grnh1fOnxXnuvsvU167fnvOZ/2rbHoLT0mmNXP91Y3xPuW5v8cLySWSc3tRA/ia8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171777; c=relaxed/simple;
	bh=PIteZWa4n/4/s6b1grr7aq1+OnmO5GHcHgcavBmaE0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqx/Mf9HP0Dr9VGbe7KRk98b/H3KO3UeUGfWMu3fk2ubFyXw0mot0UcC1Q7KYV4PPi68n7w+S3VaQYirY3qI01qT+hWLgOFm2Jy+H0xkID+U08nw/g38RWhvkoc5Fgt2F3+HNQphP7U8guLsprwiKsgDAb4jDj4tpkyzAiIDiSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl6ME6gI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl6ME6gI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7c6dbc60so563645e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 23 Sep 2026 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171774; x=1790776574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q1gZqZtvclwtxTtPXDls2VJoXIxSgk6dbY9BElBRXA4=;
        b=Fl6ME6gIzOD9ogwBC1tdCf3YRdOn0GU5uVeoMmxw7tQt5aclgxgOcJ3JLKdkVtRugQ
         YVcnypZChfYchCjVBZ2CyaRABOCPk908E4zfA9JZh7TdZlgJE2gzpcLOacbJF+MTmi0L
         U78D+KmJUipiHw104z5FhSdlab3wfTSpOrLpxyruf/MG7mkM15xfk71/JHg0D66raiQm
         ZuFDGhceIMS8CIFbO0S+3Nni93qfKnvFZG7xxVOu7Twc0l2ierdfhdV5GnkMSCUwDYjw
         eEYpUHczoaIS6fIo0mYs6PoO7T+bCRRJpXG0UI0GOFMKdqf9pj6sU/WbKGhnzwl3OG/z
         83cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171774; x=1790776574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q1gZqZtvclwtxTtPXDls2VJoXIxSgk6dbY9BElBRXA4=;
        b=uQwd0mpSPyhPi5WOX9n4CiHgaZZdzpyfrjVM6Q/QbjnhrtZXhnCxFgGBQdMxEUHgMJ
         LtsCo/cPYb6VsnXXdUomJpWumtFUQvqtYtI0A7BxxZGO/03OCPBp2CXSK1S0KbK5pWZK
         FnrYIQ4r3lQojmaaZGHzdqqsLW2lPhmRrcx2qAdLzDOl2zSufYYL7aYNvIex0Rx2Diq9
         8QO/KDN/Kq3mVXVIEb6yzIATmw2Own7P/8kIm43VND4r78Mq2RCXZcpNltrxTRIcmWWX
         zVUl0tfHFDfTZJSPaJaoZFwyp0hIPY77GfzaLW0nBZ/mNwZerwggm1eYRuCfVaxLayM8
         sxOA==
X-Forwarded-Encrypted: i=1; AKwUvBxx3bAxMO0L1SSLVoZWwVccnn/z8uGThnFiQSyD8MOu4kYehc7bYTMAFa4Hb1bPrsJvQP8G4jiSNAOQ@vger.kernel.org
X-Gm-Message-State: AFuF++lEXSdB6YU3JXxMUzV18c+XJcdPEiNOAWfXVRELa3F4BXmhUj/K
	c1f+kGl+OEtf/aRAzD8/xlZIbkdmevgININwrNl1WxA8wm8QzK5RMWiq
X-Gm-Gg: AYBFou0gypUItDoW08We3fr+m5bMfPTjDUdOVah4UVX0Q2f6AiHInlQ2ZU7sZQTFQvE
	B7LLbYAqifPxIZ9/yKWkWp13N+BUwIRFrxek9OJS7CSe8dtUra3/dahDJwHMK1/BaVxDa3sesop
	BAgCTA5Ueb6NH4cU9nWvsmMI8bWQORAR9banJctiuDsYnX0aYKUe3njkrrvEIyEPh/JKebX7GqI
	y3GL/Www7zJuYw2D/jMpViqVCA7CAzmULnzFFW/7rRUP/1elHnsTJDr6qaWOR8LclTzC+/9aDc5
	gQvdaFHRblAFIEsrzGHqSHt1dFRE8AycOOPq4jRsqrfBjag6Pd2O8vdHQnetzg7+b4KFiXkWv7f
	dBnXC4k13mhpLXGUmo+BoQYq8SlmAzyQGPm+SHJNS216P+hHw88uA6ys/pQ0WFJYSR//wL19cE0
	GDa7UiyK4bSEvotvR87hpuQIr+IDOM0abIw1bxTcs/mhLHruGI0qtj7oGkFC02PJWpaZEBzMRNF
	xBVzWIpHsuFggVrQXWFmfX7sGNAi3yKnabcPjN3FFgToaweR9FlxkjYZxrjgy+a/i4rTx+GQh7y
	+dm4eR1Rupo=
X-Received: by 2002:a05:600c:a16:b0:49e:745d:5768 with SMTP id 5b1f17b1804b1-49fdec989e7mr36910135e9.0.1790171773804;
        Wed, 23 Sep 2026 06:56:13 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1aa057sm78208155e9.13.2026.09.23.06.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:56:13 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: acpica-devel@lists.linux.dev
Cc: Zijing Yin <yzjaurora@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] dispatcher: Fix NULL pointer dereference in AcpiDsTerminateControlMethod()
Date: Wed, 23 Sep 2026 06:56:02 -0700
Message-ID: <20260923135604.428982-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If AcpiUtCreateThreadState() fails in AcpiPsParseAml(), the error path
calls AcpiDsTerminateControlMethod() before WalkState->Thread is set.
A top-level method invocation creates its walk state without a thread,
so for a Serialized method the sync level restore dereferences NULL:

    WalkState->Thread->CurrentSyncLevel =
        MethodDesc->Method.Mutex->Mutex.OriginalSyncLevel;

I ran into this while fuzzing Linux, where reading the "status" sysfs
attribute of an ACPI device with a Serialized _STA oopses when that
allocation fails:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:acpi_ds_terminate_control_method+0x7ae/0xa80
  Call Trace:
   <TASK>
   acpi_ps_parse_aml+0xece/0x1170
   acpi_ps_execute_method+0x5c4/0xe90
   acpi_ns_evaluate+0x633/0x16d0
   acpi_evaluate_object+0x4ca/0xdf0
   acpi_evaluate_integer+0xdd/0x230
   status_show+0xa0/0x120
   </TASK>

For a top-level call, AcpiDsBeginMethodExecution() gets no walk state
and does not take OriginalSyncLevel from a thread. Here there is no
thread to restore it to either, so skip the restore when
WalkState->Thread is NULL, but keep releasing the mutex, since
AcpiDsBeginMethodExecution() did acquire it.

Fixes: 2107ff8b75d3 ("Fix possible memory leak on error in parser.")
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
On Linux with fault injection, 3 of 3 boots oopsed without this patch
and none did with it. It also reproduces in acpiexec by making
AcpiUtCreateThreadState() fail once for a Serialized method.

Reproducer (gcc -static; needs CONFIG_FAULT_INJECTION, CONFIG_FAILSLAB
and CONFIG_FAULT_INJECTION_DEBUG_FS, run as root). It reads every ACPI
device's "status" attribute with the Nth allocation forced to fail, N
counting down from 128. On QEMU the CPU _STA methods are Serialized:

	#include <dirent.h>
	#include <fcntl.h>
	#include <stdio.h>
	#include <unistd.h>

	int main(void)
	{
		char path[512], buf[256];
		struct dirent *e;
		int fd, nth, n, failed = 0;
		DIR *d;

		/* let fail-nth fail GFP_KERNEL allocations too */
		fd = open("/sys/kernel/debug/failslab/ignore-gfp-wait", O_WRONLY);
		if (fd < 0 || write(fd, "N", 1) != 1) {
			perror("failslab/ignore-gfp-wait");
			return 1;
		}
		close(fd);

		d = opendir("/sys/bus/acpi/devices");
		while (d && (e = readdir(d))) {
			snprintf(path, sizeof(path), "/sys/bus/acpi/devices/%s/status",
				 e->d_name);
			for (n = 128; n >= 1; n--) {
				fd = open(path, O_RDONLY);
				if (fd < 0)
					break;
				nth = open("/proc/thread-self/fail-nth", O_WRONLY);
				dprintf(nth, "%d", n);
				if (read(fd, buf, sizeof(buf)) < 0)
					failed++;
				dprintf(nth, "0");
				close(nth);
				close(fd);
			}
		}
		printf("done, %d reads failed\n", failed);
		return 0;
	}

If you prefer a GitHub PR for this, I can open one.

 source/components/dispatcher/dsmethod.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/source/components/dispatcher/dsmethod.c b/source/components/dispatcher/dsmethod.c
index caad11543..96d92454e 100644
--- a/source/components/dispatcher/dsmethod.c
+++ b/source/components/dispatcher/dsmethod.c
@@ -866,8 +866,17 @@ AcpiDsTerminateControlMethod (
             MethodDesc->Method.Mutex->Mutex.AcquisitionDepth--;
             if (!MethodDesc->Method.Mutex->Mutex.AcquisitionDepth)
             {
-                WalkState->Thread->CurrentSyncLevel =
-                    MethodDesc->Method.Mutex->Mutex.OriginalSyncLevel;
+                /*
+                 * There is no thread state if AcpiPsParseAml() failed to
+                 * create one. AcpiDsBeginMethodExecution() did not take
+                 * OriginalSyncLevel from a thread in that case, and there
+                 * is no thread to restore it to now.
+                 */
+                if (WalkState->Thread)
+                {
+                    WalkState->Thread->CurrentSyncLevel =
+                        MethodDesc->Method.Mutex->Mutex.OriginalSyncLevel;
+                }
 
                 AcpiOsReleaseMutex (
                     MethodDesc->Method.Mutex->Mutex.OsMutex);

base-commit: 98bbab7dbae0ff7941c4cf08d46f5d30978f809e
