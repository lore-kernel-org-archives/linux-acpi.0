Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314893;
	b=AMH2MnUP7LnVMS8WFrdqsUqCgv7EUkLbnoEOW6+Erl9NKow0/myhbPKRUQThu5dzy5Eu
	 RX5NTfr1AKAQXU0sot138u+00AYwM82Fvs3DZbkQsWizBOmlqpCGW8YJdahCX26HouNGr
	 pAqWqXdQQ79shirQVJhsfkqa4/U2tIwlVXdPY+MUFZkppCzs8a3WlnBCy+S8KXBl5sHas
	 vENoWJsfLmFBUlIm79wW3aLcKvAEpNzQWEJSTBCj2SR31LhC+LnMK0E1ZMYOWPFCTZHsd
	 eGNeBIbQrcWp6LppFCD0k/y0jwOPM1/eb8gbNEqFoF6e1vTuAoTVk9aTCDky8e6xMjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314893;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1Yp4KPwUlz9JWaHLTQ3/Bx+ixssutpKy6VwlgUulV5I=;
	b=mVWMBmyZDUXiRkPjXLkGRUKPFsup4Fk1dFQZbxb4+Krob4oildN2fV7ereKw55txWiCF
	 Ry5sINZoKYWKu1nP+oYjNSpOkokbcH26AsL2sHgkUObQxyoNXENNiVgmzjb17QiTrpQQX
	 HsP4a3uFc9HuwTvlU2xcee4CzxE8XTBqpyMQ9HN7eVxf4VBni7Cl4tSwcxwEL+RqZhxpW
	 qoigiNWrUAEO993voYHSBxTN6OTBxEgTACSc/2i45o7Q4cx5UXwbJpfzOpRfrmo8yv/FH
	 OXgm6oY58uhy0qIDjjUbawin0Zh41aW7y0amdbW85B9IckYcBrCEPmQpPZEYHHcyJXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqcTSQXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42A606A325
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqcTSQXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBAE1F008A1
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314892;
	bh=1Yp4KPwUlz9JWaHLTQ3/Bx+ixssutpKy6VwlgUulV5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hqcTSQXnQgoV6UYYGEbZ0kR/MWjpmsUsYXNNpue8cbyBvenKsyeyLZN5UqgVYNGoT
	 tU59WxMxar3DHcjOT871gyr5z1/c3ti+8ga4dKFsLoqsPvKQmiXB+JITlYwAzsS/wp
	 Jq9kYfvZMVqvjN1qipC2JFfAlnnOYKVQGsA2Daw5SiiY03Vt92cjXgOJCOGIekh+LB
	 eiitzPQhBYA5AJbU4PEh+bT3bLaZ2JFOpPsuQ4xuelFadQxdndimaNwBrC84UoEgUM
	 DtZvS4/reoK4Nmb0iWTkFQsV5TipA8am4ghJzplVv5roNDLrFyyzAK5rDIk49435xW
	 j+gFB54h+HZwA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be47aa555cso1752316e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 04:48:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFiDNkVtF33CLYqhHWadXsBBnZW0l3+rCbo/bJnTuatQZ9q+GxkE/zGTnvQ25J6Ltu4Wuhi/1lWOeHF@vger.kernel.org
X-Gm-Message-State: APuU4Z+wmy7QcbUGLAljeTYlzrvEvvNujApgRYAWeOuNIMrMdeHGZ2/P
	Oiyak/Y7Wnc2/yVFDKVlVTX/tS1LXiEcsyr0cPq/w7+u365f1+FaEkj27loTvn2YrTf8QeDuWt4
	5djSWG4K5hxu7Z5R91j7CDPKE/mY1OeA=
X-Received: by 2002:a05:6512:1306:b0:5bf:b93e:89f4 with SMTP id
 2adb3069b0e04-5c156ecdb97mr835584e87.46.1794314890465; Tue, 10 Nov 2026
 04:48:10 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109183803.2724859-1-jamien@nvidia.com>
In-Reply-To: <20261109183803.2724859-1-jamien@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 13:47:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ib04dv_eL2w41=1KoFLnxqESJkKhPGVQpb1j8XgP_SRg@mail.gmail.com>
X-Gm-Features: AclHuK_3K7ly66VqgF56p7QfwVKq3MI-pKUFtTDql6PCL8hm7uoHRF2WoGGSNCs
Message-ID: <CAJZ5v0ib04dv_eL2w41=1KoFLnxqESJkKhPGVQpb1j8XgP_SRg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] ACPI: sysfs: Expose BDAT data region
To: Jamie Nguyen <jamien@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Punit Agrawal <punitagrawal@gmail.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 7:38=E2=80=AFPM Jamie Nguyen <jamien@nvidia.com> wro=
te:
>
> The BIOS Data ACPI Table (BDAT) points to a firmware data structure that
> carries memory training results and other boot-time data. Patch 2 exposes
> that data as /sys/firmware/acpi/tables/data/BDAT, like the existing BERT
> and CCEL data files.
>
> Patch 1 fixes a leak in the existing data file code, where data_attr is
> not freed if sysfs_create_bin_file() fails. It moves the file creation an=
d
> the cleanup into acpi_table_data_init(), and patch 2 builds on that.
>
> Changes in v4:
> - Patch 2: before mapping the BDATHEAD header, reject an address where
>   the header would wrap around the end of the address space, as
>   acpi_data_show() already does for the data region. Found by Sashiko
>   on v3 [3].
>
> Changes in v3:
> - Rebased onto v7.4-rc1, which includes the two fixes posted during the
>   v2 review [1][2]. No code changes.
> - Dropped the "Assisted-by:" tag as per latest guidelines, though an
>   LLM was used to write, review, and test this series.
>
> Changes in v2:
> - New patch 1, fixing the data_attr leak for BERT and CCEL as well.
> - Patch 2: the BDAT callback only checks the table and sets the address
>   and size of the data, and returns -ENOMEM if mapping the header fails.
>
> v3: https://lore.kernel.org/r/20261109180945.2438349-1-jamien@nvidia.com
> v2: https://lore.kernel.org/r/20261012230632.3574987-1-jamien@nvidia.com
> v1: https://lore.kernel.org/r/20261009232955.866131-1-jamien@nvidia.com
>
> [1]: https://lore.kernel.org/r/20261013180728.957618-1-jamien@nvidia.com
> [2]: https://lore.kernel.org/r/20261013193900.1258808-1-jamien@nvidia.com
> [3]: https://sashiko.dev/#/patchset/20261109180945.2438349-1-jamien%40nvi=
dia.com
>
> Tested on an arm64 server (64K pages), with v2:
>
> - The file matches a /dev/mem dump of the data region taken in the same
>   boot, byte for byte, and decodes with valid CRCs.
> - With lockdown=3Dintegrity, /dev/mem is refused and the file still reads=
.
> - Malformed BDAT tables loaded via initrd table upgrade (test-only change
>   adding BDAT to table_sigs[]) are rejected without creating a file: no
>   "BDATHEAD" signature, size below the header, non-memory address space,
>   zero address, and a table shorter than struct acpi_table_bdat.
> - With a test-only change that makes sysfs_create_bin_file() fail with
>   -EEXIST for one BDAT table, kmemleak reports its data_attr as leaked
>   without patch 1, and the data_attr is freed with patch 1 applied.
>
> Tested in QEMU (x86_64), with the same test-only change:
>
> - BDAT tables with address 0xffffffffffffffff or 0xffffffffffffffe0
>   are rejected without creating a file. With v3, the first of them
>   faults in memcpy_fromio() at boot.
> - A BDAT table pointing at a valid BDATHEAD structure still gets a
>   data file with the expected contents.
>
> Jamie Nguyen (2):
>   ACPI: sysfs: Fix data_attr leak when creating a data file fails
>   ACPI: sysfs: Expose BDAT data region
>
>  Documentation/ABI/testing/sysfs-firmware-acpi | 12 +++
>  drivers/acpi/sysfs.c                          | 74 ++++++++++++++++---
>  2 files changed, 76 insertions(+), 10 deletions(-)
>
>
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> --

Both patches applied as 7.5 material, thanks!
