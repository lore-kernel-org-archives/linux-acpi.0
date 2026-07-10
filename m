Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE44307A7;
	Fri, 10 Jul 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697813; cv=none; b=foQJzwblY5kt0BKFspewKMk/To5DzuhV7A4B3/14sz01IVV0DzSTmihb1/6pGN7Rul/6l+9/2QarIH8+V28F+z64/Cp1iMuoPZIUZ9VIxCUg2a43tV6DUUCV6SV1POdTEZyVmo4j4mrG9InArXNuBBp1RcDVJATLT+2XAOOu0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697813; c=relaxed/simple;
	bh=QHE7TrwK1/EPRNTsNcObJdHCWCzOdgwzRHmO+B9sAWk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PqrcgbVQtAth3/on1Feognbc/2KQWfBz70jGxbDR8ZFBQDV6OSHfrVKnkwHv8BsrNCZ2ftXGGrxtqWedBJoPMo27/z9xM5y7BzlsLa4WM7q4Dd3fPmiCQxbazzTyezSLfXddLFBAI6BJrpFTd5wJD51L+mQJURlWMTh5gTnAJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=iTEri/qD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jvgL3ne5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="iTEri/qD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvgL3ne5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76A401400031;
	Fri, 10 Jul 2026 11:36:46 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jul 2026 11:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783697806;
	 x=1783784206; bh=nhYdXGeJe5gAh50hjRzOWbNJZMG9AcqZrJopHMUdcj0=; b=
	iTEri/qDccUExNNxMdlzv66jVbyzyu21D7QW7cf5pVIkZ15TYMgC8/ezm6eMW9Cb
	4iI39cvokvbd/EsMMecZOy4+Ar7apw7yTYmMO2OjUIaJ93/TNcoKNhXUBvcSBYLB
	7PVQ9dtjf8kMbM44i1xsYZN9fPgHOKpesIxwPX/zcV6Ly5v1isj80LekExrdYuoC
	uGZQM8EbG5sImUwyxWpnTBH97HC20ZRk1yDoDyOd3Cbl4eQAGqgVo1GmtMyoyLds
	k/ZfYUWMKEPIjt+h/Ps/z+e2YKDuTlt9mHZllqPJFcF5c42nPAxJRzW9aSbHi+AK
	PnFvlQ0KY/W4uaBAnUe6Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783697806; x=
	1783784206; bh=nhYdXGeJe5gAh50hjRzOWbNJZMG9AcqZrJopHMUdcj0=; b=j
	vgL3ne5Ch/7Iv3oyr+lHNGdcNjLI8/zUhVAh5G1aAlOsT/aeRPZodqSUmRK6MpNB
	dElQ7mGvnXKUN+jKVFqhkx68/BgMsJPtuqyFx85TVZ6D4r9Y8AZpVMXlOjjGVNQ3
	sO1ri8NahMPo8N8Tqp6Jc0chP3dSW60FyBCVfy+88LO7ybsv+ibYWptI6X/vS2ky
	9kTmC4+wZZz2Ooh5I2M/5bgX+Jw8QpXwJCjYDI+aVH6ZiB/HaWR7zj8k5tloWLA1
	Y2uONOPhiRM2QyN5XnpgXDy9nwjpSf9z59U4RhdRMC0W82M9B3BNGosFTutCcPFd
	heVyw/xMkCXHJZ9p9DF1A==
X-ME-Sender: <xms:jhFRaqCqMKAQqzRmsuPJR3bjYzEXmPNVj_H4lfy0e6osFJbunqcF_g>
    <xme:jhFRavU5E9UyQj8DJpGabAW-XQ-N_bYGNQuhFfUPt9rVqZPivVh07ZQcf6gtrxknY
    s1vxNJP8rc9lviS7aGI9K7rN1znCayCjoxDHRQy1FjS3oVFzmjQxGU>
X-ME-Proxy-Cause: dmFkZTFL66qWE19w9hWoXPVk9zuNcWifoj5WmTQ/PzfAle5697/GKvp8Mu7j8SdOh6gm8z
    pEX7ZmjYuaBUcjNdkrE+7WcKmXOSFM++CpWExQ34iy4t1TxyYpqYTdcjndGRKc0XRWlxz7
    YmX+TQ18CtQPXGXEtcexDw45sRvK4VXg+IJpxgdi6KnJeAan7OA5gJW1WygIAtknNdoEvJ
    jfJNrSc8yvs/s9d13xfx+wPSDFLjrrdxla2936PkJIRfEoJUB1B5TD+3I5RmLRec/KuIlz
    7MYHiIdYU9MKGKltA90hhYx4Y5j+C34gPhipnJ3B/8AVFxjrK9dQdjJqXjcgyGj1aGZ1gJ
    8Qt0HYDnhbdL4nmJkH+ESV5wn3f+4dX7VoMdPiL/s3oH74QurZ01ek9onLIk9dj4mYfEvt
    9fdhRI4qxS5U0mz5iX5MbMpckp85F/St6CY96086FD6lkLhZm4+Ozhp78rLvI9g00wUgWz
    jrfRP4ZyUEZxzkJxd5XldWsPImjxEZEPs5JEy7F9rwuV31EJFY92V4rU/TKT2xxPBnKrvW
    16RH1OfqhIFaqFwpNTRcdo9b2hQGKmndmvanBWOIZV1VItGROGv3uGQGDGXZcrF8LXU7q7
    aEesfSzdPhtLqsZyJCCn6GaK0TM/WRezGnlCgV4ZeyeW5whXZKr/rIymiPSQ
X-ME-Proxy: <xmx:jhFRahPmGxnACWK5Y4h0TSjFM9XurapSpSIaayLB1g2SSoEpTNrj-A>
    <xmx:jhFRas5hFlkCrP9P_DnBdl9fIzMOm-qXtzIZnKc9Abx4n7dS9t8YLg>
    <xmx:jhFRar0AiC4MWAChsRMazJrHzw4fSRrC-uVCA1ToVBEPZIqjnNFVLw>
    <xmx:jhFRatxfP4zYFfNMGrsaZWgzjJfBtogagbm8NKluMUjKUPgBJiWFNA>
    <xmx:jhFRamw6k93M2D4Ey4Wl_B9oWrAqIoQORzVjZHYtWuwJMRXvjgGy99Bk>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 40D052CE0072; Fri, 10 Jul 2026 11:36:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdUxDm4rIt3V
Date: Fri, 10 Jul 2026 11:36:25 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Kate Hsuan" <hpa@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Len Brown" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <630c82a7-438d-4a71-872a-575eb65d4004@app.fastmail.com>
In-Reply-To: <20260710125122.1621877-1-hpa@redhat.com>
References: <20260710125122.1621877-1-hpa@redhat.com>
Subject: Re: [PATCH v2] acpi: battery: Sanitise model_number by dropping unprintable
 characters
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026, at 8:51 AM, Kate Hsuan wrote:
> The battery Embedded Controller (EC) may return the model name with
> trailing unprintable or non-ASCII characters. For example, on some sys=
tems:
>
> $ cat /sys/class/power_supply/BAT0/model_name
> LNV-5B10W51864=EF=BF=BD=EF=BF=BD
>
> If a non-ASCII or an unprintable character is found, it will be replac=
ed
> with '\0' to ensure the model_number is a valid string. If left intact,
> the malformed string prevents udev rules and hwdb working correctly.
>
> Link: https://gitlab.freedesktop.org/upower/upower/-/work_items/345
>
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/acpi/battery.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index f5e0eb299610..4409fb95b988 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -10,6 +10,7 @@
>=20
>  #define pr_fmt(fmt) "ACPI: battery: " fmt
>=20
> +#include <linux/ctype.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/jiffies.h>
> @@ -483,6 +484,15 @@ static int acpi_battery_get_status(struct=20
> acpi_battery *battery)
>  	return 0;
>  }
>=20
> +static void acpi_battery_clean_unprintable_chars(char *str, size_t le=
ngth)
> +{
> +	for (unsigned int i =3D 0; i < length; i++) {
> +		if (!isascii(str[i]) || !isprint(str[i])) {
> +			str[i] =3D '\0';
> +			break;
> +		}
> +	}
> +}
>=20
>  static int extract_battery_info(const int use_bix,
>  			 struct acpi_battery *battery,
> @@ -524,6 +534,10 @@ static int extract_battery_info(const int use_bix,
>  	    battery->capacity_now > battery->full_charge_capacity)
>  		battery->capacity_now =3D battery->full_charge_capacity;
>=20
> +	if (!result)
> +		acpi_battery_clean_unprintable_chars(battery->model_number,
> +					ARRAY_SIZE(battery->model_number));
> +
>  	return result;
>  }
>=20
> --=20
> 2.55.0

Thanks Kate - I know this impacts a few of our platforms and it will be =
great to have this fix.

Implementation looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
