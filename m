Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140760;
	b=TucEjcgOPUwowYdxDXnpXfqPlAtz+8a18FNSKE5DbeQGDnTOo8SiUi6RsEnsRNxd8Aqs
	 L+2KFUAhtkj7rnobtMpI8ViZqNu7ykLmLC1fca9RoV9csFpkjLjRz96swuFpCObGYPUd7
	 902iqliEFQnrsB3r5fh0Cr8O6kWMAAzdtTEYbWDwnPC+1axkacfjPbfCXsJu7OEoWEPTW
	 7cLDZXSBHDGq6v3nVy1jVH3B9TL/ZQt6gByiey49ubat1ReMi6r3gq7rTL41CnxRxI9Vm
	 XO+XymfduZyWRx0A9FXSCwCWBrMATAKd2wG/OGKcbSTfXNzBzs1vEwjiAc6LvK2Uq6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
	b=4La9HTlHK7nrEdiDJQx/mk6j6P8Mt4zdWJykQECX5YhNIMDyajhgwVafxgNevZvTyK5g
	 5osTXMU3O0vIsXFVXxY0YWKaha+5gzLWfCD9iIOL3p62o7KPGNQSToQiC/v2bYlC0gAJ2
	 YBQnKYIHWwZplOMMBpFoobUvDJqHN2Xf30ocImd0AO5D+VZ0WUO4OPCKnDYvYwBnVr1Kq
	 HJKrA3+IrULRCmGX8jM0uA31I+K0v2yX8lYjmJYZQ5bHxOmKzAxCrg5LqDRl1seRHmS/V
	 e/n9OLwGvmgE652jYidTRE1xMFcZx/wJ+UKKM7/beurIICduSF4WaLbi2QMfWhTQxug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kIMyUKFu;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39E606A339
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 22:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E39E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kIMyUKFu
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a030e0f9c1so413665b3a.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140759; x=1793745559; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=kIMyUKFukUJtjlCB+ZE2zh2lwo3GQV3z3dUYxV09PKjXw0ZjE2jeWA5BuL5r+QkTsS
         5ZzU/9piUKJLhgATzOW69XBDirJSfUNdjU8bimvi6t/U9+77eeZV3sUpzjATUlpkTsmz
         gq3vyWIGNK0zFjlANK5GQZMvv0vsQLSwO9CijSJxrX9Vh1ynVxUpyQR+qXuUOzTQNEd2
         vqFNVi+/m+qyeN1OsBM/7m5G51CLC9ESLC5hoKgrvebdkKnbj7QYKY4thO4WPGJ0SxlV
         i2/3GcwAryD5MX3hH5HdRpHDIt1i8yx0VLeoNGibsE95Q6GYl69dtaAIBjedJgq+ugfg
         pXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140759; x=1793745559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=LMPfrB38JtOPTWNeAWacROO6A/+CAl2910S787l7NH4RxxX5Ok4panwqDzNEXxbB9O
         kukdQHqta/kkfQkgedZKeVgU5j73r1aNaNwFAI1VVbxQX3Aj5Kw3O8zApXUn7+7Wxi0b
         3j5SjYYWjK0ZU72kL3vXi8DyC0beeVqEtfXJgrLK6u6QwQibP6Bg7U3BE5XE4XBkMUHT
         QCrpUchgIj2JUKyTR7NesECXVj8wJGPhtLqOVhSXxQG7sAVpiOxj5mjxZgirJks9UC1c
         joLjz7UtToxGRAani6EKlCePPL7wVDsaZYSljb5WNFdrYzhLyZlwJY+PndCVSks5fma8
         upJA==
X-Forwarded-Encrypted: i=1; AKwUvBx/ElwkfCjmZMbtQARhREgM1YI0hs8XtaNSFqmeSVRBrv8toZuKj+a3+4Utmmz2lMGdpzJRShVeZvfa@vger.kernel.org
X-Gm-Message-State: AFq9FYKruRIOhxTL2PEaSIQt8BhUsJy6kDQ7HJP6Ryj0U65NT6yu6wIG
	zWTnQu0Ee6lwm1G/eXZ6nkbfKFRaq0766Z4tp67I2aEwjGI50ePYnh3EsM48hCEpZcd9jrj45QB
	ZuAdg63AgNw==
X-Received: from pfbdw21.prod.google.com ([2002:a05:6a00:3695:b0:89f:827e:eb47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:876:194e:b8fe
 with SMTP id d2e1a72fcca58-8a6e70e832amr492696b3a.26.1793140758450; Tue, 27
 Oct 2026 15:39:18 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:38 -0700
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
Message-ID: <20261027223847.652884-4-irogers@google.com>
Subject: [PATCH v2 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset="UTF-8"

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.313.g2479322e68-goog

