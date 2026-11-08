Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177587;
	b=NKhpQfjY3r/V1wQs8Dag+N95zOMLjZ8u9nIkUYjnRj2zSSfqzr+WQjjiSMGDFCZajTWj
	 eM2q685HF8vfCzQhcVIO/7KDYbUaNEBPThkKRmKjE6x6NoQ6FOoY94/pMqz1/MUxmVSx8
	 5rFVhptykYcrn1cyxdsSMDWZrOhk9ZaiHg4P7ddx4skZ9zJddQiE9Tl7tCGD8yyVtrV85
	 DYdvpPJna0jKKcNGBQtn34MubZ22BfE1Zmg51AQpmE0ne3NqqZ0p5GPQbxFEnLLI7Ei24
	 HpiB94MH+btdFreLk5/I+HTEnCR8szA+ZjSadyEoYNhUMWuWnKjKoQAUgRhAkPkWVMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
	b=GrHl9QR8SeEim2O3RXLJ1MZGnUqn+yx+7L/bZfjb4NWdMDmFyds36NbR1h3Hffyj9vzq
	 1Ipu1OIAki+3HIJQcJrLM5UAcsoqRJgnY38LSHPfIdwnWN8uEoLEdrPycODk7LXSNB3tY
	 7geayAHFctNUsfwFx0SGshgV7RUQA65c+nxXtW7/Q1iScT2KWvrrNIVnsZ5q1E4nZIrVd
	 R6Hix+0ee8yF7ffGMSwLnWXqAhERKvice+4pfc+BHWg2Vxcw+XGpk6mlyG08mLQIC75KV
	 dxGMOKnvBhl5yPivzqFsKiAP3FruY+Z5BRABtwSSGzcpEuETivUrVI1FoJ5/wq2pZkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="WiS/rO83";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49F606EE83
	for <linux-acpi@vger.kernel.org>; Sun,  8 Nov 2026 22:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC49F606EE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WiS/rO83
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36cec75d8caso401600eec.0
        for <linux-acpi@vger.kernel.org>; Sun, 08 Nov 2026 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177586; x=1794782386; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=WiS/rO83jd9bI/DieSANeabjGnOf7ofkVqtVbL6lwR0Kl1aPmAlLVRbDPbhxCKXHqz
         CNS7naH1rBIwFk3gS0nzJsWAUVUev1LyzwShyBLnB5296dpufWK5/WU8Bse+xdMATfWB
         jaACnxNWH1yWm6H4lhdXSxvzyIU+QYSLfFSG4Qy0WpJ78qLBfr3TMXGLvWjWFAEki3UY
         WYcZF1lL4olsSD+VMeyHsPJH7imK+79Av1uXyTa2G7gIv0jiUzGFoMsFRMQC5MfUlflo
         2HlWIU669YLFvTS6JA3s2ktN5HpFaAE6ptToKgVz0mTlheIc/dgUGTGlGWkDe22ir7Be
         41fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177586; x=1794782386;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=e72M7yrrufqvWjlW2hGSu6Toiqy/fOmXcM6b0Y15s/i1kGEhEu2iiGQHOIJ/8u4+X3
         sMi6OEeYVU2Qo4SR+Zq6bNOgvbBGTzEf9ghGLFvN2x15YEusQgd2jC7BpZRTvmYJPzd8
         lV+5oH0/kSTvEwdGseJkUw6Ly1ByYAKsovNm2ut0yFRt7nc9vl5o8RWtIFMnKPUKmpuq
         WKKi2kO8AlRsPWfghYwOcCYp1Gc4wAse9mqGSQbHYsKS7XgbkIZHlah1oB3U7fvBzU1G
         7tOjLWy+5tBNADkSHvvmpp3xGknO1eqDQ/wNMsWyTzqRu6+MkU5nZMsCEy+iRlB+9EPZ
         toGA==
X-Forwarded-Encrypted: i=1; AL+hErFYbxyrqke8gG2KZhJMD5PcwGN5iC6EZM1mxs0L986FGIKbnswehu13HHNRutnIwwsrNCC6WIUTNIFC@vger.kernel.org
X-Gm-Message-State: APuU4Z9bNddslOvi6JaaZM73TfiWPxbJMgajWvFwLOLzNhhAJSZrVaKO
	XH0xIjehHLjjhqsaGFj+DRL52ONAyoZgt7ESXEKHXPFeIKPxvEqS8vEu/Za5lbz0cDNEYE4bJvC
	R5L5nlrS0XQ==
X-Received: from dyx10.prod.google.com ([2002:a05:693c:820a:b0:36a:eec:f68c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c00c:10b0:36d:dcdb:70c5
 with SMTP id 5a478bee46e88-370f7b8f918mr9710009eec.20.1794177585797; Sun, 08
 Nov 2026 14:39:45 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:07 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-4-irogers@google.com>
Subject: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
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
2.56.0.455.g6c5a503b38-goog

