Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8BE55C33F
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085461; cv=none; b=HWCb6H2uZy+AZEAVi/DaX0VjL131Fr1PLPVzaR8Opu0rblMYGvKsFGG0ir0XoMlZi4+O55cNhC7GTu5PMq0Ecg+JJDuKvITWUZkBbYZGXKRMqEkf8ZSFU1+rY0K0myHzbXX65nkQDTQjYOGXxhxv8RK1LsdVczenmpWDhLUFofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085461; c=relaxed/simple;
	bh=4LJFjA1BbnAQrC34EURZJd+Rh0nemOno61F9nSicagM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSzqbe8uEzW1en2zkzGe3vbTDtpI0VLvh3RHLBZX6JjRcXAIuqAU/CzVPOO8ZvFXJ6qqq3bYpWLEh7c1fLwJcO1OGTDFAsQBWDAXCcVJyTCj/q7dGrZyBPdo4PUb7OfTqTU67NbNkpkVhHVL3T8lmibMBqRz3ICZp+tJR0s+pOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NUCPs2sn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NUCPs2sn"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e635220b9so388708985a.2
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792085443; x=1792690243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQWRSNzl3c6XGCf8hZ27RUtWfEekL1YzIzLAzfAd3e8=;
        b=NUCPs2snvKteaZAj27rFAKlyAadeuledINkybujf4GJlyTieQjg1sGDD55oO1ELTF/
         vSat0jbjmv+OOBxTJOJ5N4SW9DbNdAAiJZY9uNmgt8fzIdlHTeoju+w9lR63fcVy+z6B
         i57dUe1NBeTXVVONR1h9jSTQX9l+np27JD+4qf/8Ut81ueYsx94NqzpK/rusyfYDnUhu
         SMzfZ+aAhRMfpgSGjUTW7OthbxY5Z1jpTLe47WCx3nklmb9Lz5vsa6fgCUhFxDD1HudA
         rWg24Eq+DGzRCFGtAZYRZKl64iOqx2p2YN4yyij3/E0Djwg/YDIYDva0Z7X+1N0v3zIT
         uf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085443; x=1792690243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQWRSNzl3c6XGCf8hZ27RUtWfEekL1YzIzLAzfAd3e8=;
        b=cYopfJT55I/jagFFk6zqbaiE5rhOLE8zJunOSUWgdEEeeMm3Z4GdHiDlDwW/2I66V2
         3R95rL8dZdprcXSB6jFgD228SykO0uelwgE6D4dMTTQJ56aAUhXX7mRYUFSnolTTohI6
         qWuFKSuTAxN21e+yWSZuQb877giOJ0TpmVApLi5Bayay0bsm5+4jmmYD9uvJkcl9tHiJ
         nk3VtagxknEVu/zHFsnDZqGN+DhHx9lzr4Q7LGIIl9SpO5HiBs2vCdrHhpejFoHiPkve
         wMaqlHQQJEHv+Bk3ffGxaLRn+rIn3vZfm1Y7bmR9USy5BOwkSHIEkkSZMxy+SB1DehYl
         m/Ew==
X-Gm-Message-State: AFq9FYLQEdv7XVjD/pnixJs6/KBL3pWe7iw/t4/AG0C+OS4n8k+OJF6m
	bLKH6WecYpCwRYzQ6OJr7cWYH+lTktbiR7hK35QZxI/76Sp87GAwhWxFx8kYmvOH3QE=
X-Gm-Gg: AYBFou0/jbtlXJq4sk53MQNE8hNYywIwH3BZ2XniCObi03yF/Tz4ozoQYidlG44CY9V
	+KGNDMYQ+OMOBrhFps2Q2+1sZRj0jBUxpueoXf6esqXrTKMhiCW5dVxK61Gxt1H4ytduip42IrP
	fcD125D4NadlH3rzknfk0kwfXmGLxFPr9dyKcK2ozwpHtyFBK4Zz2VTO93grTwU4IVvrCj0bYeS
	gJZrxJRphOZWiC/K+dMuZi2A/7VMjtD0/9k2idMGqg/T8VWChJTB4h8ILEljxh7Q+SvmmjvlfKQ
	FwgQxRNP28zNOSA1aRYrg8E8YDEE5qLYrpYynpYB6gQQSdtPmh38iD4f9gmtgLAsmQaQUAbYY1E
	I02Ha2U5Mo3Mai1FfRR6EonBOoL1Rlvj3gI6SGeNg0Xlv3d6k/9o7rtB1VwUUb9yUPjJzC2GN2G
	NgSGsUkB4Ti/OPdnCKE3pYCibmUlf+K1RTZyvHIIZWGLsPDQxHnpuptodQQn7zfMAQYIw1/qYl8
	eDYyTOg9sA7yh2JqtqI/mIrYjq7auFzf6b+vt59RSeCf+Xn01poiJT3kq42
X-Received: by 2002:a05:620a:a410:10b0:93e:c35b:2332 with SMTP id af79cd13be357-93ec35b26f9mr2150400585a.73.1792085443397;
        Thu, 15 Oct 2026 10:30:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50095bbsm825062485a.9.2026.10.15.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:30:43 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [RESEND PATCH 2/2] rtc: cmos: Honor explicit use_acpi_alarm parameter value
Date: Thu, 15 Oct 2026 13:30:29 -0400
Message-ID: <20261015173029.3091872-3-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015173029.3091872-1-gourry@gourry.net>
References: <20261015173029.3091872-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An explicit rtc_cmos.use_acpi_alarm=0 command-line argument is ignored
on systems where use_acpi_alarm_quirks() enables ACPI RTC alarms. The
argument appears in /proc/cmdline, but the read-only parameter reports Y.

The boolean parameter defaults to false, so the driver cannot distinguish
an omitted argument from an explicit false value. Use a custom setter to
record whether parsing occurred and skip automatic selection when it did.
Preserve the bool parameter type metadata. Automatic selection remains
unchanged when the parameter is omitted.

On the affected system, the explicit false value reports N after this
change. The HPET-emulated path completed 100 test runs without a failure
while the ACPI RTC event counter remained at zero.

Fixes: 36d91a4d401c ("rtc: cmos: introduce quirks to enable use_acpi_alarm mode")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/rtc/rtc-cmos.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fe514b1aa343..209aa4ec732c 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -57,7 +57,28 @@
  */
 
 static bool use_acpi_alarm;
-module_param(use_acpi_alarm, bool, 0444);
+static bool use_acpi_alarm_explicit;
+
+static int set_use_acpi_alarm(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_bool(val, kp);
+	if (!ret)
+		use_acpi_alarm_explicit = true;
+
+	return ret;
+}
+
+static const struct kernel_param_ops use_acpi_alarm_ops = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = set_use_acpi_alarm,
+	.get = param_get_bool,
+};
+
+param_check_bool(use_acpi_alarm, &use_acpi_alarm);
+module_param_cb(use_acpi_alarm, &use_acpi_alarm_ops, &use_acpi_alarm, 0444);
+__MODULE_PARM_TYPE(use_acpi_alarm, "bool");
 
 static inline int cmos_use_acpi_alarm(void)
 {
@@ -822,6 +843,9 @@ static void rtc_wake_off(struct device *dev)
 #ifdef CONFIG_X86
 static void use_acpi_alarm_quirks(void)
 {
+	if (use_acpi_alarm_explicit)
+		return;
+
 	if (acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)
 		return;
 
-- 
2.56.0

