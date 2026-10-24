Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839452;
	b=phcIg8hUi7vlDhCnQdUUOvIpPVZ69/98/O5GrJ7SmCo8FkPOH5KpMEKEwb/l1Us/WV4w
	 dYKE+EPU1/ZGRTry+rMLbb2mwLa9BflGzJ2JAm38sl281gsxsZ1cLykbRGQfAgojXmNrn
	 LgnC0kjTijeVgMe7xOugq3c6S83fJomtEmtCiCKTafcGkciQ4scxFNuYmZ9spcjHJsabQ
	 CknQKt3el7eDGXerTNE4C4BkrFo5tXoVuyx9DSgZ1JJ8Y9xXWYsQ5afxyeEf2tIxqvwBV
	 eylpIzXKyBZyqp/M3Xutf8gftEKvj+q8sZqTGxj7DN6XfQt4YBaJetHPopqez8DgMiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HNICyH1Z4rTOKjpfX5U5n8hb8jDB9RXey0UpM4q24ek=;
	b=aUJRK0fD33Sysl8pYTpkbw5zidXzOUEjgsFPWcsB7alMMg3FyDdeFKV4JNzelzHp/IR7
	 Ce7evz3fYOzHWEi0HjLNjP0124Ri4zxlyuCZJ3g2Ux5d4wwtSbuuQbkR32/xXcjVmKrlp
	 nTAqxJIuvUUvlGr84kryCRx2aGd1Yd/CgCi+ll7YL3j2ieqJvKKZDko/E2EsSW9QdBrnz
	 nUgA87zeHurH4H3pxd2Mipxfo5F/hFjYgESCHvKgu6utcgFYD2Irfo2EWw5SZ59G9hqrZ
	 +pAFVHUaEqxCAXxNKK02HnZG0Tk1qS72s7dJO+tiMv33pMVkANcOujWu8ytiFnO2I+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PtsSnhaK;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FA606A31B
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 10:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C3FA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PtsSnhaK
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so949529a91.0
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792839451; x=1793444251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNICyH1Z4rTOKjpfX5U5n8hb8jDB9RXey0UpM4q24ek=;
        b=PtsSnhaKNy7zuuC1jzn5M8tSZnUWzQVOimqzvd/oMTLGQ0JIftq7HcenKp+pm7zvEf
         RMXi1g57G651zbesgra8s4jIX+5Q6SDoDbsK0DNpBpy6/Cmy8h49FYNdCUE0Zh0/MH4V
         9937ftGKKkWfkvrn2Un2WASg7brppYjTzKVLS4epPjE1Ga+inRucDAiQ98mJw2fywDLr
         pSosMxGI7aObzbmIQXB8GRPAlAeYcY8Kvl3uxw6mjP+lpEKoTDabsRqigw2mYB5JmgZI
         /TrDsJppi5FOTFKQ4HwXSsuyGGmQEQqB7ziOJcdCYwji1ster20u4rDCWKptAcxecr7S
         8iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792839451; x=1793444251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNICyH1Z4rTOKjpfX5U5n8hb8jDB9RXey0UpM4q24ek=;
        b=y2moh0fAUf02/zejiLuDSIFVdIRBWsQ/CtPs9RbOOqoyTTAzYosWusqQAjjdfdbJTg
         CbIvtgk5KhTtkkbT5AJ0gBjZdmK3adIkCWESWf1Ep2r99NEpiVFMiFk9fv12IwalFbY0
         mNpGY5D8cMIe7mcDtztfutkg/mWy9y7zFoMrHhPQM614x3xjpax0Wm7EAOU5keX1Yp1x
         CH4/6YEEkCglzZngM06BqY87lXKPOjlVw8CsB/OXSwMiH0UOuoUtduJisewDAeGmOmRs
         DaSv+3wI0JdK5daXwAQ7Kr16C1wJjMtW7r+KaSASPWfCAaR6FWfocbFI2j6emPDyTJlb
         Y6eA==
X-Forwarded-Encrypted: i=1; AKwUvByAxPmZ3sLGXT0DocnhGohFcvthIvhODz7NMhn2XrILHCIu8Gl1EK+3Qi4qQCAkTh1/SX0X6oFfEOhK@vger.kernel.org
X-Gm-Message-State: AFq9FYISSvboWSHzAAiF86UJDMxwO60zSy2/14AMoVJ6kNb+Ovh+HaeD
	FYVpf1aKRWc/nMuykNkKNX9fLGExYn7huSZvmJYR8wLKookwB7tqBxTz
X-Gm-Gg: AYBFou05qBfgXpdI44WzjPEf6+SajvyP48nu3Rsy9LCc2oek+c8KGL11G3atajyGgP4
	ZMaa8dXkb3aRiYbx39YH9iDKr34HuJ/a4+4qaWiDtND3wiIGlyWOJ7xrlh0hC76s4c/WCyE7SKf
	Ja8fqUnrDskJrkothW963phcm0kZZiAL+QnxesdmrawnOmB0Svf5Lna0Zrc1HJN5CvCB4YhgdIG
	+u+is4B9XK8pCuaHqoQKQdzrkxvj663aw1KTKuIiCqkJ53kOA+E85nEGgKarNIRo0mQMkf5p/Wb
	X/vzlfBhmGZrSjNVlqY7v7w0Fcuyk2/m2cHn/SjqdSJrnoAcUJoleF28gtpvBzysHmHo7nJukrH
	Zaf4zjUjYZb+Px8s7UZapMO8qeRwVcePzK6P6Y9DuE/Yj5ord3lE/nkbsRtSDCCoA6vfBLeemf5
	BrMAvdHWCu3SVDZoDIgql44z+euDRbqPNiUgRTelhCHn1x1O/gZZOMgDrsSDdT0M+7JEFzFyhtb
	xdXn7+PvS2M679GCpPhYMS9FjNL7fP6ymBwKXMoUyaKBrEs1ZAQyV/lQZBo04LrVF9DwDlgnRVt
	F/ZGI+z0+mCVMC38/386ymbJByMneH2TF7aMET9DxeCNK8vg96dGoiQktFPl2bwZnVLawkf3wPu
	YlhECl0IJeS7sO+A31omkRw36Uhto4oX5UEFcdQVoCkNLBGajpqXrsPTzQsyRvI9LJN8W8tgXyR
	9LGiGAxvntfKkydTmyMcPw/u9+SPUJJSoRphJiIj2CJNsnhP1McLAnPHHa
X-Received: by 2002:a17:90b:2e03:b0:3ac:928a:68ce with SMTP id 98e67ed59e1d1-3adeb64b96cmr940283a91.33.1792839450816;
        Sat, 24 Oct 2026 03:57:30 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm2565666a91.4.2026.10.24.03.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:57:30 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
	Wolfgang Walter <linux@stwm.de>,
	Bob Anderson <kernel@ametros.net>,
	Domenico Suppa <domenicosuppa@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.18.y 3/3] ACPI: scan: Do not combine resources that overlap completely
Date: Sat, 24 Oct 2026 18:57:10 +0800
Message-ID: <20261024105710.593-4-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024105710.593-1-ue081723@gmail.com>
References: <2026102308-twisting-bazooka-12b5@gregkh>
 <20261024105710.593-1-ue081723@gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 7617cc05df28dcae967cca109de74084321eaa62 ]

Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
with resource overlaps") attempted to avoid platform device registration
errors due to overlaps of resources of the same type returned by the
same _CRS object in the ACPI tables.  It did that by combining two or
more overlapping resources into one, but it went too far and also
caused resources that overlap completely to be combined which broke
the arm-cmn driver that expects two MMIO resources to be present for
each device it binds to and it expects those two resources to overlap
completely.

Address this issue by adding checks for completely overlapping
resources to acpi_platform_adjust_resources() and add a comment
explaining what is done there.

Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices with resource overlaps")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax162/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://patch.msgid.link/12955564.O9o76ZdvQC@rafael.j.wysocki
[ Ting-Han: __resource_contains_unbound() was added by edfaa81d5da5
  ("resource: Add __resource_contains_unbound() for internal contains
  checks"), which is not in 6.18.y, so use resource_contains() instead.
  The two only differ in the IORESOURCE_UNSET check, and the resources
  returned by acpi_dev_get_resources() never have IORESOURCE_UNSET set:
  it is only set together with IORESOURCE_DISABLED, and disabled
  resources are not added to the list. ]
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/acpi/acpi_platform.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index abdd8893e..29b197440 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
 	for (i = 0; i < count; ) {
 		struct resource *res = &resources[i];
 
-		if (resource_type(new_res) != resource_type(res) ||
+		/*
+		 * Look for overlaps of resources of the same type that would
+		 * cause resource insertion to fail down the road.
+		 */
+		if (resource_contains(res, new_res) ||
+		    resource_contains(new_res, res) ||
+		    resource_type(new_res) != resource_type(res) ||
 		    !resource_union(new_res, res, new_res)) {
 			i++;
 			continue;
-- 
2.53.0

