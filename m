Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C549505E
	for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647303; cv=pass; b=EhI1W/ysJCJSwSVqVQ8WbGOQkWcPMVOEURNJMdN2UkEK7TP1vH+Po0bT8osTAYOo54Xu1w5N0PbFRFq/KXPQonQzysHOk+npHFWebBVWo7eNQZVLTDQy0qEJBuixqvGGc2/YLhvC+c+RVsqUgL5g+zMl10eIHhRUlgpE2oRW5yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647303; c=relaxed/simple;
	bh=MZMk5amhVvwpxgU22Jr2gG0SimDKHn4o3AJnpzUIRys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkkYW4SChfEWUqNKkBS4LO4hbyTsfb5eZi6d3vQ+HhdVpfgfZew//mW+YPAbSU6gmnSEPipP9GZEaWudhJTTvdnY8lEQgCySRlEkZ6KfkqTkSDgXW/pSBNA44S/85p0/3wMYAupAEEzY4LDtfAjun5S3cVwJfdVJPFO/IRb8wf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb662xZ+; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb662xZ+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4a416619cb2so82903b6e.3
        for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 11:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786647299; cv=none;
        d=google.com; s=arc-20260327;
        b=Ykb9psVc+s9e6uhNVeotGa9CvMhT82w43dIfW8cDFau7HVyGNoNPlHkHo8A/SVZpaA
         HRtmjb8MUPtI7YZ+AM/MCTXVobV1vlO3MzFAFOBZnsjSC9VF7qHWGe23lgmy+MTFvgdo
         pv8NmSpaYvZsAwqzQAIPV/KIDrMG5ZentEbH3SSwj4Yoy8jZObnFhju9V5N3/6nVouDA
         iaY9tERBXmkTD47bFzzkZgRMXyzEO6dyQD1liZoOwr6SrSQYom3kdGB2DUE/qENCkAHd
         Ub7lAIMDM+w6ixsK9O6K2m/Yrfs651d+7SW6Uqm9wgf8cvmbYC6GtG+og4TGmhjno7mD
         AmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4D8xAVPVQumphtAB0QLf5r82YP3dFNVcG1VBTYgExPI=;
        fh=4lSLjHMqUH+nF6a5+SdgHoOJYn/mLQN0pq5WA74W534=;
        b=AitaT51LBzxPn7T2gBn8k91Ott0/qFnSfxnblKOd50J/tHv1gGFGI4FJDPdAbtONQQ
         TcTbLsYhWdrx35EX6c8W4RSH7Nl1yB17Q+lERrfcZCD4n4yXo4fnPtK27Ys54PDUcoBf
         /xY1sD561TatYaABhJL8jFCUTCqkH0vGoiIslL4E7Z9WLinuxw810ZqpzSo/qkdsHzHa
         CgLKka8Znfcc9Cw71VAkYMN9whahsZQrkACDg65cJQ7OI+kOYlIMnSF6dC/1Ct6AM3Q0
         J6+673Wuhxk37hdMIi5dmqvHJa4F+suZ7exzkmYE/vzQUsYQPIvs8vsyjWtZzOLhtc+W
         cDZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786647299; x=1787252099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4D8xAVPVQumphtAB0QLf5r82YP3dFNVcG1VBTYgExPI=;
        b=Hb662xZ+DWuhLhaaGHLkKwhvVQkAyjuu/PDNAfrIObBmSVhXeN5Gd7WV9Tj/Da6tlP
         HhTkaB42si8PfQUj565U6maiY4Ko7hf50VQAEH9QvZ0mXUFnQji/vjRcGiHhBxqlY/IC
         ydGjxxG4oJDa+kyPJP0mp5624mcrPpInWRn6HBrqkCBg2c9VhFWICjbbC6YQC9cdRgX5
         akmXV2iIdZysTz50F5YhtEnW2ll/mTW6wH5PZlpUbw2BYe4z8GqBp8jMH5pjyyVhLQ8j
         HjKaonWdjXjGgwdW0jzBpo+HQnSuSC9Hs5Jxak29ZbQfmFCH1mMWyFjxnFANMh2V6+8n
         ZmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786647299; x=1787252099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4D8xAVPVQumphtAB0QLf5r82YP3dFNVcG1VBTYgExPI=;
        b=OwuH6VCDhC1sUTTz8DOIjqEEGJiEPYoY6OFIC76RQNon4+t+SxQccVZLTv72pJUm4s
         ju+++zwpocFZO12VTCp0kPtqhcRVKfXAvOXr54EYZ0tkyGaFdbQqofhIQLfVCrwtZvqK
         UXGuYftmx8mM50FaYOMv1urQBbsXdeFoCv5yW8Ua5V+YGQhKp4LVRW8aPSZfZWv3b7b2
         LpwopMIfAIyg1bT8P3Ax4ph4vphttAz43ZXJ/3Aup6QXLUgcJQe89r18ut9lhxR1OyMZ
         pL65Lso8ghdVpySg2ayTDyio/9v35mNmzvR6+EGpKcz+fPr8jkXfYFYG6e21KS3UqL2X
         NVzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8jNWS4B96U2JaH+BuBpJkPsN7llWGEmZZefw0hGljnr7jawWqR+DRfqMp5l0VbjUKy0COx5DGXYE6@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHqJ8IwNvBntCzun7hm8tH6Fpx0ur6rvR1PlCOUlheXOExKb7
	MyFECbpdReTdxPUZgr2aP7DBIXu3XtZG8tpoZzltofrqcm7YdJfwPwFMauQfqo53RItLH5b5pZj
	Rp73WV0H2PQXEz5zN9Sh8hPvVGvR6kKM=
X-Gm-Gg: AR+sD13VnNypAYvhmRbdzfT6QqMzH6TR+wry+zACIeHphd70Z/+jlpTfqd2UZa1oeQa
	dN4Yu1mPqFbzF1NNMXSuMus9BLDqNhbMdOG1Xf5OWKU7dYt+AFq1Kt0f+UvU+f+TiWe6YhRSmJV
	Bw8X9eygnarfADDpOVnSUb1aBnHqyjZinW/IA6MItonIGsLdmId/hD6fU2yYcpos07c0h9Nv5fs
	XrrNjo/kLnW56hYVmX+bdA4BztP50NDP4NG2Bi4VsBbsIIwAyUXoCpjocBy1zUAFIn2KNlRKeR8
	Cb5xDL1oRAcky20S8AAAVyHN1vOPVgVV7JBwQDzUAhjM
X-Received: by 2002:a05:6808:1456:b0:4b2:3e72:bab1 with SMTP id
 5614622812f47-4b2413e7cd2mr156530b6e.6.1786647299226; Thu, 13 Aug 2026
 11:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-2-shijujose2008@gmail.com> <anvRn4g9Ihn5eyVq@hu-ashoraj-lv.qualcomm.com>
In-Reply-To: <anvRn4g9Ihn5eyVq@hu-ashoraj-lv.qualcomm.com>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Thu, 13 Aug 2026 19:54:48 +0100
X-Gm-Features: AUfX_mzK2KYq66enN11TTUyY_bgBfEgK88jDGTBrTGSa-gkPWcIl2Tm-4YHdY2Q
Message-ID: <CAG4KcRJR9+KMsoWjUWjaMveTteqMUrFukTcRgb0SZ593Zqj=tQ@mail.gmail.com>
Subject: Re: [PATCH v23 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature table
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: rafael@kernel.org, bp@alien8.de, akpm@linux-foundation.org, 
	rppt@kernel.org, dferguson@amperecomputing.com, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com, 
	mchehab@kernel.org, jic23@kernel.org, linuxarm@huawei.com, 
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com, 
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com, 
	jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com, 
	pgonda@google.com, duenwen@google.com, gthelen@google.com, 
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 2:51=E2=80=AFAM Ashok Raj <ashok.raj@oss.qualcomm.c=
om> wrote:
>
> Hi Shiju
>
> On Sun, Jul 26, 2026 at 10:28:11PM +0100, shijujose2008@gmail.com wrote:
> > From: Shiju Jose <shijujose2008@gmail.com>
> >
> > ACPI 6.5 Specification, section 5.2.21, defined RAS2 feature table (RAS=
2).
> > Driver adds support for RAS2 feature table, which provides interfaces f=
or
> > platform RAS features, e.g., for HW-based memory scrubbing, and logical=
 to
> > PA translation service. RAS2 uses PCC channel subspace for communicatin=
g
> > with the ACPI compliant HW platform.
> >
> > Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> > Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> > Co-developed-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> > Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> > Reviewed-by: Ashok Raj <ashok.raj@oss.qualcomm.com>
> > Signed-off-by: Shiju Jose <shijujose2008@gmail.com>
> > ---
> >  drivers/acpi/Kconfig  |  11 +
> >  drivers/acpi/Makefile |   1 +
> >  drivers/acpi/bus.c    |   3 +
> >  drivers/acpi/ras2.c   | 509 ++++++++++++++++++++++++++++++++++++++++++
> >  include/acpi/ras2.h   |  57 +++++
> >  5 files changed, 581 insertions(+)
> >  create mode 100644 drivers/acpi/ras2.c
> >  create mode 100644 include/acpi/ras2.h
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>
> [snip]
>
> > +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
> > +{
> > +     struct acpi_ras2_shmem __iomem *gen_comm_base;
> > +     struct mbox_chan *pcc_channel;
> > +     struct ras2_sspcc *sspcc;
> > +     s64 time_delta;
> > +     u16 val;
> > +     int rc;
> > +
>
> [snip]
>
> > +
> > +     /* Ring doorbell */
> > +     rc =3D mbox_send_message(pcc_channel, &cmd);
> > +     /*
> > +      * mbox_send_message() returns a non-negative integer for success=
ful submission
> > +      * and a negative value on failure.
> > +      */
> > +     if (rc < 0) {
> > +             dev_warn(ras2_ctx->dev,
> > +                      "Error sending PCC mbox message command: 0x%x, r=
c:%d\n", cmd, rc);
> > +             /* Restore CMD COMPLETE bit on error */
> > +             val =3D ioread16(&gen_comm_base->status);
> > +             val |=3D PCC_STATUS_CMD_COMPLETE;
> > +             iowrite16(val, &gen_comm_base->status);
> > +             return rc;
> > +     } else {
> > +             rc =3D 0;
> > +     }
>
> Minor:
>
> Sorry, I missed in prior review.
>
> Can the else after return be removed?
> just set rc =3D 0 should be sufficient.

Hi Ashok,

Thanks for the feedback.
I will make this change if another version is needed.

Thanks,
Shiju

>
> Cheers,
> Ashok
