Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641239CD0C
	for <linux-acpi@vger.kernel.org>; Thu,  8 Oct 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482315; cv=pass; b=VpVOKpU+mYiOawD5DTku9A07BwFk4E2MkrwI7UA3aRz4KVkcT1uQAIrOrbYDCduudA78DkCKQZonGwlnyoTIALAEfrgj+wtO244/3VBsswHQnj7CJpbNVuAUfvAyalR8Oqtkf1/GHp9vJo6Z9oAG0dj58revCgBTADpnP9I1uQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482315; c=relaxed/simple;
	bh=+PQHOWhS6Z/YJqJfeCNpqWI3Cf2C66ZMrvU1PsYpWWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzzQl1v1I6gVwUSkBvNcUFFDUt8qigYoN1atsHUcNuFINg9H8+eEeADPnU0kNirE9zexwxmQMJsJz3YWAM4eIxadvlrg+CTEVRlI3PhVoLcA+Z6k15EtEGnQwy/MEonzAhQ4sk87VG7uHmZHDOSvvWpLm4tVWi4cAAtz7tbzJ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak6PV6fo; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak6PV6fo"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8249c775215so1963412a34.3
        for <linux-acpi@vger.kernel.org>; Thu, 08 Oct 2026 10:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791482311; cv=none;
        d=google.com; s=arc-20260327;
        b=KKiyBsvqdSD4tyjsq2EXY7BFdPePjs6Gzami7P9Mod2VLoVlq8HXk55+622NmHSbWo
         f8VjHgExxB4b8jMYtCQxu2X/J/SyfbWZXxF55ZwXh2we8TrGB+ih4sqVk+SWe/TeOGho
         z2Icg2hbpYVWsVSUcbx8d/NR1YN/hH5sOIg9+S7llgCSYGYWNgIf/MnaMh8RTucpVtb6
         Y8AXjCDjh3D1ZqgotJZOr8Ng2euzjumchAgsWx3rqAuWYmKjVj4vmB8XxpoE63HIyM41
         CjV90PWDRhe7McRNfpFrTgSh9/iKqFZOrx1TCfOMXnEwALCo6+3vCObQ73fRNpZO3zB0
         Mo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t87G03YJP+Jtnvd/a8HSoKeiu6kRlnnSEIlqeg1Cd6Q=;
        fh=WE1pxB/JQoBsi5F6T/J3t6Sqar9Zgs+kYjbK1mztDHA=;
        b=TBswKHkztkNvw3hQ3MUoSDym6Hi3lbDMb5iqPu+rySXkjFWsfkJHw8G7+NNfTEMQeo
         G30Vnb+09JLZ58xG5lX+HYUDE4QcHymAurBmb2loAiG1eI6mveh9uKrJZpb4/4Xw/DE9
         aTu1jyTgZxymAJaveqe3xf0g9rypLNo/45F/KtInrjJO8m2dmI/CptTHn2J4MljOhB+A
         SE/WQtEVNHhUrmdsYeulGH+Yrkp+awOSUa2NHq/A6GUf5/kjyFne3suB8rnwtq2EH80o
         61CNve6WBIP0+1bT8ZjzJX7SIcD+nWWIREZEh86NI5WJYNgpLFKzfSwpAH+eY8HoP1Aa
         dulQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791482311; x=1792087111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t87G03YJP+Jtnvd/a8HSoKeiu6kRlnnSEIlqeg1Cd6Q=;
        b=ak6PV6foUHSdBw/tqnd94Q+TnEZpCxhtlK6/OZct3xv5qb47SaSigWejmO2nLb5gKn
         3r6+beZ/nClYfGOgqGKeV4avpRwSWxevx1YSdvz/m4lKRmS3ebIuDs0gg8FFNXt3Tiiv
         MOjvGwVWhQvBEJ/tOksOTdkApWeOyO6+z5hnMMQVYTFaIv74DdNWGU13W5+3CkusTe/N
         /qh1feV14x5hom/T6x/kpUA7E1wxPwBPM6gqf2/58y+UyZCNL6+6UKdBMVuPaf2R3m9f
         nKepwVqktpe6Gk4EavokJ8X26EbDp8OHgwCkrvirnE8kbtf8lxEGpQoybKnrse2O8Z7F
         +zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791482311; x=1792087111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t87G03YJP+Jtnvd/a8HSoKeiu6kRlnnSEIlqeg1Cd6Q=;
        b=USUejwgfEcOXf0BgpOT63wWwIeONio0LbY84u6wsWj79acN6V0t+K2GoBlJzVS0Lg5
         n63128ICKVkL+7tEW9YbKhLLkOwaH7q7CoDUEG1/VIyKZqVlMhVj8zeGnuKJXrSDA4Sd
         C2TJmp7jtoe2EC28LqNpCdt1VLbR0tm/l4+rdn+ScnX64GIjGlW+LbFigRh3Vj0wUWV4
         Kj3K6OstlgeWhMFs7Xp0bde43wFC6f0CLfgcXriCf6pNe234RiagH8zL8w0c5LVhkfQu
         zmWCnWoE7gVDtccj4858J654NumS5OgSY5xQ1RUYNRf74hd9kzQgwVb6aSDbTPVMG616
         E9wg==
X-Forwarded-Encrypted: i=1; AKwUvBzkheLY3jnHI1QfdP0+N3SACTrpTzo/dMLeE8N1DmV3ab1NR2L8gABj9hIUCFsFj19L9GFdT66hTTFZ@vger.kernel.org
X-Gm-Message-State: AFuF++mMrzJtsuQxsk6lvFQjNHSmSjJwk+mTajEcqA01RTyw2kjaUnyp
	aPWY/1F8ZTiNSs/nCuuoAhdvSUS6oUBpV+OGA33nXvGc5+Ct6/R0LQt93e12UWSbMXNHAOGUjuZ
	ZcErRonOdqQ+hEQ3VHJavhRIdenqBUhU=
X-Gm-Gg: AYBFou09sFKnNr2oMAN8LrMAZLH+OcahZD9BzhWA4JbTBvuryji8oCVPqKXS7YTE3kx
	JsBsq4VnMtGJgWcnsUgPIJJ8OpqFY5NTh7BO0RsfHRXMp3+9QjbKUAhWP+YgYi9bq1hHn5LaG04
	SVWUhDO83c43bv5pR73aNDR2Lr4GIwGHFOJFQJMJ2dXtJLSRQAiojeSVaBGefsFKBVuizX/5KZ8
	PC0Ipd5k8jM+umbMWwiJ3j3zNsvMBmcKbr31UuW+/f3OottPgX3iw5Sv+3vLQA2OpTdVhZFXngs
	9vHsMh/t/bzqKiMNYrqVrNhs+iPfR8wLpk9IubVVs/2GXRB3FOlWuGs=
X-Received: by 2002:a05:6830:6ad8:b0:804:d4b0:a36 with SMTP id
 46e09a7af769-82ad06ca857mr5680753a34.27.1791482311350; Thu, 08 Oct 2026
 10:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726212812.89266-1-shijujose2008@gmail.com> <ac2a8f1c-295e-4791-b233-cc8549430e07@oss.qualcomm.com>
In-Reply-To: <ac2a8f1c-295e-4791-b233-cc8549430e07@oss.qualcomm.com>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Thu, 8 Oct 2026 18:58:18 +0100
X-Gm-Features: AclHuK8_IR-ipfDqjHPYRkAYBCIcO3XOLSiPBhuHH-voREme2zuF2x6jh8EHKeg
Message-ID: <CAG4KcRLk3FdV1uKHhiTtr8uAuEB+Z=rBnrHgzPwPxQRsLyo-CA@mail.gmail.com>
Subject: Re: [PATCH v23 0/2] ACPI: Add support for ACPI RAS2 feature table
To: Sathvika Vasireddy <sathvika.vasireddy@oss.qualcomm.com>
Cc: rafael@kernel.org, bp@alien8.de, akpm@linux-foundation.org, 
	rppt@kernel.org, dferguson@amperecomputing.com, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com, 
	mchehab@kernel.org, ashok.raj@oss.qualcomm.com, jic23@kernel.org, 
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sathvika,

Thanks for verifying and confirming.

Hi Boris,

Can you merge this change or Do you want me to send another version
with the change?

Thanks,
Shiju


On Thu, Oct 8, 2026 at 8:38=E2=80=AFAM Sathvika Vasireddy
<sathvika.vasireddy@oss.qualcomm.com> wrote:
>
> Hi Shiju,
>
> On 27-07-2026 02:58, shijujose2008@gmail.com wrote:
> > From: Shiju Jose <shijujose2008@gmail.com>
> >
> > Add support for ACPI RAS2 feature table (RAS2) defined in the
> > ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
> > scrubbing feature.
> >
> > ACPI RAS2 patches were part of the EDAC series [1].
> >
> > The code is based on linux.git v7.2-rc2 [2].
> >
> > 1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@h=
uawei.com/
> > 2. https://github.com/torvalds/linux.git
> >
>
> [snip]
>
> > Shiju Jose (2):
> >    ACPI:RAS2: Add driver for the ACPI RAS2 feature table
> >    ras: mem: Add ACPI RAS2 memory driver
> >
> >   Documentation/ABI/testing/sysfs-edac-scrub |  20 +-
> >   Documentation/edac/scrub.rst               |  70 +++
> >   drivers/acpi/Kconfig                       |  11 +
> >   drivers/acpi/Makefile                      |   1 +
> >   drivers/acpi/bus.c                         |   3 +
> >   drivers/acpi/ras2.c                        | 509 +++++++++++++++++
> >   drivers/edac/scrub.c                       |  12 +
> >   drivers/ras/Kconfig                        |  13 +
> >   drivers/ras/Makefile                       |   1 +
> >   drivers/ras/acpi_ras2.c                    | 624 ++++++++++++++++++++=
+
> >   include/acpi/ras2.h                        |  86 +++
> >   include/linux/edac.h                       |   4 +
> >   12 files changed, 1349 insertions(+), 5 deletions(-)
> >   create mode 100644 drivers/acpi/ras2.c
> >   create mode 100644 drivers/ras/acpi_ras2.c
> >   create mode 100644 include/acpi/ras2.h
> >
>
> I applied the v23 RAS2 series on top of Linux v7.2-rc2 and tested it.
>
> Verified ACPI RAS2 and PCCT discovery, PCC mailbox registration, EDAC
> scrub device creation, scrub capability sysfs attributes, background
> scrub control, and demand scrub operations.
>
> I also reproduced the PCC TX ticker issue reported during Ashok's review
> of patch 1/2 and confirmed that the proposed fix (initializing
> mbox_client.knows_txdone before pcc_mbox_request_channel()) resolves it.
>
> Without the proposed fix:
>
>    # d=3D/sys/bus/edac/devices/acpi_ras_mem0/scrub0
>    # echo 0x8000000000 > $d/addr
>    # echo 0x1000000 > $d/size
>    # echo 1 > $d/enable_demand
>
>    [125.577700] PCCT PCCT: Client can't run the TX ticker
>    [125.577704] PCCT PCCT: Client can't run the TX ticker
>
> After applying the proposed fix and repeating the same test, the PCC TX
> ticker error was no longer observed.
>
> Based on the above testing of the complete v23 series together with the
> proposed PCC fix, feel free to add:
>
> Tested-by: Sathvika Vasireddy <sathvika.vasireddy@oss.qualcomm.com>
>
> Thanks,
> Sathvika
>
