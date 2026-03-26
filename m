Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439E366072
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513981; cv=pass; b=ZaTdvXmqzQIFx9hJMGaziPCgopksHywUEMsno+sQ5up1Pxo54ex/0qha7hPrBmUshzTgESgmAJYbw3c7PQw45PIrTufM/W6WSB+8Z7FLZq4jKOr9Y2tW4kh3cE7QaJ0g8uxwwi6FWo0JSFeeOjSPZwmQ8lJeswf9zOSvOXmTj3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513981; c=relaxed/simple;
	bh=y1dooAU1BdG3t77Ol/IyqzrIRk3RQ4SObO3++MueMSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2lMGi36aby4ENuC/XdATLtdxiSuC9CMONL3ys2JCS8ixaRKsRaw22yrfqjaL5bOTdaMyG/vt5ZxuFs9Gm18al3NV6Ti92amUH4DYn+hlR0bxu0pim1UGYYJtrJKM15Aj9W74HfjQCB1WXeiaFXwNvL4ZGnnuRwUwr6c4gQOG0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H5E09jiR; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H5E09jiR"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d8b2703f37so613930a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 01:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774513978; cv=none;
        d=google.com; s=arc-20240605;
        b=SdCAIglJm4zQzR2zH9hJ7SXKbYh9pp93fwwk9/71vIjl+epDEDJne7Bu+KiMPZgMoZ
         ffJE2ZJzoJlJNJO1y4TLJO1v8kKPtLglOxiwLdU3GRsl1z670wfFak/iM6rm1QimnMfF
         DfzBI5qAp7r1zeRv+RSjL74RXCJXZfhc4qBASRwh49UjChaz0LJ5xVqHjMg+Ep4wWVvD
         diQY2k4mAzdd/dL2jmRlNiJZUcszHFWUlp3GI3qE0kTF5cuF8gcCkP7cr5KJ5coJQ7Yn
         8uehvw/pbAugUHcQ4t+gUoXjibwwBFN1NcXq52XhQKzhGjBPZ7fCQCz1hpk5ySAgQn+X
         mLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mePLymdm4A/01lEY7TSspPJxPyHHrcq2b7WusiYGL2A=;
        fh=+qg1t5awG3xIWTgwubZrDB3uNS0LVIJ0vasWcQzGTnU=;
        b=dxHK48GvmyWGfwIvnuHLzg67OPd7MzUFxIoZsNB4okK8xqThMQZwGeOrpOCP6/YLUb
         UdtVH8wGbtyX8hM7L0LFlyjX6OavD+0J13dOr0wNKeXDZF8bIo7pcKoRf2HCBNf3VXNF
         qfQrnpYM8f/Q0X1JqKPuSKWVjfyIN/mmLiZ2krav4edwgG8iKboNDvoeR5Nmu4s76gDD
         2yTohphJ7MeeJ/SJyHqJxGWv92i8T9eSjevZ9WrPG4Oe0RsTuvRzApp/6FyKDFWoQGUc
         ewr9C6U/8yCqeC3MZWqFysBO5PY9pM6yp8l8pHMSxRAmMgesuDCRxfHW3gyOWnFCqOKL
         qk8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774513978; x=1775118778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mePLymdm4A/01lEY7TSspPJxPyHHrcq2b7WusiYGL2A=;
        b=H5E09jiRGdFfXO174HqKQe2ylSV8/+PQLhgLEfytIIUYJDgjgVDlgzmFjTxLHOErr1
         5Z3qNYJwXOtvhOOJfYOHwCmsWx5GGVcm8DSqMc8jKJ0MOjoFfojt1/wwE2uQhsnNITBj
         TqD2WR3YDeOfr0DYZu9kXqJhIY6Rl/PmTQaKzj2kLH8Zd8sADH4iA2ZX89KFvTskAkiP
         pyQd0niCoDOMqcBEJun11z2SNo2gF1hRLCpqAPz80sjfwUB2CrrjNyV1kVqx5h7Xc4FD
         AHhifJQRb+PCvW4A9u2VRMLCfHKVQhGM6bAA26WvTbwxFFgpH29pXWlu8l2Fn/gbmyAt
         UokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513978; x=1775118778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mePLymdm4A/01lEY7TSspPJxPyHHrcq2b7WusiYGL2A=;
        b=ED++TDk2MzC1AQMyoMXQZAQEqcsh1CaK0NM4B6tgPc8JqclZ7CCDSV3Er1O7wC2zjQ
         nfuVs/YMZbVBPnv/2LLJAnajbqxwJFkCyAVvnSqQb5YB27aYgBnZBbwFcNGM4ng/E9d/
         JMAB3ruNXR0GBF0OsmNwY3aLSo7mFt07pRUKsLJAfyhBZmdwEbANDlkvsNgfIydpazYD
         BHLrnax0b4v76AEhl6REkxg90fDQ+chzFeYvkAABEceKlA3wUIWuWDcpWeN7jcRGJqCb
         zcDz8UJVBlIayzQ2axKcJnvi5HhAoFBWJtPOf2IfN/eiRnhvmPwAHTYFU8M9maqKHew5
         CceA==
X-Forwarded-Encrypted: i=1; AJvYcCWKmXiz5wr/sD3wfEtmBV+emyd2GWbC24zE/QIoYquzKR2DtlZ9h66VeyHR4ydmJfuXvZTd806j7bnP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1Wv1FENmhOJPfO6ed2Y1GBtbk69UGo1wiZZSCEj0OPZKTMjE
	23kVYILcr+gcfBLKR/6ztAb2kxd5mVHhWQqOC9Sj3Fm/TTT4aPeSP7BS538HizjP2kXHEtydK6Z
	WsfozwhZIjueRdXSHqFG8z5nUJSK5vh6jyK82RrTb/Q==
X-Gm-Gg: ATEYQzzLhTcaSjjKV6HLAScHiT2nea91w5ld5FBADpT8M2/UZ3F+aFwxAGz/XppQwY2
	FqUx3fJY1Sd4SMSyZBjtx4p5Cl7cYuXfk+0kPSGy9fhKfpRfCR+sQFz23DrGp3RDn5DoVMR5koy
	ckjJwt3gT9YQuHBu2dXVPvr46QEGdUB7XIoYAx3zPo4KWMI/bzqB/kr/MGhcSuEmADLur9ljiwX
	Jqf5DVZT7VXBJidlZURjTtUQOMjZnhJTPT+hMDi8NkQCMf0qkrHQsXt4eOXz/xF+6Liq0UKExy7
	6Cm+OA==
X-Received: by 2002:a05:6830:3988:b0:7d7:de7f:1216 with SMTP id
 46e09a7af769-7d9d6a2ee3fmr4210937a34.34.1774513978540; Thu, 26 Mar 2026
 01:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-6-dca586b091b9@kernel.org> <CAEEQ3wmuAnHU1VBFDwbCBFb8j63ZcizJ3jEC2SiVWnoMPc4=SA@mail.gmail.com>
 <acOFef6f9og1hft2@gen8>
In-Reply-To: <acOFef6f9og1hft2@gen8>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 26 Mar 2026 16:32:47 +0800
X-Gm-Features: AQROBzDH3jYcjM2CiSfjVYp26hEHF6X2ANXFbNRUWifhxguxrWvAlswpTfv9uY4
Message-ID: <CAEEQ3w=zV1k+uea5D9tnO=O5X5LQUpyNVZi8V8TOANxXJQbg=w@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 06/17] RISC-V: QoS: define CBQRI resctrl
 resources and domains
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Chen Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, 
	Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew=EF=BC=8C

On Wed, Mar 25, 2026 at 2:49=E2=80=AFPM Drew Fustini <fustini@kernel.org> w=
rote:
>
> On Wed, Mar 25, 2026 at 10:31:39AM +0800, yunhui cui wrote:
> > Hi Drew,
> >
> > On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.or=
g> wrote:
> > >
> > > Define data structures to encapsulate the resctrl resource
> > > and domain structures.
> > >
> > > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > > [fustini: rebased current upstream]
> > > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > > ---
> > >  arch/riscv/kernel/qos/internal.h | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos=
/internal.h
> > > index ff2c7eff50be..c0402dd06cfa 100644
> > > --- a/arch/riscv/kernel/qos/internal.h
> > > +++ b/arch/riscv/kernel/qos/internal.h
> > > @@ -65,6 +65,11 @@
> > >  #define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
> > >  #define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
> > >
> > > +int qos_resctrl_setup(void);
> > > +void qos_resctrl_exit(void);
> > > +int qos_resctrl_online_cpu(unsigned int cpu);
> > > +int qos_resctrl_offline_cpu(unsigned int cpu);
> > > +
> > >  /* Capacity Controller hardware capabilities */
> > >  struct riscv_cbqri_capacity_caps {
> > >         u16 ncblks; /* number of capacity blocks */
> > > @@ -125,4 +130,26 @@ struct cbqri_controller {
> > >         bool mon_capable;
> > >  };
> > >
> > > +struct cbqri_resctrl_res {
> > > +       struct rdt_resource     resctrl_res;
> > > +       struct cbqri_controller controller;
> > > +       u32 max_rcid;
> > > +       u32 max_mcid;
> > > +};
> > > +
> > > +struct cbqri_resctrl_dom {
> > > +       struct rdt_domain_hdr       resctrl_dom_hdr;
> > > +       struct rdt_ctrl_domain  resctrl_ctrl_dom;
> > > +       struct rdt_mon_domain   resctrl_mon_dom;
> > > +       u64 cbm;
> > > +       u64 rbwb;
> > > +       u64 *ctrl_val;
> > > +       struct cbqri_controller *hw_ctrl;
> > > +};
> > > +
> >
> > Can we trim down some fields? For example:
> >  struct cbqri_resctrl_res {
> >         struct rdt_resource     resctrl_res;
> > -       struct cbqri_controller controller;
> >         u32 max_rcid;
> >         u32 max_mcid;
> >  };
> >
> >  struct cbqri_resctrl_dom {
> > -       struct rdt_domain_hdr       resctrl_dom_hdr;
> >         struct rdt_ctrl_domain  resctrl_ctrl_dom;
> >         struct rdt_mon_domain   resctrl_mon_dom;
> > -       u64 cbm;
> > -       u64 rbwb;
> >         u64 *ctrl_val;
> >         struct cbqri_controller *hw_ctrl;
> >  };
>
> Can you explain why you don't think these are needed??

The functionality works well without those fields, feel free to try.

Btw, when do you plan to send the next revision?

>
> Thanks,
> Drew
>

Thanks,
Yunhui
