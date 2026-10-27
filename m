Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140762;
	b=a39dX1mOPdBMATX6Mr2qnzR9l1a6R/lwdRNv7yOJraNuSZUt0v+EFMlUD3zhW51PyspJ
	 7Hq0ztSSw7wahMuywrKIcp4BxXKXZvwa/exCPbGS3uJDtkipl5fG6e0QsG93Pbp5rjZUY
	 xaWgjeufyHyCqtAjO9S91oO9ypaZv4odEapbaEXYtxhVqafSVSxWzhUFvykLALYFplTvq
	 4KKnEcB4JFE4eLpiziHY8tT9uhGbL6WEPwrIGPrD4E6wrut/wRmoDMHprN0hLR2xGcyD5
	 3CyM1KcE6MkDlZx7nBPMJkxvvjrIWWlSI+CufjEAod798bQNaU7qdcYmCz/Vp/NsOXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JWqYb4bGeUKpshpA/YjhKSWXxaEK2QVlfhqplD6YlhY=;
	b=jNgTAn4EAHxWHOb7SG1v8ahp8xeGgfToW1VBmYmafAioV8ToA4+jjpUlXylCpAzWOkAD
	 0SBFD7GdX7PQWPsVI40SOYARiazSKinlKFj4gs1+Mxs0sPVwxlIQS/6Ul7I6YdqH64l1O
	 kb1DmIa8ZhmkqPqXiLw5iksYaOUrEegvB5cdg0nNxfOKDez7xGjBxedW44pKrYJic2EBX
	 NDzwY47kEZuc2u8LdYvVCX+x87qsNe4GazDpDSVfgRLXwh3+TjgRY010k0I3sBbKfq6fn
	 KGTR7qDmLp5N2RYy/7Q6jm2a2eRzongR/vn0hGcUagPpHrkR6rSWkObB+goT6F3g9ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HDVoLyM4;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737CD60A2624
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 22:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 737CD60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HDVoLyM4
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so607972eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140762; x=1793745562; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWqYb4bGeUKpshpA/YjhKSWXxaEK2QVlfhqplD6YlhY=;
        b=HDVoLyM4HimbZ0NdCBkHJJXtaKUB7UEI0z0VvuCzMQ3NnSLJtY6ohWi6eX9TEVvq+V
         0WnWvb38jxn4r4iiiTu9AMhHHNwLka6QKe2I25qkvI3u+Y9134gbpX44tTkZ7WEtcvqu
         nfY2VhCfjAdduBcYl0Alvanw0WgzZNEGQ4PbRaTwb9WCOA2A+43oNfY6V+UVo3mRKjBe
         lxJHTMLuSQsd6Rf0LicX0MKvBl8y51Zpx5ZugK4d0qBVb4IZCoYHONcH4qObItsE7IaH
         wLagXH+JKoAaGHErzx7oFR05NdAvWb5FRfcHffluzvXSnDrN5xUogHyFHCEho+YEIbCr
         gxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140762; x=1793745562;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWqYb4bGeUKpshpA/YjhKSWXxaEK2QVlfhqplD6YlhY=;
        b=UQCrKPXzwcDUAj0TtVEpT1j7fSPMgv2L+fITzjyOE2Y4eA4lO+jBRqhGESX0DJIjH9
         FHFlosibxcOg46mYVRXuJxERlAw7Kd396YbLt+LssmOToAE0qaU3uVFDi9huSKKcI1+q
         ihhphgbrAgLqwJFINOqxbAq+jwRNs1hJuHnZSedaLmVBMdBfDXOEQ/VexTdRdHjUmuNb
         W8GxgkHuEK0parm4iuT1vTHdK2wIR0tnsqUNaKcB3MSFiBCZmekvABp5ksuws0zp3wM9
         olo9synUtu1RLKuu00eFFV8chF71HqgeATxpiJtguVt6IgbenaLqRBieaBSRfKH6UDFT
         qLOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeA1jxt9ONA6CDbq4bAk9lfzBCzj/1nx0LelxqZjquZaQOloLQ/j7uRrVcpTgeDwRcBWwFe3krGod/@vger.kernel.org
X-Gm-Message-State: AFq9FYJmqh+zsCFUwm9CZTm1ppM7pEV2TpxSKYhMqB2syiK+wi6qfnIo
	csnNMaQ0v6bVJMl90AbVYDiqsgKn5hJRM8CoUUJaf8Mkngy23IEelhsRI8azvhkMrQeUhpPs/Io
	duDoJ+GnNZw==
X-Received: from dycna3.prod.google.com ([2002:a05:7300:ea83:b0:36a:1b4f:e8f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e9c8:10b0:365:d42a:f415
 with SMTP id 5a478bee46e88-36a2036d4d1mr1220304eec.12.1793140761297; Tue, 27
 Oct 2026 15:39:21 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:39 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-5-irogers@google.com>
Subject: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Export cpufreq_dbs_data_release() and set .kobj_type.release statically
in the ondemand and conservative governors so their gov_attr_set
kobjects have a valid release callback statically initialized, matching
cpufreq_governor_dbs. Remove the redundant runtime assignment in
cpufreq_dbs_governor_init().

This prepares for annotating struct kobj_type::release with
__must_init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
 drivers/cpufreq/cpufreq_governor.c     | 4 ++--
 drivers/cpufreq/cpufreq_governor.h     | 1 +
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 02bfd46543e9..146a2353b1a2 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
 
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-	.kobj_type = { .default_groups = cs_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = cs_groups,
+	},
 	.gov_dbs_update = cs_dbs_update,
 	.alloc = cs_alloc,
 	.free = cs_free,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f3bd3dbe7c41..f8b5aca09b6b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
-static void cpufreq_dbs_data_release(struct kobject *kobj)
+void cpufreq_dbs_data_release(struct kobject *kobj)
 {
 	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
 	struct dbs_governor *gov = dbs_data->gov;
@@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
 	gov->exit(dbs_data);
 	kfree(dbs_data);
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
 
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
@@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	policy->governor_data = policy_dbs;
 
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
-	gov->kobj_type.release = cpufreq_dbs_data_release;
 	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 806d8fb4dff1..1026712bb79b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
 }
 
 /* Governor callback routines */
+void cpufreq_dbs_data_release(struct kobject *kobj);
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
 void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
 int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 9942dbb38dae..7386d043c665 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -374,7 +374,10 @@ static struct od_ops od_ops = {
 
 static struct dbs_governor od_dbs_gov = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
-	.kobj_type = { .default_groups = od_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = od_groups,
+	},
 	.gov_dbs_update = od_dbs_update,
 	.alloc = od_alloc,
 	.free = od_free,
-- 
2.56.0.313.g2479322e68-goog

