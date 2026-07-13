Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB342CB14
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950015; cv=none; b=P5HIPyJFgz3/ddGOfknhGRMnj+psOBnVJXR0eAmEtwqWwNlPPpP8vWhcvIP4laCruGFBqjpo3crAlrf0wlRNVuVCztOA/Mb0mnDuR12htEaqMBInG3P3rE/K+apvKkef+jdb2MY7CmGVnerzig8KzpyCr9I4vxzP7r6O8LmBrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950015; c=relaxed/simple;
	bh=JlP+rLDA8xHpeTEciojVMWyDJhCdOHnJPAkAVVALz8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoCFw50uCd4GeiH28IcKVpylhGTSpI561bMsW53r9+NcSKPGCpfSeg0CLimSQFJ3CJGtFzBfdI2h5ON68wTyd1wWpz26DecYv94tQmsF4sKfZYJ5UhPdBWVJOvdMEAB+JR7oer7+M5U9eDqd1zsMFvip7vVdssUMI7GEWDZKjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyZ2Zjnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyZ2Zjnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E1E1F00A3D
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950014;
	bh=nkeMDe+RHMrwa9r8btZmpkxvCSV+QZMyDw6SMzBhwCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dyZ2ZjnkFdwph/EgT3r/Lp9c/B3VxCSiW/bhnk5ASdD7kRps92njq+zGyfiJE3XY/
	 vRU2gClUvsGntmuvmKUR1jhw61gLMOH+Q8xPBBrbBcSuVVzO+pRQabYUiVKIwD45lw
	 LU5hFd8WRvrKNeFGLsCUaclzDPSO5hIgd+Dq09E6Gh+12HkEFuqv3+puSl98rS+YCG
	 GNrbAW5GhvRGmYae1nmhrirpCZGg35llL+GX+8AK2kRTkeNDVnRKm918tI0jESJD1O
	 ZL10IR4T/4E6txGwsLxNQycsDc3RNfl25kM31rBC1Ttfi7T4B7ur8z6iBEHvVyUnKR
	 0wN6EG6owBixA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69ccd6483acso447701a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 06:40:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RppE5RMSu29uUIgM5DuuF8jACIFIzIgltYJuWG+694yGy/zr7mFJoR7utt7tcD+57EwQFShioZrj6WT@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdL5oEUCJrHaXDRiwL3YW40VhIH9RaJl2FmHRhk1guQTMSRy4
	7wDNPNLMaRd7Arjr10wYUhF+GXXxl8W4SWW6xvKUi14Nb3EiIEASoPXtdTnVrsC/WMlF1f0Ea/l
	0ecTq29No7trZ25ZzCSqY4YdQCdux7do=
X-Received: by 2002:a05:6402:4587:b0:698:3b7c:7e4b with SMTP id
 4fb4d7f45d1cf-69c5f1297e0mr3713512a12.33.1783950013153; Mon, 13 Jul 2026
 06:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617074829.2396638-1-maobibo@loongson.cn> <20260713100633.2102708-1-maobibo@loongson.cn>
In-Reply-To: <20260713100633.2102708-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 13 Jul 2026 21:40:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5FGWPnJraY9aYLrLKa5B+eo74eScTFzUeGGXT6f=4FZA@mail.gmail.com>
X-Gm-Features: AUfX_mzMLRFBJvMA4bDQCkBYc-o3ArKsoAgyA4Fx5P5p3gqMqtb6ZmwrgozCfOo
Message-ID: <CAAhV-H5FGWPnJraY9aYLrLKa5B+eo74eScTFzUeGGXT6f=4FZA@mail.gmail.com>
Subject: Re: [PATCH 0/8] ACPI: LoongArch: Add IOVT table support
To: Bibo Mao <maobibo@loongson.cn>
Cc: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixianglai@loongson.cn, 
	loongarch@lists.linux.dev, rafael@kernel.org, saket.dumbre@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Mon, Jul 13, 2026 at 6:14=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> slightly ping.
I think the series can be re-organized as 3 patches:

ACPI: LoongArch: Add acpi_arch_[late]_init()
includes Patch-1/4 in this series roughly.

ACPI: LoongArch: Add IOVT device entry table scanning
includes Patch-3/5/6/7 in this series roughly.

ACPI: LoongArch: Add ACPI_IOVT config options
includes Patch-2/8 in this series roughly.


Huacai

>
> >I/O Virtualization Table is ACPI table for LoongArch IOMMU devices, it
> >is merged on ACPI Spec 6.6, and it can be located at
> >  https://www.loongson.cn/uploads/images/2024110517404135188.LoongArch-I=
O-Virtualization-Table-Specification.pdf
> >
> >Here add IOVT table parsing on LoongArch system, it is for use about
> >LoongArch IOMMU driver in future.
>
