Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97148987E;
	Sat,  1 Aug 2026 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785589460; cv=none; b=bdRjkGZWQxFgQwkFauKhV/FXY4/Ubt1bxeEuxnla8pGTX0EcsrIa4rsbMlKCPErS3H/pD6S9d7p9mhKex+CKoh3S1GDxYiPW0zdk+cEP3FBpYssaJIxl8M6MZve8aGXRrqlYcfGBJJjZkDH1iDIGV2N6SyHWvTB6IPR2hCYyo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785589460; c=relaxed/simple;
	bh=SVCbXs0M9xK4LFeZSrtuP4u0POcf8rPvnDo4ZiyZGKk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ub4ZztBFm3SrADQi6FCNnhVR/aYAn34R6VX0SHMjieEg18bMVSUUyg6b+A/jD2mHv5oXq7DNBIo68HE8KhtgITe+FNVn3fKzAIcdUO/nT9V+n867MfQxJh1tUXiHNld3imBtcD6X+ffAXnvxhXJwEDzTEbdWsGZE+l2rMDFg1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awlqaFJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awlqaFJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5A71F00ACA;
	Sat,  1 Aug 2026 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785589458;
	bh=hV4t2FKEoBNJWJxe8K9VtsKUstAqL8S3Ca/PGub6Jfk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=awlqaFJPIX0qapS6MkAxDz07BMiVvfLacpy9TuqfZpyhlp3vr4AZX9tKG9oyeFG6V
	 92I4K2ikC3Yjt1L4w8rgZzAIhV7Sd+kS29LfT6lmjW8/O2RJHfRQCyMyjwq5WZmiVr
	 T15S7nI+XuclZElLll+hrZQ0LOz78mof6rPStpn90NsYgYzpJH60UfT3M2kVgwU/Xo
	 3BmA5SLBty0vZmwO4btZbqBfAqR7b20Tnc6tX2FxGLai8Q6GetWg3uRNhZj24p6og9
	 ZLqrMmK0axk1HJlOBpXOlQn6tefUVmGLAfvCgyhOirvi5hmMlpQgOSv/ED7nlKcL9L
	 Fx44S3HM7xrkA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6DF59F40070;
	Sat,  1 Aug 2026 09:04:17 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Sat, 01 Aug 2026 09:04:17 -0400
X-ME-Sender: <xms:0e5tas2My3ciiwvk4RVvvV32bXcSstrrThIoM4vWYs4kZXtP18NxhQ>
    <xme:0e5tah71tVB3a7ErCxpN4Nssot4vjZPiQWlMbvydHD9dUZyimvFILBz8GOKzV819r
    qUbMVujWsJuM8e-Q11XwxkYVr0UA8-mUps-p3stMv4PnFYsRagskng>
X-ME-Proxy-Cause: dmFkZTE3Ry/FiJ8n1QjRkIN/mfMdxIbs4RQAJiSIcmf7koK/AhGcmqOxg0b4hqplWugh+v
    fmzHM11lNj5KdX0HmTb28U2qntGAGe1IvT7XOuXouFX6nkDC/yHkeROGFchTbxot8TSyxu
    WRqU7t5GvgRnNUCx0lloN3s+J0/R2UPtA61SH820se7Spe1qtlcxYCOeA4/BWX8H2VJBq7
    9QblKjspulJHrHK/hrEi6hs3B9tUM/xNVglB6Z53jX+dKUTsp/K3qqrwujt9WhyoIOUlWV
    AxOvk4QL4eqo7D6BLmhNP10YwhNWVo0NQ+IO/vJI1jGDh7YyjoYuWslF7C4VHz/3WYUeZd
    ZhXW3g8TPs773yRPf6XcsfBxJN12cgThZShM78v+riT5QGYiuNYVHh1qpS4dHE/aAQByGB
    Uagv3Vpgf0wo5fmhYCsGHsBYn9uNYNnRGEZ1d9iujuAJmBKHKv7H4cviJOKvcEW4MhhB+9
    7e/xe74Ecuu2ljyYL+P6rXU1zPqLJW282n4MOCZw8EjZP9mrOvSPsgWLQMr48N5V3nnbZw
    y+3Lkfa6/8F8ejzUCypMDcmy8auY7BHjVOWa3Lz6JRSI/DCMNN9Uiiut1EFo06ED53CF3P
    b3pMGixaOxGkhpkb5DGrSOCDVKTnCHcyUTiD0o0F16Bk7uh7FJR7uyvDwZJg
X-ME-Proxy: <xmx:0e5takZ1HOBS95Kac5in0iyVYrphTNCA3U0Qo8ISLfaOVOkksbKNAg>
    <xmx:0e5tag8QsQB16nZke69dGb_kmoCfrhtJ59VhAH42qJCDYnFq2ELWeA>
    <xmx:0e5tauPmL3aBTrz0HRY6FwQa3iAS5JHOyKFMA9Nu_ZGO_5HAgSBGYA>
    <xmx:0e5talESGDrJWETHHQLaQUN0fe7glICT3rUfFhrEbNeSpPV55gXOrQ>
    <xmx:0e5takyg-Ubb83uek9lqpCCV5YvrL3e_JkRjVBbrZUdRjDDrRUa_yn_C>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 188AA182007E; Sat,  1 Aug 2026 09:04:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 01 Aug 2026 15:03:56 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: "Tony Luck" <tony.luck@intel.com>, "Borislav Petkov" <bp@alien8.de>,
 "Hanjun Guo" <guohanjun@huawei.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Shuai Xue" <xueshuai@linux.alibaba.com>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "Morduan Zang" <zhangdandan@uniontech.com>,
 "Linux ACPI" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <dcf45d3a-ec13-4877-8ab2-ec114a312fb1@app.fastmail.com>
In-Reply-To: <20260706093158.80364-1-pengpeng@iscas.ac.cn>
References: <20260706093158.80364-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] efi: cper: validate processor section item bounds
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, 6 Jul 2026, at 11:31, Pengpeng Hou wrote:
> CPER processor error sections contain counted arrays after the fixed
> section header. The ARM path receives the section length, but it read
> each context header size before proving that a full context header
> remains. The IA32/X64 path received only the payload pointer, so it
> could not bound its error information and context walks against the
> section payload.
>
> Pass the IA32/X64 payload length into the printer and track the
> remaining bytes while walking variable records. Also make the ARM path
> prove that a context header remains before reading its variable size
> field.
>

Please split this into two patches (or more), and explain in more detail
what the problem is and how you are fixing it.


> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/firmware/efi/cper-arm.c | 10 ++++++++--
>  drivers/firmware/efi/cper-x86.c | 32 ++++++++++++++++++++++++++++++--
>  drivers/firmware/efi/cper.c     |  3 ++-
>  include/linux/cper.h            |  3 ++-
>  4 files changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
> index b21cb1232d82..75a32f3a31a0 100644
> --- a/drivers/firmware/efi/cper-arm.c
> +++ b/drivers/firmware/efi/cper-arm.c
> @@ -313,10 +313,16 @@ void cper_print_proc_arm(const char *pfx,
>  	ctx_info = (struct cper_arm_ctx_info *)err_info;
>  	max_ctx_type = ARRAY_SIZE(arm_reg_ctx_strs) - 1;
>  	for (i = 0; i < proc->context_info_num; i++) {
> -		int size = ALIGN(sizeof(*ctx_info) + ctx_info->size, 16);
> +		int size;
> 
>  		printk("%sContext info structure %d:\n", pfx, i);
> -		if (len < size) {
> +		if (len < sizeof(*ctx_info)) {
> +			pr_warn("%ssection length is too small\n", newpfx);
> +			pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
> +			return;
> +		}
> +		size = ALIGN(sizeof(*ctx_info) + ctx_info->size, 16);
> +		if (size > len) {
>  			printk("%ssection length is too small\n", newpfx);
>  			printk("%sfirmware-generated error record is incorrect\n", pfx);
>  			return;
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 3949d7b5e808..77621a5677da 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -3,6 +3,7 @@
> 
>  #include <linux/cper.h>
>  #include <linux/acpi.h>
> +#include <linux/printk.h>
> 
>  /*
>   * We don't need a "CPER_IA" prefix since these are all locally 
> defined.
> @@ -254,17 +255,26 @@ static void print_err_info(const char *pfx, u8 
> err_type, u64 check)
>  	}
>  }
> 
> -void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
> +void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc,
> +			u32 length)
>  {
>  	int i;
> +	u32 len;
>  	struct cper_ia_err_info *err_info;
>  	struct cper_ia_proc_ctx *ctx_info;
>  	char newpfx[64], infopfx[64];
>  	u8 err_type;
> 
> +	if (length < sizeof(*proc)) {
> +		pr_warn("%ssection length is too small\n", pfx);
> +		pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
> +		return;
> +	}
> +
>  	if (proc->validation_bits & VALID_LAPIC_ID)
>  		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
> 
> +	len = length - sizeof(*proc);
>  	if (proc->validation_bits & VALID_CPUID_INFO) {
>  		printk("%sCPUID Info:\n", pfx);
>  		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
> @@ -276,6 +286,11 @@ void cper_print_proc_ia(const char *pfx, const 
> struct cper_sec_proc_ia *proc)
>  	err_info = (struct cper_ia_err_info *)(proc + 1);
>  	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
>  		printk("%sError Information Structure %d:\n", pfx, i);
> +		if (len < sizeof(*err_info)) {
> +			pr_warn("%ssection length is too small\n", newpfx);
> +			pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
> +			return;
> +		}
> 
>  		err_type = cper_get_err_type(&err_info->err_type);
>  		printk("%sError Structure Type: %s\n", newpfx,
> @@ -321,14 +336,26 @@ void cper_print_proc_ia(const char *pfx, const 
> struct cper_sec_proc_ia *proc)
>  		}
> 
>  		err_info++;
> +		len -= sizeof(*err_info);
>  	}
> 
>  	ctx_info = (struct cper_ia_proc_ctx *)err_info;
>  	for (i = 0; i < VALID_PROC_CXT_INFO_NUM(proc->validation_bits); i++) {
> -		int size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
> +		int size;
>  		int groupsize = 4;
> 
>  		printk("%sContext Information Structure %d:\n", pfx, i);
> +		if (len < sizeof(*ctx_info)) {
> +			pr_warn("%ssection length is too small\n", newpfx);
> +			pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
> +			return;
> +		}
> +		size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
> +		if (size > len) {
> +			pr_warn("%ssection length is too small\n", newpfx);
> +			pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
> +			return;
> +		}
> 
>  		printk("%sRegister Context Type: %s\n", newpfx,
>  		       ctx_info->reg_ctx_type < ARRAY_SIZE(ia_reg_ctx_strs) ?
> @@ -357,5 +384,6 @@ void cper_print_proc_ia(const char *pfx, const 
> struct cper_sec_proc_ia *proc)
>  		}
> 
>  		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
> +		len -= size;
>  	}
>  }
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917..87e65377a15d 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -675,7 +675,8 @@ cper_estatus_print_section(const char *pfx, struct 
> acpi_hest_generic_data *gdata
> 
>  		printk("%ssection_type: IA32/X64 processor error\n", newpfx);
>  		if (gdata->error_data_length >= sizeof(*ia_err))
> -			cper_print_proc_ia(newpfx, ia_err);
> +			cper_print_proc_ia(newpfx, ia_err,
> +					   gdata->error_data_length);
>  		else
>  			goto err_section_too_small;
>  #endif
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 440b35e459e5..a2fa9376f6c0 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -598,7 +598,8 @@ void cper_print_proc_arm(const char *pfx,
>  			 const struct cper_sec_proc_arm *proc,
>  			 u32 length);
>  void cper_print_proc_ia(const char *pfx,
> -			const struct cper_sec_proc_ia *proc);
> +			const struct cper_sec_proc_ia *proc,
> +			u32 length);
>  int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
>  int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
> 
> -- 
> 2.43.0
