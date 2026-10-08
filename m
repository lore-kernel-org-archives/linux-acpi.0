Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFA378822
	for <linux-acpi@vger.kernel.org>; Thu,  8 Oct 2026 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485425; cv=pass; b=EBN6Bw/SLxyrskyFcIobub2E0n0JN9Lag6eHpppuxZ34dmlA35e/ugrECTwP2gBvEej+0qhD+BxetXytmcCZeTziOV/aVTUEHpI5kDq9duh0VTtkqvaRu3GzyFJVUJC0l5oEiNDSBleFeL/GsaNDPlii8rvj8yo1iF5SxBaAZtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485425; c=relaxed/simple;
	bh=lr8M7fmxQx+oenGID2VdP5yfHKsvKNwWZtz8MlvHV6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvfYs53h+kCB0HfSER9Z9p4tx9zeZC74eN1Lx2NbCp/xqfxtFqNh9WY4zcAIlhc7J0TmLCAfyGaaY/Q6XeRye+7Oc2w3+OSOJ5TCtoqMHUvqCvRxkxmhr3IuE7+fsfmTB5aNf71H17zvji50Kw1xhCSiuXqcbVkGPPDK1o2vKEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omizmiq5; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omizmiq5"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82109f51565so1610378a34.2
        for <linux-acpi@vger.kernel.org>; Thu, 08 Oct 2026 11:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791485420; cv=none;
        d=google.com; s=arc-20260327;
        b=rDpjT1dk8QkmJXDhXr40wWJF9V5wYH+tDPLxUguGbRuN2X5DtnochCoVuYrWDqqAUW
         ZQuLYqz1vQYRjYmUzysTCtmwTheVy8AYuBYcxxeOzBp1RaKYvgN2i9feBqPBdSQ4xe2h
         Xbrf0T4ljO6PsSkTzF5qgwBuOWmSe7UR6uJ0LXl5mW/Of4JenhSX4udRbvaHVrBqRa1a
         ugvI6+FqlrU0IPt8ZicydFioMLlaopDswR2m/Xgb7Uq+aYWH15kL+HcI5Zz2gtlAYGrp
         +2W4WglBON30ogWNfoGKYB9gPlGP0ziU/vwgcHIq1JJV0OMFDIerCAVq5EFPYWWpQgdk
         XJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HUuHUTe3yEqV1MPJyew4xZgwaSUycY+L6akjTIcM0eo=;
        fh=Bw8EacQd2CgAZsxDBbVF9xnP8ZOl/H4yrIUCO6DDCGE=;
        b=X7OHPgkmoYYKADneLfoFs6Q/+6X2G3+VFu8KHMhOrdmPP8r8MKu64KCEYKD/oO/z+U
         MqZPfZK5Kj6x9YLRG79WLghZCYJQG6SW/paEgzVEduzF44K4LGzyr62Xfg0Y8C8F8WLq
         hccqd90Q3TmIcqBh1mkbZ6ZJfydrhxDRWdgWSLmh1f2Y3KNi599oPHCS6/DVbPIw1Czk
         t2Zh+AR4wTOHBEv8A4OBjYDYT9I9vZZKGzV4f0pWft6bacLIT3MEl94uTYKV4R7MSMpo
         ODcoESDs2TnmeOM84LRn26gqstHhm8BAO36Si/8vA6oX9HjXu9KR6+ZSQ7crRosRiOfC
         4IdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791485420; x=1792090220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HUuHUTe3yEqV1MPJyew4xZgwaSUycY+L6akjTIcM0eo=;
        b=Omizmiq5kZD2GJIYcjN5Z1UlkdIXv+r+rTOY1/VbtxY4WeYAI5gkIPlvbvki1uJfcU
         Z6h/3z2ll+vxeJ26AFdNi4EnbUF9DMHnopFSs9KsZIi/UpwN6chmQsGOgHx1BkLUz61t
         ZTKZQWZYRIQQb0EDPAAcCKbvrHJEL8dzIbREJ21QUC+HbRkEhsQnvvNIUxJLbaWzuqEv
         KQ9UA6TKp7GoVEwezvh4U+lPnKeWTYBsQW9VdGXTiGHUZIFh2b1JHPZT0SoS7mKG+AyN
         qKgqQsFh9AlcsPTK8ukKIuR7qQbKdBM3XsItH0z0cPag+NfcHjW0IYsFMMzLJNhhBtJZ
         SDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791485420; x=1792090220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUuHUTe3yEqV1MPJyew4xZgwaSUycY+L6akjTIcM0eo=;
        b=JemJ7+GjZk+FltxniVlGQyfwpLuiH/Omz2JUxlxblIdJ7O2vSOiRT0eO87DumOMl9w
         u80CZNGtAkeYhXl01ejItAQ8FIDiI43pugY5C/unzF8cGSJfvJCuVwsOWcPWBmY7gyxv
         LMd75NMutmnckgTQdUyOfu+OcS9rfDQAbSWARiAZF+3fBhFM5zHyBddHzUT5KVlECWmj
         itIClSW7F8aQYtteALxPugk4hOIWx0C3tsOMsmWTniT2pQDx5Psvh83zHZvnentynQ4E
         YVpACka83VeKklfcNS410OiLlPOxzMr8kvQ/h+IRbYLobkZjQ/npU+6eZ9oQDIr4ecSq
         T8pw==
X-Forwarded-Encrypted: i=1; AKwUvByWtApOOvjDgqDgNtyctgJyVK5J1wLzpDwP6ocWu9ptFj/tv4hkYnWWFMLUnIOEbSYHozc/9YyYxjb7@vger.kernel.org
X-Gm-Message-State: AFuF++n1xF9vax21oIdUSz3Yguv8aRNhs8KyiTNNwGT1GI1m771xI8kj
	joECTOfA9eUA//aBUwfgbw3rrnsRTvbpYzbVgP1XwurNprzBDNYm5HRryTN3/41lSngHR/snYKA
	+i54eHq6ny4mcRWa7P84e/0rEvpk1BSw=
X-Gm-Gg: AYBFou2LAekhyOlrZaBmBy0nu8BtH/+NlK9y2PzOPrA1kSiona2cNJ1nVxhMWGuzKg+
	MeG8qIyJZ9zEpGPEhTt+KnxD1e/rVqvqHUzQTM2PXF50jp47RbIDOpxNfnobZaFfsWaCCHZGaW3
	pqytparvV5hLqp8uHKQoSTdPUbsJHHa4bKcS/dAdllcHBRgcXcn8+ucdVjKEmJutQe4cC0paQm4
	gMd1Wq0HKGiWzfLUfnh3aAnZFLkFTcTloxZakHv5pM2ex4x4BWEpjyaZ0F88S5DdneQ7hmyI9+i
	5ohhtR62ZEdhTGCPSkyIuRI6Q88FLJeePEDQenUNtW/xaRKPd545sEY=
X-Received: by 2002:a05:6830:398e:b0:829:2af1:a07e with SMTP id
 46e09a7af769-82acce646e4mr6427817a34.3.1791485419594; Thu, 08 Oct 2026
 11:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-2-shijujose2008@gmail.com> <20261005235021.GBasQ3vXTivT3NLbBq@fat_crate.local>
 <asU7svV8g2Hb5DZl@hu-ashoraj-lv.qualcomm.com> <20261008030603.GAascImzt4cv8Gz49p@fat_crate.local>
 <CAG4KcRLhN9=6xeT4qfqKLFdukiZLUc7akGcWwXJUU1-qrfxTUQ@mail.gmail.com> <20261008174114.GAasfVutvsmAk8JGsD@fat_crate.local>
In-Reply-To: <20261008174114.GAasfVutvsmAk8JGsD@fat_crate.local>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Thu, 8 Oct 2026 19:50:07 +0100
X-Gm-Features: AclHuK-7nYIEHIpgx3dw55yERdZIxrZ2s_no432HghoTK3RqssmmaR0vXdDXvqQ
Message-ID: <CAG4KcRLx69BK+aw+exUzPe+BW8exFM2LLvN9pEr-+1BoGVhFXg@mail.gmail.com>
Subject: Re: [PATCH v23 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature table
To: Borislav Petkov <bp@alien8.de>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, rafael@kernel.org, 
	akpm@linux-foundation.org, rppt@kernel.org, dferguson@amperecomputing.com, 
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org, 
	Yazen.Ghannam@amd.com, mchehab@kernel.org, jic23@kernel.org, 
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com, ashoraj@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 6:42=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> Shiju,
>
> On Thu, Oct 08, 2026 at 08:18:14AM +0100, Shiju Jose wrote:
> > Thanks Ashok for reporting this issue.
> >
> > I debug this. nows_txdone used to set before requesting the channel
> > until v16 and was changed in v17
> > following a review comment by claude.
> > Found this issue occurs when txdone_poll set and  setting nows_txdone
> > before requesting the channel, solved.
> > In my test setup,  I missed this issue, because txdone_irq was set in
> > pcc_mbox_probe()
> > with the acpi pcct flag set to ACPI_PCCT_DOORBELL by the firmware.
>
> What?!? I can barely understand what you're writing here.
>
> And tell me, how many times do I need to remind you not to top-post on pu=
blic
> mailing lists?
>
> Geez.

Sorry. I meant the issue occurred when setting the PCC signalling mode
as polling for the RAS2 PCC
(In include/acpi/actbl2.h struct acpi_table_pcct: flags).

Regards,
Shiju
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
