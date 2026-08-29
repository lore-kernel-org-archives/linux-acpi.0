Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131EE3905F0
	for <linux-acpi@vger.kernel.org>; Sat, 29 Aug 2026 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788021803; cv=none; b=HiQkodL3yik5WdcZEB3x0IrOKI/Q+WSQfCLdE1Zr8BnrazPw4AOjluCx1t9NP0CGR5sTEy9f12VDDwE2rkbYykYax77Bhw/NM0R8iTp49TVy5nflKzHd8BGCTKpegHehaBopF4ziq5JOxxMl1zOaueOJ37sWdFdP3gLIH7dPadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788021803; c=relaxed/simple;
	bh=9ejqKHPp/EFFMNOoo1mOA957flj8r9fwMT4Soouzxhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ub1zdeYhcemy+XrX6HO8yezDgxt7+AkxbxjBhVBQUqlPfBXQ19jhJjLxn8lhBTmGppB7vkeMOFiDB/fSqqE3x+ZgtW50MlsSLAPae2bnpJ/AHIjOeaGX9vGMDVH+us4iDLWtTL6QgjhIkVRAA3q1DMTWWrDKAzAo5Jm6RGAmOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAYUZc4c; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAYUZc4c"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so17632445ad.1
        for <linux-acpi@vger.kernel.org>; Sat, 29 Aug 2026 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788021801; x=1788626601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Te2Des4zxUf4rBOYMoMt0p5D5w7QmxQ4kAUkE9eZmJA=;
        b=hAYUZc4cqg1Q5ileYK8jaBdqOXZj8+W0QT6EFt3hRcKq3ejkUyMs2w7N2It/c2Gq2z
         TUZ19w5SntSIoyfnePtErOfVtNR5nD4PLkt91+MK2TXkC8aVvXzJSkHWz+/8rbsbk/qh
         CxN4m+vi3rPPlCWaycMuyfaooJMbDJkOOLstbGrfcELaHK6GOd5TOjdGhuvdDymQb1Yo
         Zf9KFMGsu0DV8Zx8FcT2eC0vLtqGCfxaBv9lavF0NorOTG2Jet6QXyhCqEz2xDU1ip9N
         Li2t6UrXbRdGRz+JwHbfznbUK2WC4QvOMupi7PWZVC7y9SG/ny4FQJtOjRpgMatNcZ4A
         INWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788021801; x=1788626601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Te2Des4zxUf4rBOYMoMt0p5D5w7QmxQ4kAUkE9eZmJA=;
        b=SDmxkODSaf4kJKIfjqvsNzU+aCpmk+Ge/8vHl8xRenHyJRoSaBPW64xarbAuJrvGi1
         ysA9c5M54ylVjL04s0C8mptAA+b396HVfaM+cS5XHEXmN+ROhsfvovWXey5rmAq7Uj9p
         HGR+uJVWWzYsvNptfZtypKM4J9ctbaf7gd9YGxdFKCdl217RZnGInUq7tl+0oUHhYyNl
         bhNwN2CFi/oN59Zn9MkCVP5UvxDflajhI03L1xmW0WXfHteN1zzt/JbRIRorxaCRDp7b
         H56z1qGfGddtQjNG7F+yK1z8ONALP0ISGJCXx6KMeR22oLzN+D5O/x6DC9kLS5CG1Mcj
         tcug==
X-Forwarded-Encrypted: i=1; AKwUvBwzrPovQ3UkY9WxqfT4AKPC44zKpGARYJsLVo9K0BIXNPfqQHIRHv62HuyYVKwrhwPU4U3xi09fYmI7@vger.kernel.org
X-Gm-Message-State: AFuF++kGGoxrgwHeCyoHe3BRSHY1P7YGZWmn8c12JIJfLV/ojm74WSwv
	esSBZndjj0OESby3MGJJLj6YXIu2HAzfiqor1AuYaUXmba41BWk25gPa5Qvsj8Vh
X-Gm-Gg: AYBFou3jPM55PP272K+rnZb0TVoN/sWA4bsYcd5LQwptbsZXK4yPNGCBy9lJqMd88Np
	QnhFr4Wj90TWCGrgQqycmaj/G6gmn5OSYgRebm59c63/xMagatfdQeSWgb3jat6rYjZXzuUkS+J
	7q/s2FqOueQOHmhPJhybWQ2iK3a7OpoMmnpreEqEJ59zSJvYwnZO0cFbVStzXRvlFO8W9gv6RMM
	PgYMciNLw3Pj1TXCXLHfG64LaIZYTp9ofz7jkF/BN15Sos5vf+CXDQ2euSREipyU0LxeimRk0Ya
	YVTi8Bh0MywVvU+7lAac49ozatrJmRBQJ1H1Nxset2wu4vmc2lW94hi9PGMkWitOyikv3kEYS7v
	ulvaI4hlK3hUnZqtpmAZQvtZ3xX0f6RnX5mOx/8KWYAsK7pcBWGiQDqYsHWEqw2Hh3AxPoN8r+q
	awzUH7TFCQo4zpc29B7GWHWqLAyqw9QVGoCwrGocxyBpxle8t2QOMFhlphHuw=
X-Received: by 2002:a17:903:228e:b0:2d6:fed1:7127 with SMTP id d9443c01a7336-2d74ce1ba62mr240847175ad.0.1788021801304;
        Sat, 29 Aug 2026 09:43:21 -0700 (PDT)
Received: from gmail.com ([58.84.62.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bc825sm19861772eec.9.2026.08.29.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:43:20 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: intel_rapl: Fix rapl_packages list corruption
Date: Sat, 29 Aug 2026 22:13:12 +0530
Message-ID: <20260829164313.20905-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rapl_packages list was previously documented as being guarded by the
CPU hotplug lock (cpus_read_lock()). However, cpus_read_lock() is a
reader-writer semaphore taken for shared read access. This provides zero
mutual exclusion between multiple concurrent callers.

Because auxiliary device probes (such as intel_rapl_tpmi_probe) can
execute concurrently on different CPUs, multiple packages can race on
list operations (list_add and list_del) inside
rapl_add_package_cpuslocked() and rapl_remove_package_cpuslocked(),
leading to list corruption.

Introduce a dedicated rapl_packages_lock mutex to protect all additions,
removals and iterations of the rapl_packages list.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/intel_rapl_common.c | 29 ++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 70cab5f08bc6..e544629dbe30 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -175,7 +175,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd,
 			   enum unit_type type, u64 value, int to_raw);
 static void package_power_limit_irq_save(struct rapl_package *rp);
 
-static LIST_HEAD(rapl_packages);	/* guarded by CPU hotplug lock */
+static DEFINE_MUTEX(rapl_packages_lock);
+static LIST_HEAD(rapl_packages);	/* guarded by rapl_packages_lock */
 
 static const char *const rapl_domain_names[] = {
 	"package",
@@ -1360,12 +1361,14 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* Find out which Package the event belongs to */
+	mutex_lock(&rapl_packages_lock);
 	list_for_each_entry(pos, &rapl_packages, plist) {
 		if (is_rp_pmu_cpu(pos, event->cpu)) {
 			rp = pos;
 			break;
 		}
 	}
+	mutex_unlock(&rapl_packages_lock);
 	if (!rp)
 		return -ENODEV;
 
@@ -1445,9 +1448,11 @@ static ssize_t cpumask_show(struct device *dev,
 	cpumask_clear(cpu_mask);
 
 	/* Choose a cpu for each RAPL Package */
+	mutex_lock(&rapl_packages_lock);
 	list_for_each_entry(rp, &rapl_packages, plist) {
 		set_pmu_cpumask(rp, cpu_mask);
 	}
+	mutex_unlock(&rapl_packages_lock);
 	cpus_read_unlock();
 
 	ret = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_mask));
@@ -1655,11 +1660,15 @@ void rapl_package_remove_pmu_locked(struct rapl_package *rp)
 	if (!rp->has_pmu)
 		return;
 
+	mutex_lock(&rapl_packages_lock);
 	list_for_each_entry(pos, &rapl_packages, plist) {
 		/* PMU is still needed */
-		if (pos->has_pmu && pos != rp)
+		if (pos->has_pmu && pos != rp) {
+			mutex_unlock(&rapl_packages_lock);
 			return;
+		}
 	}
+	mutex_unlock(&rapl_packages_lock);
 
 	if (rapl_pmu.registered)
 		perf_pmu_unregister(&rapl_pmu.pmu);
@@ -1704,7 +1713,9 @@ void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 	/* do parent zone last */
 	powercap_unregister_zone(rp->priv->control_type,
 				 &rd_package->power_zone);
+	mutex_lock(&rapl_packages_lock);
 	list_del(&rp->plist);
+	mutex_unlock(&rapl_packages_lock);
 	kfree(rp);
 }
 EXPORT_SYMBOL_NS_GPL(rapl_remove_package_cpuslocked, "INTEL_RAPL");
@@ -1749,11 +1760,15 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
 	else
 		uid = id;
 
+	mutex_lock(&rapl_packages_lock);
 	list_for_each_entry(rp, &rapl_packages, plist) {
-		if (rp->id == uid
-		    && rp->priv->control_type == priv->control_type)
+		if (rp->id == uid &&
+		    rp->priv->control_type == priv->control_type) {
+			mutex_unlock(&rapl_packages_lock);
 			return rp;
+		}
 	}
+	mutex_unlock(&rapl_packages_lock);
 
 	return NULL;
 }
@@ -1810,7 +1825,9 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 	ret = rapl_package_register_powercap(rp);
 	if (!ret) {
 		INIT_LIST_HEAD(&rp->plist);
+		mutex_lock(&rapl_packages_lock);
 		list_add(&rp->plist, &rapl_packages);
+		mutex_unlock(&rapl_packages_lock);
 		return rp;
 	}
 
@@ -1835,6 +1852,7 @@ static void power_limit_state_save(void)
 	int ret, i;
 
 	cpus_read_lock();
+	mutex_lock(&rapl_packages_lock);
 	list_for_each_entry(rp, &rapl_packages, plist) {
 		if (!rp->power_zone)
 			continue;
@@ -1846,6 +1864,7 @@ static void power_limit_state_save(void)
 				rd->rpl[i].last_power_limit = 0;
 		}
 	}
+	mutex_unlock(&rapl_packages_lock);
 	cpus_read_unlock();
 }
 
@@ -1856,6 +1875,7 @@ static void power_limit_state_restore(void)
 	int i;
 
 	cpus_read_lock();
+	mutex_lock(&rapl_packages_lock);
 	list_for_each_entry(rp, &rapl_packages, plist) {
 		if (!rp->power_zone)
 			continue;
@@ -1865,6 +1885,7 @@ static void power_limit_state_restore(void)
 				rapl_write_pl_data(rd, i, PL_LIMIT,
 					       rd->rpl[i].last_power_limit);
 	}
+	mutex_unlock(&rapl_packages_lock);
 	cpus_read_unlock();
 }
 
-- 
2.43.0

