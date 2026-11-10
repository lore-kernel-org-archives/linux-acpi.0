Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794351659;
	b=ErWlK8efkXAVXHN0p30Vzc7WEAKFdtlfHVxcboqt3di3uuW5uxhaAWn1NvXta2dUrovq
	 yM+1r78+sRLs42qq73wLw/NzOAWwN5juUyC87um5cL0HJKujjJgNu7PHNUMMSt6QLnvzh
	 wF6BjNyxvmxa/ss5R00Mriyw+hZdSgFwtNG0cYVeBJNCrLGcQkeHvRG4olSTvdNA+4xJR
	 4yhuxjcJgP4Npm+MjkNybqRDAlqbaug/XLHwtU66k7Tw1BcBc59uyJI4/fwZzTzMbTfPa
	 3A2xuxgt/KFxMUjoBSXxurNtS3kNDsyuewM1q9RicOMqSJGp3oRcXZa/f+UjADTyBlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o9zfjeLXx8nlaVhvD+KO4LRkpHUPOVyGHHNomAn5t58=;
	b=bN/19UxKWmOn722DPErEIOqA2gJ7+Oa5MV9FKLRrLIBs0rUWy5A7hSe6d4V1BWFLkBmO
	 lx+EEcv2AME2JcngxW1GatzRfTm4TfeZaZxXUeBx2ZdS0ucGugJwvJikpgqDxCWcmjg67
	 e4nB85fOTwZED/bP7NAiGIX3i64856W5c9tX0bTA2xIuWagIy7zvcw6HMKQUnK1ZD6s++
	 i06RLM9+KQ/N5NpyMVotvowCcKpRBah8Z8Xf+c5daevPPVODb+AfBQPQB2r4pXOaMnOzI
	 Bkyc/usU4pdJcOdkbmnjVKze/jwll8ubDPfbwaX0HTnRVFDrK3KU6MGxTaElrVXbklg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NME2XDvX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B53606A325
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 23:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B53606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NME2XDvX
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso1820106e0c.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 15:00:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794351658; cv=none;
        d=google.com; s=arc-20260327;
        b=ayA7xPkI8usPIrr9hxuqRCQ4xo7g8Lm1pF8EP7t3Uo1DigcdAtj8IrIk+uqQtN763r
         nKFnORaLbCojDVrfJlmZUDMPvWGMNzq6J6EruAT7VQX9Rxt1qJW3453eYfY7yCCT8r0W
         NBn5xgw8Flb8rb6qgJ3XchXHG1mFr/Ryl5Mr2U0TK0B1jUv4QsNny/VUYGDePge+EbmW
         V5ZK7itPbnrhU8Lg/f8wMjDdqYQYzNEj79/CCslW3rum5jZRZ2OLO+SUrIkNnZ/qOcsC
         fBYNz9UOMJN3xORTBhjphFMhXgEnfi8/ZAbaTzKcuhbwiSrPGCyPGw1+7bGdyEzbn1yc
         1uyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o9zfjeLXx8nlaVhvD+KO4LRkpHUPOVyGHHNomAn5t58=;
        fh=ELwgEqMcr+SbPG7KW7+0CzEKgOANNZjyf4VC8aU5jvA=;
        b=XRw0dJRNXramxhLdoTgxdTaWDPRYMB0AWtjkHsFypC8OGne4s7l68QT1WoYJhw4Gke
         PD9Eg/mLNvWp4O1EwzvCEjf/702lpMy20Jjl6aIlS+4qykxbOFmezWygAXkX+qfKw6i8
         Adf8hmGm8RiyQGUjlPD5az/XjhUqDKKOdXcOmr17r6Ns1Fy8GqgVjeBKRywTucZXVJaA
         FNru9JQaASraoaBa3puWkp75ZgnRLEOno7m4lZI5Fly5jF1K0Ex1vHodF7IdYwE5cyS3
         +lvfpZ882HXPU3PYQRidwbb1oBY6XGPfvl37ShEVcF4P1D6PNk1vDmkFvYKu4W8dvu3v
         rRtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794351658; x=1794956458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o9zfjeLXx8nlaVhvD+KO4LRkpHUPOVyGHHNomAn5t58=;
        b=NME2XDvXz1QujELu1uKRy4PxvIj2Y3PYnDNxLGaRJFXJC5ZFBnWaaDi+D35cX54ClJ
         trsKh65JQNX56lyiMhfhk4D5VOv1LJGb8xYjL2MxH+kNH82lqbWZMINu6x3XvAZGrVOx
         GRLav0QN2+HQeaZ5T44dwIaCYcj7H5lhxt7bxACj2RI4wsFf1r32H8s1wAMW8WL279WL
         KPDhCnEOnAAVi7nJ9gLA/JIjRANM60bMgnBcO5e0xVrZdFDJRkHFLgJPfZbD3PYEnxSJ
         +MVokBumaQ2FGU2sBvqyi7pOgpugTbA/Htj8GPVvIXIT8FB7Qb+hAXCviNxlVo+d2+wT
         SDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794351658; x=1794956458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9zfjeLXx8nlaVhvD+KO4LRkpHUPOVyGHHNomAn5t58=;
        b=ZO5B6yqpSto1lW9u+Tf/lnsuEqVznGbcscgaa/ugfl2PGuxwzIvUFGwwWn5sYvslru
         yAwk+MtzHsTwB0IzzxDJt2Lof15VlOD9pbrfLOIapsH0zfC1G9qtZY5tBlwIpHOICTEl
         2qhPeJtP/D6lQe2Yd748sv3o8mKnQCVErFR8Uql64wGollsKgAp2bZ5XwBHsnUCqTwps
         hdRoGL5I4qR/uR+XZy1rOCgYx+rgjxTVMvSY+lcVXEEo0Y+88c9f4qjGLQphwFAULQPs
         oMW9NtwpTc9HMH5A9+mKN94mCjkPkLWSg+3iLlYmNc0xs+4rbPcfmckri9DILeIhgfq3
         5oQg==
X-Forwarded-Encrypted: i=1; AL+hErHo08Y70GXcES5Qh3bp/D1GtJyG0xpl7r0nL5I+zytjefEYbwyv4fXXjCpGwDzsnJLVdEIRzbfvbs79@vger.kernel.org
X-Gm-Message-State: APuU4Z8nouwsXN+R5ConNhg0i7OMYCZf5JEG8L8xl3Nq61RMYB+27kh0
	l3O75S6KikEY+ws6GMEI8vWCpEim7KF3hBn19cyc7e2gS6C/e7VNwZ5vqLn2zmWM4UrzGdBdZgB
	I5zRw9qmn8JoSLGji8coCHj8Zg0ZbRL0=
X-Gm-Gg: AYBFou0N1f+35wbhiXfTcoOkACAj2ySzmpUhZgH7LJf8Aa3R4+tTjyGJSDgVgpoVfbo
	cPtvAVQExHs8/v+uQyLn7TwnuNxsSgjExZ8PlBaqmOiRBcfuJ0qTkZsl9nxk5P+RZb1wSxZ/0+X
	rShNZ+ZhT1PxyAU1P0SLpwpvMiuYVJfxVRJXnvMeZJ0Nr2VP7BfY9qvYhdWuMEVeXXOzk6i3QET
	T6VWT5wb1VCTLanyQW2bad2+oSncvS9G6DMPykAEWvuythAlftBGIjNh6mAvLyIIuKXnopALuMk
	SLxOVLqj3MdWPL9M0ryCKUzobl6VK5MRSbK/MSy2+qA3RgaWrHsxWuNbZPe1TIJQEBgkleQcmmU
	sEgMCLJeKQnTvdmAsTZb6iaiNU400K8CBB5xW4Q==
X-Received: by 2002:ac5:c752:0:b0:5ee:b3:a43d with SMTP id 71dfb90a1353d-5ee1b02333dmr198001e0c.21.1794351658145;
 Tue, 10 Nov 2026 15:00:58 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-3-shijujose2008@gmail.com> <20261017055852.GBatMOnEl66YObvU5k@fat_crate.local>
 <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com> <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local>
In-Reply-To: <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Tue, 10 Nov 2026 23:00:45 +0000
X-Gm-Features: AclHuK9UQtupPx8LMZTpk2yNTMX5hNKYK0tRiitG5dSZyQW9ncd1bgVrIhw2Lvo
Message-ID: <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
Subject: Re: [PATCH v23 2/2] ras: mem: Add ACPI RAS2 memory driver
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com, 
	mchehab@kernel.org, ashok.raj@oss.qualcomm.com, jic23@kernel.org, 
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 7:18=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Sun, Oct 18, 2026 at 11:56:22PM +0100, Shiju Jose wrote:
> > I have got an arm64 setup only, did not try to build for X86 recently
> > after adding the following change
> > of using iowrite64 and ioread64 as suggested by
> > https://sashiko.dev/#/patchset/20260325165714.294-1-shiju.jose%40huawei=
.com
> >
> > Following change is required to build for X86_64 build when using
> > iowrite64 and ioread64, while it was
> > fine for the ARM64 build.
> > Note: I'm not sure whether RAS2 is needed for the 32 bit build or not
> > and the result of the 32 bit build.
>
> I'm not sure iowriteXX/readXX are needed here at all.
>
> Documentation/driver-api/device-io.rst talks about all those different op=
tions
> and the most generic ones are readq/writeq().
>
> About those you're using, it says:
>
> "ioread64(), ioread32(), ioread16(), ioread8(),
> iowrite64(), iowrite32(), iowrite16(), iowrite8()
>
>   These are an alternative to the normal readl()/writel() functions, with=
 almost
>   identical behavior, but they can also operate on ``__iomem`` tokens ret=
urned
>   for mapping PCI I/O space with pci_iomap() or ioport_map(). On architec=
tures
>   that require special instructions for I/O port access, this adds a smal=
l
>   overhead for an indirect function call implemented in lib/iomap.c, whil=
e on
>   other architectures, these are simply aliases."
>
> and I don't see anywhere that you absolutely need those, judging by that
> explanation there. But what do I know.
>
> Unless there's a real reason you cannot use readq/writeq()...?
>
> But those should give you the same fixed endianness when accessing little
> endian ACPI so...
>
Hi Boris,

Thanks for the guidance.

I replaced  ioread8/ioread16/ioread32/ioread64 with readb/readw/readl/readq=
 and
iowrite8/iowrite16/iowrite32/iowrite64 with
writeb/writew/writel/writeq respectively and testing passed
in the arm64 test setup. Also the X86-64 build is fine.

I am sharing the changes in patch#2 here for feedback while testing on
other platforms.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
From d504d61a17d46b0aa1141b5d1cf828facb67eef6 Mon Sep 17 00:00:00 2001
From: Shiju Jose <shijujose2008@gmail.com>
Date: Tue, 10 Nov 2026 22:48:52 +0000
Subject: [PATCH 1/1] ras: mem: Replace ioread8/16/32/64 with readb/w/l/q &
 iowrite8/16/32/64 with writeb/w/l/q

X86-64 build failed with ioread64 and iowrite64 are not defined.

To fix this issue replace ioread8/16/32/64 with readb/readw/readl/readq and
iowrite8/16/32/64 with writeb/writew/writel/writeq respectively.
---
 drivers/ras/acpi_ras2.c | 56 ++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/ras/acpi_ras2.c b/drivers/ras/acpi_ras2.c
index 51adfcddfa99..0849dd247cac 100644
--- a/drivers/ras/acpi_ras2.c
+++ b/drivers/ras/acpi_ras2.c
@@ -51,9 +51,9 @@ static int ras2_is_patrol_scrub_support(struct
ras2_mem_ctx *ras2_ctx)
  struct acpi_ras2_shmem __iomem *common =3D (void *)ras2_ctx->comm_addr;

  guard(mutex)(ras2_ctx->pcc_lock);
- iowrite8(0, &common->set_caps[0]);
+ writeb(0, &common->set_caps[0]);

- return ioread8(&common->features[0]) & RAS2_SUPPORT_HW_PARTOL_SCRUB;
+ return readb(&common->features[0]) & RAS2_SUPPORT_HW_PARTOL_SCRUB;
 }

 static int ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx *ras2=
_ctx)
@@ -63,17 +63,17 @@ static int
ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx *ras2_ctx)
  u32 scrub_params_out;
  int ret;

- iowrite8(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
- iowrite16(RAS2_GET_PATROL_PARAMETERS, &ps_sm->params.command);
- iowrite64(ras2_ctx->mem_base, &ps_sm->params.req_addr_range[0]);
- iowrite64(ras2_ctx->mem_size, &ps_sm->params.req_addr_range[1]);
+ writeb(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
+ writew(RAS2_GET_PATROL_PARAMETERS, &ps_sm->params.command);
+ writeq(ras2_ctx->mem_base, &ps_sm->params.req_addr_range[0]);
+ writeq(ras2_ctx->mem_size, &ps_sm->params.req_addr_range[1]);
  ret =3D ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
  if (ret) {
  dev_err(ras2_ctx->dev, "Failed to read patrol scrub parameters\n");
  return ret;
  }

- scrub_params_out =3D ioread32(&ps_sm->params.scrub_params_out);
+ scrub_params_out =3D readl(&ps_sm->params.scrub_params_out);
  ras2_ctx->min_scrub_cycle =3D FIELD_GET(RAS2_PS_MIN_SC_HRS_OUT_MASK,
       scrub_params_out);
  ras2_ctx->max_scrub_cycle =3D FIELD_GET(RAS2_PS_MAX_SC_HRS_OUT_MASK,
@@ -94,10 +94,10 @@ static int
ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx *ras2_ctx)
  return 0;
  }

- if  (ioread32(&ps_sm->params.flags) & RAS2_PS_FLAG_SCRUB_RUNNING) {
+ if  (readl(&ps_sm->params.flags) & RAS2_PS_FLAG_SCRUB_RUNNING) {
  ras2_ctx->od_scrub =3D true;
- ras2_ctx->base =3D ioread64(&ps_sm->params.actl_addr_range[0]);
- ras2_ctx->size =3D ioread64(&ps_sm->params.actl_addr_range[1]);
+ ras2_ctx->base =3D readq(&ps_sm->params.actl_addr_range[0]);
+ ras2_ctx->size =3D readq(&ps_sm->params.actl_addr_range[1]);
  } else {
  ras2_ctx->od_scrub =3D false;
  }
@@ -128,7 +128,7 @@ static int ras2_get_demand_scrub_running(struct
ras2_mem_ctx *ras2_ctx, bool *ru
  return ret;
  }

- *running =3D ioread32(&ps_sm->params.flags) & RAS2_PS_FLAG_SCRUB_RUNNING;
+ *running =3D readl(&ps_sm->params.flags) & RAS2_PS_FLAG_SCRUB_RUNNING;
  if (!(*running))
  ras2_ctx->od_scrub =3D false;

@@ -338,18 +338,18 @@ static int __ras2_hw_scrub_set_enabled_bg(struct
device *dev, void *drv_data, bo
  if (ret)
  return ret;

- iowrite8(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
+ writeb(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
  if (enable) {
  if (ras2_ctx->bg_scrub || running)
  return -EBUSY;

- iowrite64(0, &ps_sm->params.req_addr_range[0]);
- iowrite64(0, &ps_sm->params.req_addr_range[1]);
- scrub_params_in =3D ioread32(&ps_sm->params.scrub_params_in);
+ writeq(0, &ps_sm->params.req_addr_range[0]);
+ writeq(0, &ps_sm->params.req_addr_range[1]);
+ scrub_params_in =3D readl(&ps_sm->params.scrub_params_in);
  scrub_params_in &=3D ~RAS2_PS_SC_HRS_IN_MASK;
  scrub_params_in |=3D FIELD_PREP(RAS2_PS_SC_HRS_IN_MASK,
ras2_ctx->set_scrub_cycle);
- iowrite32(scrub_params_in, &ps_sm->params.scrub_params_in);
- iowrite16(RAS2_START_PATROL_SCRUBBER, &ps_sm->params.command);
+ writel(scrub_params_in, &ps_sm->params.scrub_params_in);
+ writew(RAS2_START_PATROL_SCRUBBER, &ps_sm->params.command);
  } else {
  /*
  * There is no need to send the command to stop background scrubbing,
@@ -358,13 +358,13 @@ static int __ras2_hw_scrub_set_enabled_bg(struct
device *dev, void *drv_data, bo
  if (!ras2_ctx->bg_scrub)
  return -EPERM;

- iowrite16(RAS2_STOP_PATROL_SCRUBBER, &ps_sm->params.command);
+ writew(RAS2_STOP_PATROL_SCRUBBER, &ps_sm->params.command);
  }

- scrub_params_in =3D ioread32(&ps_sm->params.scrub_params_in);
+ scrub_params_in =3D readl(&ps_sm->params.scrub_params_in);
  scrub_params_in &=3D ~RAS2_PS_EN_BACKGROUND;
  scrub_params_in |=3D FIELD_PREP(RAS2_PS_EN_BACKGROUND, enable);
- iowrite32(scrub_params_in, &ps_sm->params.scrub_params_in);
+ writel(scrub_params_in, &ps_sm->params.scrub_params_in);
  ret =3D ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
  if (ret) {
  dev_err(dev, "Failed to %s background scrubbing\n",
@@ -449,22 +449,22 @@ static int ras2_hw_scrub_set_enabled_od(struct
device *dev, void *drv_data, bool
  goto enable_bg_scrub;
  }

- iowrite8(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
- scrub_params_in =3D ioread32(&ps_sm->params.scrub_params_in);
+ writeb(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
+ scrub_params_in =3D readl(&ps_sm->params.scrub_params_in);
  scrub_params_in &=3D ~RAS2_PS_SC_HRS_IN_MASK;
  scrub_params_in |=3D FIELD_PREP(RAS2_PS_SC_HRS_IN_MASK,
ras2_ctx->set_scrub_cycle);
  scrub_params_in &=3D ~RAS2_PS_EN_BACKGROUND;
- iowrite32(scrub_params_in, &ps_sm->params.scrub_params_in);
- iowrite64(ras2_ctx->base, &ps_sm->params.req_addr_range[0]);
- iowrite64(ras2_ctx->size, &ps_sm->params.req_addr_range[1]);
- iowrite16(RAS2_START_PATROL_SCRUBBER, &ps_sm->params.command);
+ writel(scrub_params_in, &ps_sm->params.scrub_params_in);
+ writeq(ras2_ctx->base, &ps_sm->params.req_addr_range[0]);
+ writeq(ras2_ctx->size, &ps_sm->params.req_addr_range[1]);
+ writew(RAS2_START_PATROL_SCRUBBER, &ps_sm->params.command);

  ret =3D ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
  if (ret) {
  dev_err(dev, "Failed to start demand scrubbing rc(%d)\n", ret);
  if (ret !=3D -EBUSY) {
- iowrite64(0, &ps_sm->params.req_addr_range[0]);
- iowrite64(0, &ps_sm->params.req_addr_range[1]);
+ writeq(0, &ps_sm->params.req_addr_range[0]);
+ writeq(0, &ps_sm->params.req_addr_range[1]);
  ras2_ctx->od_scrub =3D false;
  ras2_ctx->base =3D 0;
  ras2_ctx->size =3D 0;
--=20
2.25.1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

Thanks,
Shiju
