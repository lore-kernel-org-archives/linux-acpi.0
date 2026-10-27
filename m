Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140768;
	b=jml345S7FW9I96+x0iTV9ZFm2wvvq4uO7iGUhToo+xQ63/bDKN6DiW1M1Nvx/jbNa6Yw
	 u5C3q3/7mG+Ps5UxIy4aUaKqBZrWqayNlj0l7cgIeZsvcb74WsFHBNpVG76LQFNHBAy0S
	 vp+eWTRx71g3w4fbH5fxWITQCK9zQOv573fn/EMGdNUeN4bZdF9GWvXdbojtOGHx/Wnv4
	 WC0jbe8Cc0VV+Ao10Ol3lSWqe5qMnIwo25acMXGNzUpccKvyEjTkQMnkpF5MZKmV8AO1J
	 DN4hLjM5JeMJavqzf38Rf/92rHjFlx7W/rQ507/ZtQiuQpdevl/6S1rnWcfJqJV7Ufg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
	b=qJXTKSKaXJCq8J192TATEkdZBmiG/C9/Q9e+QD4qCYsufqvnQAlD2J1Mo7P5wNzc2POp
	 RCVK3VHCLmyKGgIEJXmrqwrsxSanLYK9GU9lqh1UmZ2tZ6tlSsRequ54vnbeYpj7Pvxo0
	 1IB1YLPj5ApbqXYclnLOSXbfupz6UfbO2icK7vevnO1Y3CvqUuTqJdc50Y/Yk0XFSbK8j
	 fnTJOG9HnWdzWuMOULTt/2b1/bQxjpsngeN7PISzlrYwFPUTwx7UsG96us9227c6ccnLq
	 UuwOfVDnmDJecHDSOhXdg+f/d0yCGy8IgFAfGEVgSw9n+6aMBJuJFL15cxSXXUVX4wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=liNe3HMy;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09460A382F
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 22:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F09460A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=liNe3HMy
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so1025594c88.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140767; x=1793745567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=liNe3HMy55X9pJAx3yYfGsMeNT+e1JnZxB+AQx3A5J9VPGgN92YzVbYvd/za/Drr5k
         lst0PfcfRGocLlrgPC5UssnxEJctFzU+pQm+95FdUho7XQl8tD1ulM7rKwt/jNE+21Vf
         Z9LeRG62rYmnsPQmmg4JlXmw8+AffIjWCQze/e0A/NrbyHM8TP8o1608vrQLYJKc1eVF
         dF+siAZRQfjXJUi0LYKhvOuPmzmxcjf9I8fjPgny0U321qhAu1Pmw+Bv//U3MdnFtahJ
         7n34bb7IiC2Le1ntE29Feez7T+/eMXs0L62grlkW9U2pgTYjfEQQlg6qoj1bz6MQC6fW
         lCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140767; x=1793745567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=AjhmN8h56wRgTSN3UcXE++tJZOy3DwjkOE4WaQiQlXy2alzAU9gIfSHlQRa9ecKxfE
         NeJeKceQQ8yH9eArWhTzyzLcVS9yV+k87FIZr4Z4gWuwkGPptQ9+FPkXKGxkRCxsLcax
         /lipPhzEMMthDtfT3uKbiObWge49tpnLcqWSo1d2N5rg2UWFxp4vZk4AtG9wv+nXSW80
         nQU0F6Q6B05RabCs/+gwN1qeI30mjOWCK3ZeKXlJLHgO9aRhWPG95KGoYrVMQVj1zwQg
         HSXHPPgzbH20nsIzEzc8sR1ls4lLZioJu2OGyBgcfnLSk/IYsMGJU3JdrYGTE2G27Uat
         xk8A==
X-Forwarded-Encrypted: i=1; AKwUvByjaCahBb5xVZWwuAsJO6EHWyomeOF5ybguXaB9vbzXGaa3xxvwdFhqOLQVp3eQf5zRyJgjxueYKtuu@vger.kernel.org
X-Gm-Message-State: AFq9FYJegeoRE/GpI69WMXudVF812Vpmvcfy9RTZ423A8/8oGingnvay
	zyNUJg7XoSNON8u4xIp77I58RRJA1jmVHU7UwOZrh9F5Eytj8QjDuVynEOZ1+q7Z1QB3De49xJF
	l586uj36rTQ==
X-Received: from dlbqq10.prod.google.com ([2002:a05:7022:ed0a:b0:1a0:a0b4:204c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f115:b0:1a3:6040:bf78
 with SMTP id a92af1059eb24-1a6cc34d07bmr917417c88.11.1793140766453; Tue, 27
 Oct 2026 15:39:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:41 -0700
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
Message-ID: <20261027223847.652884-7-irogers@google.com>
Subject: [PATCH v2 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Content-Type: text/plain; charset="UTF-8"

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
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
2.56.0.313.g2479322e68-goog

