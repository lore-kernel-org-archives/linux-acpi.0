Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795290076;
	b=zzO3E+bcsZ45GCbxwrtKB/ysBR2zvHjB9Fuxc9S2WZvhTY+70ZH0CN9Y4qkKnIITE89K
	 vh0OOV2nq+MPet9HhRKYXDhmdFMRh1cJUPe5TM00VppTSBWcz3ImxgGEYs5prf0THRrvW
	 TFaBgZUzWekC/VxF+E2VgA+ECKiaJQ8K+9eSKR3i9KDItD1xpR2KVAA31/Ovk2ZenUyLC
	 U4YisRpD0KqKx2nVrGxF4F+o0tnB8CSqYi5jQQrJVDtEIajtiq6AUD3DiYST/LwzmUxH4
	 /iR/RJyBz3Juy2A5+aUDvvaiKVIJQSmVU2rEKrbx856SaGHDRxno1yjgZITWlz+q4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290076;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+onO+f8a19JOkIsaY0Ktl6fAq9BXdKARBPZo/DbSfCU=;
	b=IZTrkaDZ55n4BawDXLYyxe7B93TLA9BGUYJWvqsjOI711GDQV2nmRdE7qqqAfJRlGQ0m
	 Akqm+WLeEshpw9nAPDrw9dcjbsJbpbExjM6w6BdqkxKsxrHo5NRomxapllgS4qv98ToFe
	 ehli6WlgevZP2OtGGWj6Dsq/bkfHBOs4wMG1JiPyt6rEmFp5QFn84LCyhOIKzjKx4JV/i
	 2XSdVTQv/ojo4VoRDcNSEOKc6mYGr2iNJokRtwDY1en/GgO5UmwfzDzl7rCVLaZRPg6mN
	 3XbC2sZf3byD3Hh/3c3fe7quiFeZqj3IT5wXs85CeaQEyd+sP0O+fZ18HxutIMmMx8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="a9e85s3/";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859C606A32C;
	Sat, 21 Nov 2026 19:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2859C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=a9e85s3/
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7E11940E00DC;
	Sat, 21 Nov 2026 19:41:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GJebFJ9-qlEV; Sat, 21 Nov 2026 19:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795290070; bh=+onO+f8a19JOkIsaY0Ktl6fAq9BXdKARBPZo/DbSfCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9e85s3/Kcg6dkQ4T/hod+dHO+ADXdQXKv80Rc06qwTecP/R43KDj6Tf7mOA4GDcE
	 CtwDSx5FolO6snw/xn7zaBizU+UyqRv2z/Ka9CfNOevUJymosv2KYuIVnPwCnI9jS+
	 Gr80otaHgiV7SbeWX4Lerce5gyskwWSZ2CGdZjvZ6hXtiiebuwyB5f53E7MZaLjFBG
	 3FhhGiBHs8lfLRwPSf2JVQxtpqqkXr4ghaYyfqJPvGy3TaILZEoQ45PMHQPNxgVRUs
	 7MWBv3k/1LCalDnIP6qXRCZeEe3ythQaxfD8uY0/F4Sd67rPOrU54e+cogrSasT2UU
	 DfbO/cBzBLgTYAn/NlzU/+dysZ0F2zO8CNYdGTNYhpa1+KDHRiRCAEoVjdwe/9y9qQ
	 SLIBW2ZoIPC7NkndmPiZOhjevW1FDuWVpWK5sIjRWBCoZPDTn0ctDkgxkQnsn5CFVi
	 B339NEmPnE6t/FVch24RfqhW3LQJDyn2XbMkHv8quVtReb/v8PYNTAy9BQxk49k+Y2
	 uxQ5y3ntPRgw+Igch283WMP5H5NyZYappEXYUnmq2XAHwY2Lhxg31v2hGnix+VKjnI
	 r3l6BR+7vwp8LUseBXEc/+wrNQk6x32BAJhPZSIXeTolPchGgRkX5Ft3y9OVtRmWGo
	 41yM3Zn3a+BzfhjJOas2NWyQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CAB340E019C;
	Sat, 21 Nov 2026 19:40:33 +0000 (UTC)
Date: Sat, 21 Nov 2026 11:40:30 -0800
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
Message-ID: <20261121194030.GBawHzrrCNCMpfr7Gx@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-3-shijujose2008@gmail.com>
 <20261017055852.GBatMOnEl66YObvU5k@fat_crate.local>
 <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com>
 <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local>
 <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
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
In-Reply-To: <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>

On Tue, Nov 10, 2026 at 11:00:45PM +0000, Shiju Jose wrote:
> I am sharing the changes in patch#2 here for feedback while testing on
> other platforms.

This doesn't apply. You can attach the diff so that I can fold it in.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
