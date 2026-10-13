Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C7563FA2
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931224; cv=none; b=bKELS4uJ9nkVbGQNa+E5KOf3nOAVDruDFA/y11Y8y61jGN1wu6H9rlbIy02JVBnAcKFkYox58FSLI8uJRynAZIQMyHneBmHQPQulC2iLnOQv7fhrt4WHRAS3qkN7EROZruouMv7kIFr5cWKYKS9bG6Bzda1LvTRoHsIHkiBaoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931224; c=relaxed/simple;
	bh=1NEN+Scbgml9ozAbt8aLROD/kvCT+P1eXcLOXmgikX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kLIVe1/Ab2PMNrnUAtj0fNq8ORc2iynWOUyKSKdH2x+TRpCnCXFsPx1ucU5q+5cyM00CzFZssWgI3lWLkgZl2C5zb9d0ea/6uzFirBcxorXW8irXYKgYHHpRdimUESaamSOn+Dpjx42l4IKdsTcnkjKeBBQUnU+LIqx/5w5ReSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMRv0cn1; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMRv0cn1"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-351788121cfso4936544eec.0
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931217; x=1792536017; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
        b=rMRv0cn1iboal/NCyKFVfGQlY2CB4zpJkE3Q6GXERzasnVOhwYHZjocpCeAScK/ryM
         klYVx8RxBSej+z57Xb//+NHUehJzd0LLo/bkFNXg7NccbeHai6emABX2ZUQW7hnche+b
         II5GvikvluJOWgik87WY+Jdi3Zl2xxKVcu3IwuMQQT/bBL7iWUbY93uIrUBYtJZNFk57
         d0vHDgA5Geh56jCzHr5AWmI946Ofhgw8pb13KTPhdMTGqyBxKHzkDmXOmXF382v+p+U/
         VTJjrqrfkXn7ZFZu/x/3zVxxyjBgtupkSOOUf/3QhJoIyxwJh82zucJt8czuCBE0ONbY
         jQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931217; x=1792536017;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
        b=zRHZJglTwCibQLSi0A4O4GTkcDocr1906JzbQ8Vnmy4X68JTACghiwRvupKwaKmDc+
         sRv4kWU7kWNGyKxhsRMqXwQPwyUpoknl5XdctxsuAdDr3GfLT9V+e63iEdDGOhXqsOXI
         Xrl50CTFHKMm3sJisqymRAyUwv/1bpTr95qCUjH0F19iY6UAGDrzMuciDk7cH9A0Pp/v
         ZBwmuRiH6I00XKXDESfWF5Jk+rcmaDY/07sHiHyyxuugvt7re703hdF985f5guvcfb+T
         9K5XOr+k1AvntN104hXT5V/icAxTsorMXxVlYrk/m2zU20aMyITfVfATPlqEDo9ZaQa1
         9o1g==
X-Forwarded-Encrypted: i=1; AKwUvBzxJX0SJb++erasRhDOxpkyvCpSyJpTdn6ZZj3fe9yzcwdIPg971Zz4/2CJ2YK6M/mkgf4MdJo+Xj2l@vger.kernel.org
X-Gm-Message-State: AFq9FYKHb9a/3VI80Imz06yn09tyh4FZLg91sCcuHANuvXx9HxarXqxT
	qHUgAWfIYLxEAFIyjXt/rr4oQEKofqfkGOH2MAeMBM5otsdzhOyWQvi+20Kea7sHUq+IssoPWbZ
	ym4Wawly2Tg==
X-Received: from dycrm16.prod.google.com ([2002:a05:693c:2a10:b0:358:f250:485f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4141:20b0:35c:8d1f:5634
 with SMTP id 5a478bee46e88-35c8d1f58e8mr4713972eec.12.1791931216820; Tue, 13
 Oct 2026 15:40:16 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:37 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-3-irogers@google.com>
Subject: [PATCH 02/11] powerpc/secvar: Add missing kobject release callback to secvar_ktype
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.385.gd3acb90ef8-goog

