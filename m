Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177595;
	b=Hfef0WedL37i2vuC4Me5WdrsRhJLlaTMeMLl8vINEA5aSWCRxaNJH1SvOeTcrPyTqYRW
	 jJmd7SWOi2b73xdcZV864APLNJuftSy0hdFWULi6nl4gVDmdHo7Lc9wh3V9C55qGQwz7Q
	 QlBcwEHjj6H4yL+kTD9bz5GM67U+FG70wAMxQ5cb7U6x7pSXqY1jmEdZAll0BrUX8p0uL
	 w5dsavsvaWrg+M6gUz7JeBjr8D+Y8/SRsIV8NYo/py/Ov1cAlIM/1BBXpGOd5mqz/EpFe
	 Jsy67P/iDHlKnGw6hWU/awhyk4aAlTJ3vyPBXD4xEvgIkDc1uYewLw04DKWyecQssCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
	b=jDfJqPWvQJy1X4OcVMxIt7GYEPsJWoGN2HbS2lOMRQtL/dtw72GKvoTTbEhJJbznNzVF
	 4nYWk4OdHeBUuu5OyXdEELM9y8A0Ur+EMWRZ7e32gDznaCb5gIlvFbzyU2fE/xW14yMNZ
	 P4l/C23ExQKHHfOLd7omRH9DTwsvRsvxGCDDVSQJHVuhPd/29JjEf1bxMS5JzXMbwtXCv
	 xNJSbzymBKC7AP2pZRm1ZvmS/yKN70hRtVJwy+FWX0VHngFsAsfOOm0fp7HrxtSvGFNfe
	 RiKomo4H/59mL+H8lpLO5oI4u4HTH6g8ZzivkvfgAI3Jw14Nfdvf+mFqpls3rn83NWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kQO+69v9;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C46082BEB
	for <linux-acpi@vger.kernel.org>; Sun,  8 Nov 2026 22:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 973C46082BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kQO+69v9
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36ecd5db581so237305eec.0
        for <linux-acpi@vger.kernel.org>; Sun, 08 Nov 2026 14:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177595; x=1794782395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
        b=kQO+69v9cjNiQn3adE++1NC4MdSxNQ+mJce7mQncXEvEXvhY+MdKRMoZbdhq8FH/O0
         h3BbezYI6ZTaUJS6YImya3e9ccgWHDLHlLGV48d4aGvfsW4X/j149mh7/N61D6fvRPWO
         H5iapVpytk5MCfpkqd+ncnG7dF6vi0zUO+wtASuUIaEbyn6qWRXk+VviUF08JH3zQod8
         806GcKs4xZrtrJzYqMZZqknwjPDTtlGvMEHLf6Gn/0L1E5uk9VABOWZWTKj2BMLU0xHS
         zFGFVWHyIHHUR59ylVJu1HQY8xEsqH5fPJ2cfScDPlSejw3QtdYRKBrQa7vs0+eXJvZt
         3iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177595; x=1794782395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
        b=adaPza6/75klT9gcfxR8WPADTA/jM3albgEYGGIB/heT36XVL7St+pToIjVW3PEVMp
         eRAHC5KAVOx1fnwiumr2PJpSTXGhvgXa09L3PpA8uP3J1F1+gemc1boiq90/7yiN4nD+
         e+RXingDoVBqBrTV9Pg69w7avNisQORJxlq4KpQWtVB/S7oZS5uoPVfv4a9/A8XCHI5R
         R2xVJi+4z52wWl5mt2Jte51K1Lob7HYEpfyD1Qx7jCUXIKKLma0Ssy+0YHfVsI78SrBl
         7NdZ/hwVlpL39GAqJV2W3dJso4dSwURMdP7ryWY+PV7PYwqaIDImgVfJJR6/XZUGxzLZ
         g8hg==
X-Forwarded-Encrypted: i=1; AL+hErHrwQRJg8ot5Uczsmocf2yJf7eZ7lkL9fu2NCUejI2h89f/WiMEC+BTqV1yKNIK3vkp7E4Z4g5b0utl@vger.kernel.org
X-Gm-Message-State: APuU4Z/jE2VYSFYIUkBn0iQ7Wy544uglu2Pgp47ftp7xh5k3PVs57V4U
	Vgy8uARll/jP9PicMg11Tghyex/KZ9TdFto4KVTFD+lanc+ib9ZzVKAvrIbdgS35HK0hUg4a/Y/
	pHJk8U9AvYw==
X-Received: from dyblf39.prod.google.com ([2002:a05:7301:a27:b0:373:6c70:7c9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d584:b0:36c:9f1a:30b8
 with SMTP id 5a478bee46e88-3725661520amr5331882eec.31.1794177594363; Sun, 08
 Nov 2026 14:39:54 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:11 -0800
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
Message-ID: <20261108223913.3624571-8-irogers@google.com>
Subject: [PATCH v3 7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
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

ubifs_kset was a static struct kset using a custom ubifs_ktype that
had no default_groups and no .release callback. With
CONFIG_DEBUG_KOBJECT_RELEASE=y, unloading the ubifs module while delayed
kobject release is pending causes a use-after-free on the static kset.

Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
allocated kset via kset_create_and_add().

Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/ubifs/sysfs.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index dbf967dcf26e..e20931e3a62f 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -80,13 +80,7 @@ static const struct kobj_type ubifs_sb_ktype = {
 	.release	= ubifs_sb_release,
 };
 
-static const struct kobj_type ubifs_ktype = {
-	.sysfs_ops	= &ubifs_attr_ops,
-};
-
-static struct kset ubifs_kset = {
-	.kobj	= {.ktype = &ubifs_ktype},
-};
+static struct kset *ubifs_kset;
 
 int ubifs_sysfs_register(struct ubifs_info *c)
 {
@@ -107,7 +101,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 		goto out_free;
 	}
 
-	c->kobj.kset = &ubifs_kset;
+	c->kobj.kset = ubifs_kset;
 	init_completion(&c->kobj_unregister);
 
 	ret = kobject_init_and_add(&c->kobj, &ubifs_sb_ktype, NULL,
@@ -139,18 +133,14 @@ void ubifs_sysfs_unregister(struct ubifs_info *c)
 
 int __init ubifs_sysfs_init(void)
 {
-	int ret;
+	ubifs_kset = kset_create_and_add("ubifs", NULL, fs_kobj);
+	if (!ubifs_kset)
+		return -ENOMEM;
 
-	kobject_set_name(&ubifs_kset.kobj, "ubifs");
-	ubifs_kset.kobj.parent = fs_kobj;
-	ret = kset_register(&ubifs_kset);
-	if (ret)
-		kset_put(&ubifs_kset);
-
-	return ret;
+	return 0;
 }
 
 void ubifs_sysfs_exit(void)
 {
-	kset_unregister(&ubifs_kset);
+	kset_unregister(ubifs_kset);
 }
-- 
2.56.0.455.g6c5a503b38-goog

