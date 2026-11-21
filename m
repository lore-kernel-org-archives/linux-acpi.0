Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295316;
	b=i8sq5nsJi5riSX+AxMChIHwBxLVu7xKFJPuxDtdx1QjCfI5P1WKKZOM1Up4IVIC6WYGU
	 mrCh2IrC9aMfrhKgOqBtzasO1/JjLx1qSwYHDMK9gB8WTSq7pPLcnQClvs7eoqesdC/3B
	 +88gP7XgExQMy2jrJIUDj1qTDgNhzHjeUpkeU0biI9DvNkP556JrUWoIeoGD1CwyvTzQi
	 0SeCORXv4Qs0ltQMzesbTj8c9lm4pcROwcIFBugkxYbNawzD+ZDnc7cTzhYITFUMubOIR
	 hpMyVAycj/Ekt+T3cNB7FQmuUeu2AKQ3BlEndif0ccTAKYnrcxtTvwOxxuSFsnKQosw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295316;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1pLbQi7zza7AIs4/iHTKdLl5NrGmgjuIa2VnMpqoqqg=;
	b=XdhoMKVgFwX5gprvVT3rIfh6uOR+3i4Swv85x80mbu1EBJVmgTqhkAgonnre0ZUyMH2m
	 nTA7rNDgVT63APzpGWkCYhr/gtZWHmLeRo5zFNgb3PDfKf6FtT4H99d0MMfWZW8OJbtf4
	 W/SS1xWe6zt1yOp7p2QNDUSUUWUCaN9qtzGkJuYUBBtwhYl92ii5WqQ9lvLOTvjIezqUG
	 lR/Oln9vau82Hagaqtzpkr/0nGX9DWViN0daJ5ZmOsZBfrcCFa0b/YluDgHtqO/el5kLl
	 g9upVLbtcds6FcSSoMNm7tADXeKfUKyLWiC6rzfrcH9fbr4NjDsdty2X2qfZxhR6Irw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="X/vAMYqO";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329E606A320;
	Sat, 21 Nov 2026 21:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A329E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=X/vAMYqO
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DA9B540E0218;
	Sat, 21 Nov 2026 21:08:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l4Kpp3JLw_RS; Sat, 21 Nov 2026 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795295309; bh=1pLbQi7zza7AIs4/iHTKdLl5NrGmgjuIa2VnMpqoqqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/vAMYqOh6mySiHk2jEHVxmT8rSRUa8Bwf39VzJ7oToVx0S5brhq/pPhAjYrJprRk
	 B1rungD4KUVnC3FPuQty6szTKA/fIoy/1LjXG6Bb6qJ44g5DMR9jn8VnftEkrSjiwv
	 /KwtlLU8iQ71/N6OusphVOpuHaumpNf9qZEcaCwRslpHlp7mHoHU3DeIySb8YiAkb9
	 vhNKUBZC4KOWMzYduUcj9OAWUQwgKfbC/cXENJHIAJyLbEEG4HgadZxrEhjdTuSrFL
	 loTRW/WJgXmjpmGK7nBVDM2pyEpF6YaJCqUspiGh6yx5dECYP5gMPUwmGndTZQFyw5
	 jG5dW2mptuc0YLgnr/addjUO81eh+8Z5W6pzPpWMVn/nCp2qQpJYLORj/OjjeLsOM5
	 N4mPYH4FsyXRJGxJwfMGqwyGGUBgl9SgQZN5hNXENMx0iyC4by5aB0WxlWRrjJXb8/
	 GX+OGm/B9HHxsZGW1Z/yfnpCMEtsWcGGHw8e2VHWwO4D1s9zkHXyZYy0yHG9AjrthN
	 8GHJp8Jqr7U8zvADh2CT1O8izIRYSV5L8/LshBkkTxtHe3FEm5SKcm1RN53niCK4H9
	 a1Id0DVzMX+udzhbSmxBA4/HmfZkd4oCF95hwb6oRlz7rS+yd+7PT/8rC1GmkdXjFQ
	 PBs5QPHeJRs17yhYrnxXbpiQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0F1140E00DC;
	Sat, 21 Nov 2026 21:07:52 +0000 (UTC)
Date: Sat, 21 Nov 2026 13:07:49 -0800
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shijujose2008@gmail.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	Yazen.Ghannam@amd.com, mchehab@kernel.org,
	ashok.raj@oss.qualcomm.com, jic23@kernel.org, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v23 2/2] ras: mem: Add ACPI RAS2 memory driver
Message-ID: <20261121210749.GCawIIJcidCeWs3ij9@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-3-shijujose2008@gmail.com>
 <20261017055852.GBatMOnEl66YObvU5k@fat_crate.local>
 <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com>
 <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local>
 <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
 <20261121194030.GBawHzrrCNCMpfr7Gx@fat_crate.local>
 <CAG4KcRKhE1UXwrhscUdSpDJS8R0t7kWp8RXZm8j_9yXYJSQ2KQ@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG4KcRKhE1UXwrhscUdSpDJS8R0t7kWp8RXZm8j_9yXYJSQ2KQ@mail.gmail.com>

On Sat, Nov 21, 2026 at 07:53:54PM +0000, Shiju Jose wrote:
> Please find the attached patch with the changes.

Thanks, you missed a spot. I fixed it up:

diff --git a/drivers/ras/ras2_mem.c b/drivers/ras/ras2_mem.c
index 70f7f0b497ed..de5555d2e1b8 100644
--- a/drivers/ras/ras2_mem.c
+++ b/drivers/ras/ras2_mem.c
@@ -117,10 +117,10 @@ static int ras2_get_demand_scrub_running(struct ras2_mem_ctx *ras2_ctx, bool *ru
 		return 0;
 	}
 
-	iowrite8(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
-	iowrite16(RAS2_GET_PATROL_PARAMETERS, &ps_sm->params.command);
-	iowrite64(ras2_ctx->mem_base, &ps_sm->params.req_addr_range[0]);
-	iowrite64(ras2_ctx->mem_size, &ps_sm->params.req_addr_range[1]);
+	writeb(RAS2_SUPPORT_HW_PARTOL_SCRUB, &ps_sm->common.set_caps[0]);
+	writew(RAS2_GET_PATROL_PARAMETERS, &ps_sm->params.command);
+	writeq(ras2_ctx->mem_base, &ps_sm->params.req_addr_range[0]);
+	writeq(ras2_ctx->mem_size, &ps_sm->params.req_addr_range[1]);
 
 	ret = ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
 	if (ret) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
