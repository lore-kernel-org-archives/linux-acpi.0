Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251502;
	b=Zq6mRr3Dc3qh4Ww+HNrXABAF9af69lsh4yyFfQur3S7reu/O/2aBJZgAu+nqY47HHIQ8
	 6/YdCpcSYxjpPkCvWZZMpXQCqvepOL5JoUiTIBKmmYwg1abjdcF2cxVRxxp2TwGdkKDvb
	 N1/nQ9DBcm9i4J5brbYbKTjJZQeqWFvr2RA7dcIcueKSI9hCxdsYcLLqQgRs1Q5DfEm3K
	 qMGxkThADS7HnQpjaYyNXnReDdC4lbI8eWrGegpgwIZwH7AssnEn2+bAoTHrM/hN8dhD2
	 5ogAV5jNatfRt1QuMmY1cEgEA3EcvOYEnoUI/zNukVGSoHeWMBzhIkdbjH4Dlq+zoKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251502;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DJss7vF018jxE3CgpbZ29VThuXk5wnx614xdus0Glzc=;
	b=nKU2g96iGXtQHpbIyCwP9GhQ4hic4PL2EkUZ/kE0V1QhKxxJO0/hJzOYdHTrL/wa0iJn
	 3GsZfasLJqkSGu67t3C6TPLKuiFAAVK+VFRtu05F6sK3s5eC4x59kjZfyxb25WWRcmV/X
	 vCqMpLfKEM3JJL6QNprttaBq4mZgfR4qtfp+wQoiw0mvd1syAHVAdLBBmGjzdD2gOOsLP
	 QFQ09Hi5Rz9W8hNhugSz2s3zUZrlCLQGBt4d/jQjjIaT5AHQjER8jYax5/osdXVgcwJC8
	 y8mLt89T62TCp64V1dAUsjW6UtIuzFCDZ+WPzlTHIUNjOos26bAVYSNhfhwuuNw4nQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4Sv859R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58858606A321
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4Sv859R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352761F0089F
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251502;
	bh=DJss7vF018jxE3CgpbZ29VThuXk5wnx614xdus0Glzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f4Sv859R4DrgEnPEvT/I04GNwFNGnCcO3NcpXc8kUtbt60Qhv1icbO0TP4o8vvczu
	 k2XqYObS6IP2A3mXna8+uvL4qx7UhzDFQiWCEpkAzzpM+4H01Pe4cLIpMTwWQugkDc
	 oei0/01C+5zeWS8Ag/LeQ99C+0/mBpZFWnqA3591x3xpNVj6Vg/CzAXm3J84jSA3Pf
	 gv3t39V8v1hzyKeDpn9kvZJCW7TavFEuz8isvqdzvgL6uCxBFXjPLarLAq0KNIsOvn
	 a1pwwpcgBaYLEuSjJjn/an4gksWOqvQUQVrfbCwM+EZfG95qOw8ASe46dfmC26THOk
	 APBe1L6mSTWSA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c146cf35ceso1185686e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 11:11:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHfj5Gmoo7lFzYo5UVGox+fxVE5/7tZtU0LbJbo02kMSi4Jte9f2ornJ8OTG+P8oi84D39dAZGGMmfh@vger.kernel.org
X-Gm-Message-State: APuU4Z+4am4fZHz7cHQaaW+SfW2odlO2PEkGOBr7LCwYPWwyIkcI0f9J
	swId1iDSVcmOwmWOqEEVNLVJJRlyxyD6SyNY9pn0bXqbdwMrdZN2YMERrPj3AcreWXruhpAluRs
	YVTANv2AnFWooRkcXe4xV+9LMsP7HJno=
X-Received: by 2002:a05:6512:1286:b0:5c1:4bb4:a6bb with SMTP id
 2adb3069b0e04-5c156ea28ecmr81403e87.36.1794251500588; Mon, 09 Nov 2026
 11:11:40 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016141440.2794000-1-yaojiale02@163.com> <7192d240.1879.1a148c7d925.Coremail.19888972804@163.com>
In-Reply-To: <7192d240.1879.1a148c7d925.Coremail.19888972804@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 20:11:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_oa2zguxw=5E5w9Jhc-m2cnbOfvFdPJoXerBhFmeh5Q@mail.gmail.com>
X-Gm-Features: AclHuK_BUF-fAHbf6jyj3Z7UKdsM4Q5zT5fl2jVdiFMvd9z0XP0bfa11sJk1W4Q
Message-ID: <CAJZ5v0h_oa2zguxw=5E5w9Jhc-m2cnbOfvFdPJoXerBhFmeh5Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: validate CPU mapping entries
To: jiale yao <19888972804@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 9:33=E2=80=AFAM jiale yao <19888972804@163.com> wro=
te:
>
> At 2026-10-16 22:14:40, "Jiale Yao" <yaojiale02@163.com> wrote:
> >CPU physical ID lookup walks MADT subtables directly and also accepts
> >records returned by _MAT. Both paths can pass a truncated typed record
> >to a CPU-specific mapper, and the MADT walker can be stalled or moved
> >outside the table by an invalid length.
> >
> >Validate generic record bounds and the minimum size required by each
> >supported CPU record before dispatching it on both provider paths.
> >
>
> Fixes: 78ed8bd2944b ("ACPI: processor: move acpi_get_cpuid into processor=
_core.c")

So please resend.

Also, is it possible that some systems currently in the field will not
pass this new validation and stop booting as a result?

> >Signed-off-by: Jiale Yao <yaojiale02@163.com>
> >---
> > drivers/acpi/processor_core.c | 48 ++++++++++++++++++++++++++++++++++-
> > 1 file changed, 47 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core=
.c
> >index 3bf076c150fa..4d5ff53f27ab 100644
> >--- a/drivers/acpi/processor_core.c
> >+++ b/drivers/acpi/processor_core.c
> >@@ -157,6 +157,47 @@ static int map_core_pic_id(struct acpi_subtable_hea=
der *entry,
> >       return -EINVAL;
> > }
> >
> >+static bool madt_cpu_entry_is_valid(struct acpi_subtable_header *entry,
> >+                                  unsigned long end)
> >+{
> >+      unsigned long start =3D (unsigned long)entry;
> >+      size_t length, min_length;
> >+
> >+      if (start >=3D end || end - start < sizeof(*entry))
> >+              return false;
> >+
> >+      length =3D entry->length;
> >+      if (length < sizeof(*entry) || length > end - start)
> >+              return false;
> >+
> >+      switch (entry->type) {
> >+      case ACPI_MADT_TYPE_LOCAL_APIC:
> >+              min_length =3D sizeof(struct acpi_madt_local_apic);
> >+              break;
> >+      case ACPI_MADT_TYPE_LOCAL_X2APIC:
> >+              min_length =3D sizeof(struct acpi_madt_local_x2apic);
> >+              break;
> >+      case ACPI_MADT_TYPE_LOCAL_SAPIC:
> >+              min_length =3D sizeof(struct acpi_madt_local_sapic);
> >+              break;
> >+      case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
> >+              min_length =3D offsetofend(struct acpi_madt_generic_inter=
rupt,
> >+                                       arm_mpidr);
> >+              break;
> >+      case ACPI_MADT_TYPE_RINTC:
> >+              min_length =3D offsetofend(struct acpi_madt_rintc, uid);
> >+              break;
> >+      case ACPI_MADT_TYPE_CORE_PIC:
> >+              min_length =3D sizeof(struct acpi_madt_core_pic);
> >+              break;
> >+      default:
> >+              min_length =3D sizeof(*entry);
> >+              break;
> >+      }
> >+
> >+      return length >=3D min_length;
> >+}
> >+
> > static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
> >                                  int type, u32 acpi_id)
> > {
> >@@ -172,7 +213,8 @@ static phys_cpuid_t map_madt_entry(struct acpi_table=
_madt *madt,
> >       /* Parse all entries looking for a match. */
> >
> >       entry +=3D sizeof(struct acpi_table_madt);
> >-      while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
> >+      while (madt_cpu_entry_is_valid((struct acpi_subtable_header *)ent=
ry,
> >+                                     madt_end)) {
> >               struct acpi_subtable_header *header =3D
> >                       (struct acpi_subtable_header *)entry;
> >               if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_APIC) {
> >@@ -251,6 +293,10 @@ static phys_cpuid_t map_mat_entry(acpi_handle handl=
e, int type, u32 acpi_id)
> >       }
> >
> >       header =3D (struct acpi_subtable_header *)obj->buffer.pointer;
> >+      if (!madt_cpu_entry_is_valid(header,
> >+                      (unsigned long)header + obj->buffer.length))
> >+              goto exit;
> >+
> >       if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_APIC)
> >               map_lapic_id(header, acpi_id, &phys_id);
> >       else if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_SAPIC)
> >--
> >2.34.1
