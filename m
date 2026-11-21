Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795299881;
	b=Km3GSSQCYofVNKjFLFMaHhlvr9hSe3AxiwVi691S8iA4E7E0INFZXZBSu7HkyAR5xZLl
	 buWXpkMWbMgNz6kgunotPagpK4O/RjASGH8VuWTcxqQ12VlHRNGFm2iBZrrY0Zy4DoChN
	 Fna9z6RWAhYXuqtgwuDoA59J9FDDIpMqiIzkSSpzaXhvv170DZsoJZhlHa+c6RJH15is4
	 B1TzFNmpNXnV9/SwLIrbgQUrUcpYw3wEwD9B9Mwj+DQNGr+vXSApRRVhagoyZehD0Bcn8
	 K+SuMyVVKcFQ19tVp46j4bp4PDll9LWzi/XMEfX8Oyc+sVC2VKnhHTwz7kgGgUKBySA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Hz3905wAXZE2z0xpo1pg4iMkZNUnir/n6DiACnoEPHk=;
	b=nmy62P2eL2nKg5rOiFyqc6bofxbetVM6pv+EubaukVeTLRG081jk+hoLyurRUA/kNWj0
	 MFwxw9KKEkv88NpaczXoG5hK0OQEidNwF/cpvMZv13KAg9YkMFleFRBRvyiLf7yqcb3Du
	 Vy8hCmbsYvcnFX8Jbc0xv66ilcS2iX9bwCqnbtJqMq0KssqpKp83wlSGF1NQgihF6XF+v
	 XyF0z0AEMvLusoh1q/M1UuSZxlPykJnc5HRh/VgO/h7idMSSS37Ys5qjGgUgNo8Xavdbd
	 EAVPJqpNJ2y8SVe/R61l+Ypgk7BOzM5xpiS6agGKqRQ1xLCgDJFmZqq0K1MWQ7yw5hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iwlx/YiR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ACB606A32C
	for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 22:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68ACB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwlx/YiR
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8253bc5a613so1382227a34.0
        for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 14:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795299880; cv=none;
        d=google.com; s=arc-20260327;
        b=GXDRDYZzos1JgTtu/FPHquO/A3+Y7E55SuB+to/n+Dl9E3yczlVvNzQxFBLVRv5yGO
         NzO10D2Dg4AQBRudX2f4BGyI8+sn6+e11ZPgP4ieZ0JS6CGC+uwLuQEqIp2ZFEzxPj29
         aT3ti3YLyL3DPm2BgsrO8+LCWQzHui6RZZ8hZTbtA1zrMd4B1/xf4iBBthZaflg70Xgo
         sX/yrNtQ8kSELsKVjioezLezhHl1nuNbZZB13TkD8zC8R+0RikzyGHhITn9Av13egzcY
         oEjlDcG2kdkUgSnAvWa9Hh6x/wWRZ9+sOB2v+OCqoFTl6hRuaSi0b+tAwk06QHN4RihH
         IbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hz3905wAXZE2z0xpo1pg4iMkZNUnir/n6DiACnoEPHk=;
        fh=ZJanA8Nf/ru9Qw5goPeWck9ggSRzl35Zl4wtXF7KaFc=;
        b=Wejj6cQBpHlPRleCZ1F9qxaW+fmNYObLtJ+zyzGYhoJLrKjbGio8uYfo3o3kPu6RR5
         9S7tE5fxOelbGMDxm/Tt3/6I1WIxINS62AXuDe7c3hZcgTdG81zuRcfYU9EDGc3fBSB9
         WkiCPWuflO46m8QbX5vDiFQOkZK+tnngPGMr48gKsefXDi6zrZWxlvXO1DJPghmO51q+
         mhb/UW4Rp09cZwRPLLxbV5BUsBVVZTK76OLdVuIqpaSogv0j11Ykjugkt6E5B9Sj7O1Z
         tWaXJY5uwSp54kgj2IazFn4vmg26urYQ0j74iXdRqXRcQkzHGRDJ4Gded3vHGs80kL8C
         PpcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299880; x=1795904680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hz3905wAXZE2z0xpo1pg4iMkZNUnir/n6DiACnoEPHk=;
        b=iwlx/YiRPAdloZBmBL4iBicJ5qjH9cxWWijc/+M0drPUqUyZTbyNJy1fF4OT9IRKe0
         d9Fvg+W1Z+BJo2/wkQEHEhZ0wb8qMWAAy8SURPHAmuW7Prn8OoPQRpH3ZQiLVbvNExCd
         D3JvxE3k1EDmvNnPy3wgk9OYi3WVjmTK+ZzmZhRH6RkaeUQY1gkOX4gei720SqPrvqAo
         n3Gjyhgh5oofchX8sCPo9HlapCvfneWCMqgBmF7Um+ph8RD2dhm5mGt7D0B3wW8RFdAE
         64dXwJfl40o5/4PsehIkbg3hnsPU0ZkeLl/wU/ArSjwqoux4f7QoDcHtYxvFtHGHs8Xr
         Ym0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299880; x=1795904680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hz3905wAXZE2z0xpo1pg4iMkZNUnir/n6DiACnoEPHk=;
        b=tH1JIgU/EkuONPUCcFdXxPrM/TR7zJmauxqenik4QZ0x5znHImRohOIQ5gmxKrIxCP
         XN2ddkzS7DBft613GNC53dIRCw2/PoMzEpsIE9CMd340OqizzHsUCufatkY5Rro5pu+r
         jKJadAdfdUmiynDT+BycBnt9if2OvI2WfDh9MB7sxDYspmfnObD0M6Tcgstd/4JfTOuW
         8ukFJmat/77kIvH7hJ9wYJdRL5K7029dkrShdFwlOVlfuQDHvFMzvUsYaEGIauetntFf
         he75G69FY5hp0wonYE3o/uYMLXKqt9OAba7WtMjRxMvENHsBqT8Uut7H+xv33BSKn4oa
         YOBg==
X-Forwarded-Encrypted: i=1; AL+hErFoRO80hOjW8PCXvEaE9uhhFQB+UjUiK3PiFNnqxgAUs56uOadPWo0xHlG8fb0vVqMpH0MX8iVCiiXZ@vger.kernel.org
X-Gm-Message-State: APuU4Z9VVf0rVWnQBoBBptR5Djm3LEA8fkoxUQB4gbekoAlCRYBTCacG
	ixvAXyedajEKZIAU5qFbSU7OfXI+R01uNeJtl1rJYXU+wjrjrnr5k+vTTefGVaYmI89Ww6Gx+0o
	XIz/v1VCF9YrK0h25mGW2CBI830T6gSo=
X-Gm-Gg: AZFdTZfBZHfhPoFWFbAKjjNCL3VtRSHlXrtN6J1qwe2/GVxXcvU23xL/2LfCwcIeLZn
	WBaSZ13sFAq9xOqaGfpLL3pisbUkz2iLxVHmjAiFBKhlAVhwhPGZuir7pa3oblzzCYD+/Hc0V2d
	y9bKj/dH3KWzAhsOekTk+Ehop9sVINv+2tDyu7nXJdiLnoXVn4y0eHMROClUlKpfpyXSABXhQjS
	l4Nn4nbgOBte/2JnL4jVVNYA7ZBsshGA9iTL7tfNA7/Tnn7Blil+ZhGLCmztxrxVoJmbedF6KmL
	I/HUMhnGa/mHQvPKfN8bW/8+utjOY0v3hBYAoTzidZ9xH8EB6JDNgJt/GIspY4Jo2UxPk8sM8bM
	W8v7bQCeKmrCqIaXol8bczBAMtrTnCN/kislu
X-Received: by 2002:a05:6830:2692:b0:862:eb1e:6a78 with SMTP id
 46e09a7af769-8631593a1b2mr8377193a34.7.1795299880305; Sat, 21 Nov 2026
 14:24:40 -0800 (PST)
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
 <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com>
 <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local> <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
 <20261121194030.GBawHzrrCNCMpfr7Gx@fat_crate.local> <CAG4KcRKhE1UXwrhscUdSpDJS8R0t7kWp8RXZm8j_9yXYJSQ2KQ@mail.gmail.com>
 <20261121210749.GCawIIJcidCeWs3ij9@fat_crate.local>
In-Reply-To: <20261121210749.GCawIIJcidCeWs3ij9@fat_crate.local>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Sat, 21 Nov 2026 22:24:28 +0000
X-Gm-Features: Aa3M54pmfzCjwgwOho9jx8HJwewKtlzAxxWUC8EhQd9hmHj0B3lyfXoGWgN4lh0
Message-ID: <CAG4KcRKzXNsvBWuuU2_aX5gO7u4vgKAK+bkrB2vgEFBGu3WJCA@mail.gmail.com>
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

On Sat, Nov 21, 2026 at 9:08=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Sat, Nov 21, 2026 at 07:53:54PM +0000, Shiju Jose wrote:
> > Please find the attached patch with the changes.
>
> Thanks, you missed a spot. I fixed it up:
>
> diff --git a/drivers/ras/ras2_mem.c b/drivers/ras/ras2_mem.c
> index 70f7f0b497ed..de5555d2e1b8 100644
> --- a/drivers/ras/ras2_mem.c
> +++ b/drivers/ras/ras2_mem.c
> @@ -117,10 +117,10 @@ static int ras2_get_demand_scrub_running(struct ras=
2_mem_ctx *ras2_ctx, bool *ru
>                 return 0;
>         }
>
> -       iowrite8(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]=
);
> -       iowrite16(RAS2_GET_PATROL_PARAMETERS, &ps_sm->params.command);
> -       iowrite64(ras2_ctx->mem_base, &ps_sm->params.req_addr_range[0]);
> -       iowrite64(ras2_ctx->mem_size, &ps_sm->params.req_addr_range[1]);
> +       writeb(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
> +       writew(RAS2_GET_PATROL_PARAMETERS, &ps_sm->params.command);
> +       writeq(ras2_ctx->mem_base, &ps_sm->params.req_addr_range[0]);
> +       writeq(ras2_ctx->mem_size, &ps_sm->params.req_addr_range[1]);

Thanks Boris for fixing this and verified by testing.

Thanks,
Shiju

>
>         ret =3D ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
>         if (ret) {
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
