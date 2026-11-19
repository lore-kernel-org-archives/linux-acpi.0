Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116360;
	b=Q26Oa+p+InuaN1cvXEpOfeQa8npilCfzpOhszZuGQRO4ja6cTebtGvfDZxbaI37Kj3VQ
	 FRCGrIJBhz+8sF8UhaYwW8x0u/4Tv7dYkiQE3tRP7uoEyAesSwQOd/sBZ/vJsIRg/RdIH
	 jmEQiwpdX12tysQU3540VwoSrgFgmEZuEQfWWFGTGaZZs5j9yWqALkKOQXmUQaHBke7Bf
	 8uCT7lJKYZ2lSv4EDbafgjbI+tdOYoHomI/iHe7dJjl3wbH715Jsq8hdQeK+wWck6DvpI
	 fN6GSVWnFKexA1V3g3v6CqYPE4Js7mz0qUMCilj+jvYNfit5a41O33Kh6NYmV/kM/RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
	b=nz/QNQvOmMIX/HcGju6EIIkx+gPibrmWGhuC6ktORLFYt9Ci1ny1rdy4ku0gkS/0+q5s
	 PBDTS04FevLrdDAAWpueiCbETYrC23vTWd7l/92aX7V/A1T7Cs+eibpbzLyfOq2TpJxlf
	 xLkR1vgKhKmwIPTUqSPIxTUYJHzNKQ7PKO9LusmnHFCeZSjTJWD1glwIaoDDPp0V1D3UW
	 ZtbHqLVHdvBBaW7YXpYroe39/UyzOu0U/oAwDe47A8e0VNJ8C0hyNF9d5dUAhK79jiIH1
	 aUA6vRiJj47XIgr0O046czYP238zhFgakpIFZAKGwHwsB6p/BUG8IBe4O0ZutONwABQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D+q8GpbI;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788BF60A2614
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 19:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 788BF60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D+q8GpbI
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so128906b3a.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116359; x=1795721159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=D+q8GpbI4NdO7QuDoNEZVES5pOHQO240I7HDWjn1f2rrdZCPcnuN3whOXGpx0a39oF
         vy29NgI8yDcoBcybaw2tN63zB7751vVbEVZZn/LzCMjY9HBRS20Keo1KE3hlO33zrKMY
         i9rsNYFToAMc7x/wdPBJ/4VyeJTA7enjCxjXgL3JsrE7hQmAx+Yowi3dVHZ+q9R9WTsa
         Q51KrqNHmyCaoJot9RTu5s/hbSfngwHvYv+jm5vhy3LwOlq0rIMZBhXUMFuk5WVGWCJ5
         g7VSQ0AS6OPJKeceOFnEmsage9ERncv5M09VAiTQMd1EpN6QJylgkCyMQrC/nJS7o9QN
         QLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116359; x=1795721159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=eQpwdrovv6EKdz3lkMZX+qv/ib2SFB9W0vUrEkAxVzSURTAVhDhzNDXGQsv4Ej+QQH
         ZhgLmonYYk7UE2nfDhUl7utDA2JLw9h0pYw+FMECLROW/dj6NIHqr60Vf+XqJd49mv/m
         sfakPy5WtzoxqCqKTVWzOLPxlaqXHKK/4VKZiC2DbZHVVaScRYHUe7eJzFwxNJ3qhqF+
         RoqCJpJ/jScP4j2vd6Wn8BWWeAMoU1S/U+Vq29JSrYNbUT/+BkoGb40lvSFWX+rltPVe
         qZZothTooaItViEBjzg/of4+7NzIdZt7hf4x1vbvAB5xBmgNjVU5D91LhwFqh3UzppKw
         +Rqg==
X-Forwarded-Encrypted: i=1; AL+hErHzW5As3M7fsF12dqrNErp8P4c4ayMrcGfhoHeTkem4aQBWTS6cV3C4CayAwwVHEF4ZbRUteZIiv2s2@vger.kernel.org
X-Gm-Message-State: APuU4Z/bT02l+zYffxNKQh7RU7bkPRVeKoX3ViAEZJqKpJTv80E5QQFm
	LHK/AFvYMh3kBOSrh7pdhlJSSWKBHamfRDP0XHnYUaGEV5lTktXK6B0O0kCeMnCh8X/GG8d16g6
	E4qffiAou4w==
X-Received: from pgjk11-n2.prod.google.com ([2002:a05:6a02:81cb:20b0:cd6:1fc4:6199])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9191:b0:3fb:1bfb:ff29
 with SMTP id adf61e73a8af0-4014e74d624mr589862637.69.1795116358583; Thu, 19
 Nov 2026 11:25:58 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:17 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-7-irogers@google.com>
Subject: [PATCH v4 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
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

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.1.708.g77570a6a1d-goog

