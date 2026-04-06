Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA03845CD
	for <linux-acpi@vger.kernel.org>; Mon,  6 Apr 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487044; cv=none; b=mY8y7ivtJeLy45aJGSWv1rOoEDPIJDcAjtHmd6feSoMcST36mXxfSQdRRZIUJfzs9OgKeRQtqB0pwpr8/O1IYPe5pFwruGFmz4UYPHfH6n8GPLN9K1oJRtNBqqBoFADKENFcvof21SmfBFVTpE7LFWEQ7ClrA+klE8p3DM/I51w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487044; c=relaxed/simple;
	bh=WrxYgl7XA1ThS6PENxnoEuUSrU4ZRekvAxTu6dGvrvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOHgW0aMNY09otkiR1qqupGW0muq/poWQdnaJq1bczpA0rp23kIkVx5mVnlW1n+f6xLN1/rEVatXai1vYXyLL6/18dm9chdQ/sjHYXbiO4Q1J4TXwI//bMoEO7W2tUJKaDMs7UvF4FMdkDuRIIi72MRqCTpeVQPcVkDbLa+0dWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1FsQEVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1FsQEVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AB0C2BCB3
	for <linux-acpi@vger.kernel.org>; Mon,  6 Apr 2026 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775487044;
	bh=WrxYgl7XA1ThS6PENxnoEuUSrU4ZRekvAxTu6dGvrvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u1FsQEVl7Kq9gxyF+zMwpM0Fid8Dtx3datkJQAaeCesUdb/K743VZw3kDfI2xtCTv
	 JBQY5ebJKddyIw5UA5UCRfpdWS0bGphvGt9XHE1k7ENM3V63gmMD+73GMsr8jlACBw
	 rssAdsfulbnuQ7pcSrMhlbNdArf/3lJdnMyhJ/55ipCCn+/TxbHewwgufUEucl4NRw
	 X/XquzTbIncF7PfoxoJ3iQIbqsx3MBc7BQyzFYVDak21U+I4vdpeJ9NshYoLY8Uzr/
	 ymp5y8swdc9VT/AP6obPjD+hz0rEotIkaqZl6fqkzPcbAjjLfsSZjZFz1hcO54RA5T
	 fEJGXxa9g1+rQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-463a0e14abfso2192784b6e.2
        for <linux-acpi@vger.kernel.org>; Mon, 06 Apr 2026 07:50:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIp8smDi8FRZmwggpPe+Kv6Oi6tQtNb3sU+u2lODQofH7mVgvcbetUE3m8M/QKRTZ85o4wkmq90WcX@vger.kernel.org
X-Gm-Message-State: AOJu0YybIxsSxREBkNv0pLopmJ26XNWLhyjLamz9do6u4cu15Pmmb97U
	HyZA294WCD99N/9aZY4mYGdLZ4UKvDzi0CF0AUN371o3DIRXDpGi5+Qsc7slbFDbyVHMxOz+RbI
	p3kmur++JkMhKsTMrtIB4CgHk/8OxdAU=
X-Received: by 2002:a05:6808:1b90:b0:467:de9:3eaf with SMTP id
 5614622812f47-46ef56fb08fmr5823750b6e.10.1775487043256; Mon, 06 Apr 2026
 07:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330094203.38022-1-kaihengf@nvidia.com>
In-Reply-To: <20260330094203.38022-1-kaihengf@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 16:50:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gf9FBpouRcCFXqSa5dR+OtENbr7tA40gSd9+8aLyAr+Q@mail.gmail.com>
X-Gm-Features: AQROBzDpYFk7aorvhyknCAypgjVAHZoSFyCqOeYakgrSTcsYTN5_WmQ_PFmp-o0
Message-ID: <CAJZ5v0gf9FBpouRcCFXqSa5dR+OtENbr7tA40gSd9+8aLyAr+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ACPI: APEI: GHES: Add device-managed notifier
 helper and NVIDIA CPER handler
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: rafael@kernel.org, jonathan.cameron@huawei.com, helgaas@kernel.org, 
	guohanjun@huawei.com, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 11:42=E2=80=AFAM Kai-Heng Feng <kaihengf@nvidia.com=
> wrote:
>
> NVIDIA DGX and HGX platforms provide an ACPI device (NVDA2012) alongside
> the GHES error source. The device does not generate the error records
> itself; its purpose is to allow the vendor CPER handler driver to load
> automatically via ACPI enumeration rather than manual module loading.
>
> The series introduces devm_ghes_register_vendor_record_notifier() helper,
> let HiSilicon PCI driver and new NVIDA GHES driver use the new helper.
>
> Kai-Heng Feng (3):
>   ACPI: APEI: GHES: Add devm_ghes_register_vendor_record_notifier()
>   PCI: hisi: Use devm_ghes_register_vendor_record_notifier()
>   ACPI: APEI: GHES: Add NVIDIA vendor CPER record handler
>
>  MAINTAINERS                              |   6 +
>  drivers/acpi/apei/Kconfig                |  14 +++
>  drivers/acpi/apei/Makefile               |   1 +
>  drivers/acpi/apei/ghes-nvidia.c          | 149 +++++++++++++++++++++++
>  drivers/acpi/apei/ghes.c                 |  18 +++
>  drivers/pci/controller/pcie-hisi-error.c |  12 +-
>  include/acpi/ghes.h                      |  11 ++
>  7 files changed, 200 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/acpi/apei/ghes-nvidia.c
>
> --

Whole series applied as 7.1 material, thanks!
