Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AA372B24
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641262; cv=none; b=L0X2j8Yh1Q7EbzVCHKdHL0LfVgsQFQ5XUywEvAMO39sgGh+F1RShDkR2sHkMXvvXWzxtCZfi2Fqjj4HazptN+i3GzbNMZYDMT1ej+22AUkg7Leg8gwVNt0mWclAq1exVlDssPZ+Kh9baroW00AjbPVS2wJ9dBgRqsnU9W145+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641262; c=relaxed/simple;
	bh=zf3PHOx3YsrJy1jv2Tup932rEPnORGH7/ni7JXr9XG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwIVHelMyvwNcPTdsUOO9vtdOjCGiAm9E+T69WMyUNwzJCodLMa4wP/FEho57+dp7nWvq8Gw4SYuQHtFAqVqdHXSBCBbRavzzoVlicL79QtQzxDBGlO/y5Z60NADKFU5pmVADJBROSwRxZl46Oh9soDjr67vmFz+A15x0ux2xSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVQqTcvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVQqTcvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5E91F01560
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641259;
	bh=hnmnrAT1/Nq6CC/GJxl5nP8wiQgScaA7Q98NawARTAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DVQqTcvIqWN5sf6cF7+95P47uxVJQAwv7I5K+wnYOVH+QVoEhdJ1erPV3vCKXBtX2
	 7sRVr8VJwL9b2qVanfnIgxQ0jbFpBIfqrpQUDqeGfqoDa0IKqNRUGwaIWgOotpYQh2
	 RkzqXC/k01g+s24c5uPKi92IW6+Ou7hnGlFeeAp1wnb+lsoO5AhobfgvumHP8G8qvV
	 Cc8Qw7zt+vLUO0K82CBUuWPBxKaKpUMaIEVxXXB5QRva0BZmKOuYveVqBIFOpLbWtk
	 F9yNpFBLq4XlD8T16CWEe6qK69yoe2ZyhzWTagcAv6t9u17yFB2WrF3EOUOHxsn+8g
	 lSIB2aHXghNlA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39db07589caso67938261fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:40:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpLe2acAkA6DuJevEc4icBDigVNla0vUWNFyRY7Qoc45Amdc2z6UtcVtrhQws2UJfBXNlKjVtcr0IU1@vger.kernel.org
X-Gm-Message-State: AOJu0YxI27RKIHHC6RcvrfDStWpFHKIuGy1DuZXCTpsUrJpklvHMc9pM
	h5HLHrTQ8DJLjB2PRaR3onvHQipNDrMsgXF8EfDjI9SC98MJFNnGWfdsrTVUVAz2fxooH73l1jQ
	f0Hr/v42grhDSmKs35U2FiqBBhBY/1mc=
X-Received: by 2002:a05:6512:6206:b0:5ae:b713:f26d with SMTP id
 2adb3069b0e04-5b28fab5346mr3703306e87.58.1784641257422; Tue, 21 Jul 2026
 06:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 15:40:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iu=Z72wUgVyfKtf=_9sOyocoy2J9ETesrRbRtLTUzLEQ@mail.gmail.com>
X-Gm-Features: AUfX_mxChNWPUAmVOZumpgosPDRQ_tGzwID0nlEK7CjpM8a-qhWFOiOi3ewYglI
Message-ID: <CAJZ5v0iu=Z72wUgVyfKtf=_9sOyocoy2J9ETesrRbRtLTUzLEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ACPI: Introduce and use acpi_dev_is_video_device() helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 8:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There are a few users that open code functionality of matching
> a given device against ACPI video device IDs. The current approach
> duplicates ID table along with the matching code. Consolidate it
> under the acpi_dev_is_video_device() helper's hood.
>
> Supposed to go via ACPI tree, please ack.
>
> Changelog v2:
> - rebased on top of the latest code base
> - renamed helper and changed its prototype (Rafael, Mika)
> - added tag (Wolfram)
> - added patch to change scan.c as well
>
> v1: 20220630212819.42958-1-andriy.shevchenko@linux.intel.com
>
> Andy Shevchenko (6):
>   ACPI: utils: Introduce acpi_dev_is_video_device() helper
>   ACPI: scan: Convert to use acpi_dev_is_video_device() helper
>   ACPI: video: Convert to use acpi_dev_is_video_device() helper
>   i2c: acpi: Convert to use acpi_dev_is_video_device() helper
>   PCI/VGA: Convert to use acpi_dev_is_video_device() helper
>   platform/x86: thinkpad_acpi: Convert to use acpi_dev_is_video_device()
>     helper
>
>  drivers/acpi/scan.c                         |  4 +++-
>  drivers/acpi/utils.c                        | 17 +++++++++++++++++
>  drivers/acpi/video_detect.c                 |  7 +------
>  drivers/i2c/i2c-core-acpi.c                 | 15 +++++----------
>  drivers/pci/vgaarb.c                        |  4 +---
>  drivers/platform/x86/lenovo/thinkpad_acpi.c |  2 +-
>  include/linux/acpi.h                        |  1 +
>  7 files changed, 29 insertions(+), 21 deletions(-)
>
> --

Applied as 7.3 material with an adjustment in the first patch, thanks!
