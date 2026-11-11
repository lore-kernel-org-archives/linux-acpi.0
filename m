Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356676;
	b=fLYLMkFYtMjcF9WXf/Yjtwt45OG1A3Dd9KINxyueiBFv1T/qDmuNd60xgz88iSOtwBRR
	 ZsNAF0/97P7ZlaxcNCZ8qAlD2u01zJ8aOq1eFINSKtOt84tR+DmjFpb2erb4IPCCFlDbx
	 ICUhsJ6/e7cIegpyo0iXuBP61w4DUcApTLsbs0sDQfs7yCeSp/XliHv/2IrR/dOMXqxrz
	 OkDqxW+K1AJ2K3upyIhkJzTstPa1AIZdDqHgIIAosIr/ODxxE2CWDvJNm67DTFR6E/LFW
	 drN7mKe4Qpf6tEx2hLqQpiSsWCcZG+7svmPc0cVBH+oU7XVzkHp0CZPXTP0qWd0nusA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356676;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VLiSMF2P5bM+KzZEojnsS0Nzj7JPVB+h93rmBjLbkdI=;
	b=SzYFHgrId+uM08vn+e70KMIhzrFNhWhKqUKkjop0uvSSHuLDSHFl35cz2rjYIq0MHf6C
	 XqXJqo1tilL/uVGdKjjB3NX7rE5TCQ17aEQscAL5D1CV7onBlgBsiKTrl+g2P3I8Aje8r
	 uJhfo+ZSn9JdvoVobclAQkOugdTy/JXVFOJNFwnUjBRMy/6OvVmFSrld2LWn8t6iEuaig
	 lOzujBwzUTzuBHoJsj+gV8s8ODL853FL8AiexSsGHdAbN02rqEEY+lK+77sGbT3taiQKc
	 DHDFl4Xsr0rkhqz+G15Z19kqyYu6+TZ6W3+5ZXNqjlBpCNos/suC/uvkfHME61DvuNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="XnEutz/T";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56C606AAAE;
	Wed, 11 Nov 2026 00:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B56C606AAAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XnEutz/T
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4BBC540E021B;
	Wed, 11 Nov 2026 00:24:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xTdtctuwWz_x; Wed, 11 Nov 2026 00:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794356669; bh=VLiSMF2P5bM+KzZEojnsS0Nzj7JPVB+h93rmBjLbkdI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XnEutz/TX94FbM9IWw1v5hBYIuwAq5JzddB2zLR/bCLd7NxWsZbTduGfwlaXxFvLA
	 Nh0fdsepneObwKj8gDmP+8PDfFPI9Dy6nOrj30TqcaWxsBcrz5fZsHTLiWZyq9XELO
	 nZqQlk8EqxloJJTBW9sxZ6e8HWk9Ld392pDAGrOjl+HrG8c/RAcDjaRT2AF7hzIjVv
	 gk6hQOBMc5Ich3OF/I2xVnlrWc0S1oqPTo+MZCmb8my80ZlfNdR/6O2XdlBpOwQK9z
	 j/pN27AQSBfDsgLc+aDcQPYfDLMes44pugylsdUjloPsufKZdDsxz0pjW0KJYAuGum
	 ejfr7nRN+Zewt1nwS/AMiijJfCdTCykh/fR8+ki5J26HP2BaZJ8WO/qqh5IczdTfpV
	 CB1IdBR4d/M7Q6lQhy8JMYAx26cjgT0FihHk69ry8BSWfkH8ohGT23lXOcVgTMtwu6
	 xXpfctJ+eai0X3P3Jhi7701mg+ZAv3feWRN+v9CE86x+47HObyYohOCLE2ePpA2464
	 GvNeoTdGYVCspCOGjZnqEuu8NrNsgpZU+//tqhdiCb2HQgbnvyxNownQ9FgVLs4Nik
	 PeSJcaDoMfAAlWAc0uixdyRyAejKdbeeOBPWbwwIqQ+yGLoVb5zCLBByK61H1ruM7/
	 wvNpDwgM9yTdMMsfHlFMOA8E=
Received: from ehlo.thunderbird.net (unknown [72.170.223.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A86B440E0218;
	Wed, 11 Nov 2026 00:23:51 +0000 (UTC)
Date: Wed, 11 Nov 2026 00:23:37 +0000
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shijujose2008@gmail.com>
CC: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, ashok.raj@oss.qualcomm.com, jic23@kernel.org,
 linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
Subject: Re: [PATCH v23 2/2] ras: mem: Add ACPI RAS2 memory driver
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
References: <20260726212812.89266-1-shijujose2008@gmail.com> <20260726212812.89266-3-shijujose2008@gmail.com> <20261017055852.GBatMOnEl66YObvU5k@fat_crate.local> <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com> <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local> <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
Message-ID: <1E6CF157-ED3B-4032-877C-38A4F63F7E40@alien8.de>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 10, 2026 11:00:45 PM UTC, Shiju Jose <shijujose2008@gmail=2Ecom=
> wrote:
>I am sharing the changes in patch#2 here for feedback while testing on
>other platforms=2E

Thanks, I'll merge it in with what I have locally=2E Once I've gone throug=
h the rest of the outstanding issues, I'll send a final version for folks t=
o take a look at and test and get a chance to complain=2E

 :-)

--=20
Small device=2E Typos and formatting crap
