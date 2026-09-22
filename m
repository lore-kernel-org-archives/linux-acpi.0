Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924643B4BD
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076851; cv=none; b=lWzjUxeaiyToKUXx2FVyT8OTmEz4sbm+hQrrD4gSbChLOOujzlqO1b4Wq+PcfPGiISajxUA2WXdXBHG8q/ySNo5C+s1koOJFWJGTwphcOE6l2VZMyQP2GvFqqpZyZmXMfSZ9Ok3uFjOsYwf1vX97yHJqQWiJqKzQh2ygcyEpIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076851; c=relaxed/simple;
	bh=kqrxpOtC9TmFQKJ2F2EA+yKbkatII6M9RfRQ5ETZtSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3Ve8J4iIYRfgeEeVuGOubHn4/+tpcz74sIm5i4/SGnyhhtIQTgr2lUH/7inGQ9H0sNzUxP4JAahUzCrnMpaOYL6q66IoyvWzsdAMBdB0YoixgfQk8vcsRclh6yIp1i9GpZC069uijqzcWoO62HFd+V9Q3OSdUrqVesLMmEkMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZenWE/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZenWE/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62741F008A1
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 11:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790076849;
	bh=m4HWBGO3ZaSoKC9pMZnbu5+IJhOdzdjKInC7dPn7fCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kZenWE/4Z3K7w4LlyOlEQ7T19MhU2++qBUukAxxxqs6jdTCNN4Z2/ehOlzzRKe7Vf
	 h0GFoMDTpXqXUYATgYTVLJVR8BQkrrQWm/udYZhkOyAbbbphC7m5xpTA08fPVMigni
	 Wg9BCWRzA6rL9F8cE2/OX9obybLFmWcOdODPyLg6O3GZXLL4fPDKEXZVD+pBIHhxVg
	 +Bx/m3UX0WTrmAcS78beckTHz+B24cgHlQOP3mK8cr/OesbRfJMj0z6wcBdX0RsrIm
	 qRk71h+LR/KgIt0p5+Iyn1Gil6vKfuIpnfBOTT1G8epH9VNM5d9vPYbtgHRcFoaJxE
	 OCBd+PzqVOfxg==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a60e33d456so22148521fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 04:34:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzcFx+4OricXsGbVBKu8H/LolpI+SxvX2FztE7sI7PTiJ2YMXdZxveo4x18tA3OTw1+bOlw9dr091w+@vger.kernel.org
X-Gm-Message-State: AFuF++kB621Xq3tbEaHrBwbla9VDwDAjXY3Yi/u3UDu43ahPiAzDE2CM
	6JAHKoEJ3f1GjvyXLV5Lq9L5Y1Do9pfYTHp17LwHhBzhydP0nxfTy8HCXyvVYQFA4qG1yY8P1ql
	8/lW9i/7YFxPY7Cn+lWce1HfG8QD+FdM=
X-Received: by 2002:a05:651c:1543:b0:3a3:7680:67f9 with SMTP id
 38308e7fff4ca-3a5fbfa0d6fmr29455801fa.24.1790076848154; Tue, 22 Sep 2026
 04:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920092808.17234-1-i.pavluhin@ya.ru> <20260920092808.17234-2-i.pavluhin@ya.ru>
In-Reply-To: <20260920092808.17234-2-i.pavluhin@ya.ru>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 13:32:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4e7S1fO9h0dT9yFY_eFdp-pyy-tYFw2pe-+G1JATtYw@mail.gmail.com>
X-Gm-Features: AcwNN1WdwKgRfnt2Dcv33bE8YSi3aDk7bQn6dtZyC4cQf4ApRwtBc9jTvaZzyxg
Message-ID: <CAJZ5v0j4e7S1fO9h0dT9yFY_eFdp-pyy-tYFw2pe-+G1JATtYw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI: scan: Add CLSA0102 to the serial bus ignore list
To: Ilya Pavlukhin <i.pavluhin@ya.ru>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 11:28=E2=80=AFAM Ilya Pavlukhin <i.pavluhin@ya.ru> =
wrote:
>
> The Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0) describes the two CS35L41
> amplifiers of its bass speakers as a single ACPI node, HID CLSA0102,
> with two I2cSerialBusV2 resources (0x40 and 0x41), like CLSA0100 and
> CLSA0101 on the Legion 7. Skip the default I2C enumeration so that
> serial-multi-instantiate can create a client for each amplifier.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215632

For the change

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> Assisted-by: Claude Opus 5

Come on.

> Signed-off-by: Ilya Pavlukhin <i.pavluhin@ya.ru>
> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f48715ed8..1d9698df9 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1768,6 +1768,7 @@ static bool acpi_device_enumeration_by_parent(struc=
t acpi_device *device)
>                 /* Non-conforming _HID for Cirrus Logic already released =
*/
>                 {"CLSA0100", },
>                 {"CLSA0101", },
> +               {"CLSA0102", },
>         /*
>          * Some ACPI devs contain SerialBus resources even though they ar=
e not
>          * attached to a serial bus at all.
> --
> 2.43.0
>
