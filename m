Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C438F250;
	Wed, 17 Jun 2026 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678740; cv=none; b=tP3xkEyp/fXwQioYcjYf6xUji5hfYv0OuQdsrCMKly3LPc05doZsvU/QqXbHPEY9LGlcRmtlljZWXOlCYIkCKu1IkQPbQhKRdcZZ2TDElXUl17HRBALR2nqI7MaI6xul7A6UwNScxnyMS2uiMMW5f4quQSRp5vCZGcF4+SizVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678740; c=relaxed/simple;
	bh=+8pDaSIWcXjuxrL6duvhaDFUkLaSzV/7T4uV42GSflw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OCW1e8QWBjzMQS3CdJTcDugS0hZXoZmQkbAIE79nUMbRCxU0T0yDCjx1XHAO1lby6rWLzUH1tI74lrgxzJnz0NcFd03ODE0E8qT6Qasqo9z3R54IYqpmMzdnc6+Zct8CoBnJTYwfjrPX1ZBsZm/xfa3ZhvBYi8ZtfoRKVFAzUDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2398b8fc6a1811f1aa26b74ffac11d73-20260617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cb92b188-edee-4008-960f-da707e1a66de,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:ee5f5aae7fb843cb12b433e46f0a2182,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2398b8fc6a1811f1aa26b74ffac11d73-20260617
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1400977214; Wed, 17 Jun 2026 14:45:33 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] arm64: early_ioremap fails to map ACPI MADT on 64K pages
Date: Wed, 17 Jun 2026 14:01:10 +0800
Message-Id: <20260617060110.2846851-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,=0D
=0D
I hit an early boot failure on an arm64 system built with 64K pages while=0D
parsing the ACPI MADT.=0D
=0D
The failing system reports:=0D
=0D
  PAGE_SIZE: 64K=0D
  MADT physical address: 0x5a7ae018=0D
  MADT length: 0x32094=0D
=0D
The failure happens when acpi_table_parse_madt() calls into early_memremap(=
)=0D
via __acpi_map_table(). The MADT itself is smaller than 256K, but its=0D
placement causes the early mapping to require 5 64K pages:=0D
=0D
  offset within 64K page =3D 0x5a7ae018 & 0xffff =3D 0xe018=0D
  mapped range           =3D PAGE_ALIGN(0xe018 + 0x32094)=0D
                         =3D PAGE_ALIGN(0x400ac)=0D
                         =3D 0x50000=0D
  nrpages                =3D 0x50000 / 0x10000 =3D 5=0D
=0D
On arm64, NR_FIX_BTMAPS is currently derived from a 256K per-slot budget:=0D
=0D
  #define NR_FIX_BTMAPS        (SZ_256K / PAGE_SIZE)=0D
=0D
So for 64K pages, NR_FIX_BTMAPS is 4. The mapping therefore fails the=0D
early_ioremap() check:=0D
=0D
  if (WARN_ON(nrpages > NR_FIX_BTMAPS))=0D
          return NULL;=0D
=0D
After that, MADT parsing fails and the boot continues with symptoms such as=
:=0D
=0D
  ACPI: APIC not present=0D
  missing boot CPU MPIDR, not enabling secondaries=0D
  Kernel panic - not syncing: No interrupt controller found.=0D
=0D
A firmware change can avoid this by placing MADT so that:=0D
=0D
  (madt_phys & 0xffff) + madt_length <=3D SZ_256K=0D
=0D
However, I do not think ACPI requires such placement, so this looks like a=
=0D
kernel-side robustness issue as well, especially on large arm64 systems whe=
re=0D
MADT can grow with CPU topology.=0D
=0D
One possible kernel-side change is to increase the boot-time mapping budget=
 for=0D
CONFIG_ARM64_64K_PAGES, for example using a 512K per-slot budget only in th=
at=0D
configuration. I do not think this should be applied unconditionally to all=
=0D
page sizes, since the arm64 early fixmap code expects the boot-ioremap rang=
e=0D
to stay within one PMD.=0D
=0D
Has anyone seen similar failures on arm64 64K systems?=0D
=0D
Would maintainers prefer treating this as a firmware layout issue, or would=
=0D
increasing the early_ioremap budget for 64K pages be acceptable?=0D
=0D
Thanks,=0D
Yu Peng=0D
