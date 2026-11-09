Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227546;
	b=IwqD063h4osQ/tFSQCpyQQpP9suK25H8WNgBRy7F6Lqfsd9fnfqFaRy2GWoQsoj7qiVX
	 BHAERT2yA75XuHU3DN+yBLRnN/e2t+K/eyZvtQU6ww/WmEbdTjYGZOEMxIK6LKvf4rAoU
	 7xIm3r03CT9b2+UYU6lrV6a8V6SoPET0mYhlNAzGumomV9pcz4+nxHl7iEWt7VdCGJIez
	 iC4BcmBt5wTgy7qxykUFdXLbpipxcMSuufhGHYuGb/uwcQdJnVgXd2Y66elxtUodAXExz
	 1ZWGxpT3USS/mZw10YkPyW4gT7mUHbW5MT02EiLA7neCQfLQCgDvdiTInqsNpIG9S0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227546;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Udmccze+zEanKUPWVBdY9ea3z20SVh/JQ2hv1/0uQrs=;
	b=iSArC4AWE4GG2mfczvkNeT/W9t5xExuj9j22jfS8QNL+iFF6AtwMfGWE/5IKf44SIJkz
	 vFFI63sSO6kZnaw8GtXlE20PcfhVU4XYh+rf4RE2gsWwmo0Le2vgUtDpcAq9asDGNm3OR
	 aohUwww1QizNTO0qn6iwnp/4Kq+PrDapNXsetBXbpH/74pFjOrX+BGe3CZVARCUgsbXe/
	 b58anNqoT/SZVpKb7dJ/5XNyCifZJeUZ87l0hq4R5f+Rg1wJzwGol4meWH/36McgAE6+6
	 u+7etuFkX8Tc6BWj/nXtI04yuQxfROscyhIuUHZyTLG697qlO9jxLXSxcRvH3Ru08tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2uAQNvu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFE606EE83
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2uAQNvu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06CD1F00901
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794227546;
	bh=Udmccze+zEanKUPWVBdY9ea3z20SVh/JQ2hv1/0uQrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j2uAQNvurfz6hqPo8AX7nyJWh6yTaZ4yAuFyY5y46qObrXnVyBfeOxM07RoqO2tnN
	 TsfTi5Yxvx2ZCgIF6MjOPXzgER8N05yBcQIcgtUKSv5EB2d8pJsTY/CRvASfiQxQXz
	 FJTllwJ+0nrzCupCfmgv+3MsoehzdmHbklEm1UJjtZMumXXBCR9DS3hRUUEFewn6OP
	 K4r6vgDwNMcbUx4lgc9SW3cUkomwfVGq5SVQ1R3IoNZKO+qwdaWQVSCfxBNplOd1qp
	 dbQGspErS1dOQ1URxoYBAHZlIlYsKQHp/bc5f0Kdxtri7t5567dJA6+mMAQHvdbSdO
	 vHtCKGOzcnWYA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso944438e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 04:32:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG4DDjGxgzm92/oXPEyNAAl5Een7OnH6YMw5xzvLsBvZJzHNJBB8DQ9LR8dr6HRZVOkcGmEpilMJNcR@vger.kernel.org
X-Gm-Message-State: APuU4Z8Psl2OZp7y3ugQhPa/X7E45nvyMmi2MRnrzSqpcjpf/dNyWBoY
	7qCkMxo4YnNklCwnmPnJHrkBYrwQj84FL/lmK/D+8avqhsqr9qWHFCCILTTB/l0HlC0QDXAX12s
	m/vF8gl5YT2oWUyhKfj3MZBLuxlcGXfk=
X-Received: by 2002:a05:6512:31ce:b0:5be:4386:8072 with SMTP id
 2adb3069b0e04-5c14c042497mr1063807e87.56.1794227543795; Mon, 09 Nov 2026
 04:32:23 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
 <7c59eada-ea8d-4b04-a24b-9ba6aa2a6c64@arm.com> <62430a5e-1e43-45de-9f8b-f0fdc826f38b@arm.com>
In-Reply-To: <62430a5e-1e43-45de-9f8b-f0fdc826f38b@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 13:32:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hGEa=ZBLcJDGfbL5S7C99Kj8JJpaqObMj1RZZeLn=puQ@mail.gmail.com>
X-Gm-Features: AclHuK9C0VgmSOJIoZ6xy9CAOcwTI4p77cqP0wxSxIc4pGinWekVEQNGKsbwnGQ
Message-ID: <CAJZ5v0hGEa=ZBLcJDGfbL5S7C99Kj8JJpaqObMj1RZZeLn=puQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] CPER: Add Memory Error Section 2 support
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Breno Leitao <leitao@debian.org>, 
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org, 
	linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:58=E2=80=AFAM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
> Gentle ping to check if there are additional comments on this version.
>
> (Thanks Mark for the review)

Sashiko has some:

https://sashiko.dev/#/patchset/20261104110355.1437249-1-pierre.gondois%40ar=
m.com

Besides, for CPER and APEI patches, you need to get an ACK or R-by
from at least one ACPI APEI reviewer listed in MAINTAINERS.
