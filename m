Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48534A4409
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529668; cv=none; b=JMJ0IUCRCsE9Nzc/CR2UkrD7GLWol+OTvSTbtvux48qj3BU1OgQsopwzXpy7OKdsxksmCZpB0XJGj3UruIeJr9shOyf5YBFudgJstpZtw0ZhLkh8ZuCQcreQ3OBSMc3WFl/8evs50/ebpD4BdnE2SVYdbKLOaVrF+t5R7JQNzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529668; c=relaxed/simple;
	bh=nVrfrPt4KLobN61Snu5Z6LOs1cLixcS825sgNCChfBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNQXu+OfyaJgxlC7YPHN/JqADYugmsu1+F76jNvJK9K1VxUZvy9bgOfq3Zs+CaYXNRMnIp3heDj9ru4DZ38F7bTpGQB5mc0CJ8S1xrSxXid+hetvZcxhd3f2NGcg1UgFhFCW3uNCt1VSA6psUgu7OE56/xsYauTfwETaNlWSheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHQizLKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHQizLKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3891F00ADB
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529666;
	bh=q4RCXLVhLLs7Mwj/0CvXfSiT4Z86wgJa21A+w8rfgIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KHQizLKjbvJQczfP1/aYYx2whqaR8AG2ZtA4gH/lq+yHLskyQ1YYMw0TDD9t/EZwN
	 Ugi+w+roa2SINv7MHRt2jQF+jY1rmCUBbiZDVjgqd2VJ6Ons0+XlyYiWEQdLbQWL3x
	 xQQIi9Snn+/lfn0vFEW1zIRUwH/C3227VHIHRVuYx/IMkzXcj/6BA+qdRbhUXFTv+w
	 vpFflSr8UXGnlhyP6WvxY4zHmIJYsBwM8k0GALdSIsOdvYUwizRv6eagLIKkSCuI03
	 crSzzTfsXaesN78QuhXFPIAGQDJ0tHzaGM4+DP3eFLntvGi4tqqQYls6IeMSXqlYDa
	 XWD8h+Bq4akkA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a20f56876eso10172661fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 06:47:46 -0700 (PDT)
X-Gm-Message-State: AFuF++kB7G0VE8l53jCjgjvarvjDBFpOtiKW9kY9BWP3vF1XPwBUSxkU
	fmgDnmltBLCUHJ57R5GxxiZBBy8r6NYqHqHcw9ckkvyhDRCPVjySC4DVntRtlSPNJ1ietfhAi7u
	HrJ/WiXNjG1+tZv9G4YialpIZQdKWjoQ=
X-Received: by 2002:a2e:bc29:0:b0:3a3:2959:a466 with SMTP id
 38308e7fff4ca-3a371ba4a39mr7744911fa.8.1788529664951; Fri, 04 Sep 2026
 06:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829145516.13500-1-edward.blair@gmail.com> <20260829145516.13500-2-edward.blair@gmail.com>
In-Reply-To: <20260829145516.13500-2-edward.blair@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 15:46:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUcRphVQ2ntWQjGvx2z9pdryi8FQh7Z6jRjfdQCXM8vg@mail.gmail.com>
X-Gm-Features: AcwNN1Xi7Qi4-8uon3KTIqKabwEcjlz5ZX_2MMvPVXkgVgAPjW_8bEv1rS_1CL4
Message-ID: <CAJZ5v0jUcRphVQ2ntWQjGvx2z9pdryi8FQh7Z6jRjfdQCXM8vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: scan: do not enumerate MSFT8000 as a serial
 bus slave
To: Edward Blair <edward.blair@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, rafael@kernel.org, 
	lenb@kernel.org, heikki.krogerus@linux.intel.com, 
	mika.westerberg@linux.intel.com, gregkh@linuxfoundation.org, W_Armin@gmx.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 4:55=E2=80=AFPM Edward Blair <edward.blair@gmail.co=
m> wrote:
>
> MSFT8000 represents the Windows Resource Hub Proxy. Its SerialBus
> resources describe connections that Windows exposes to userspace rather
> than a physical peripheral attached to a serial bus.
>
> Treat the device like other ACPI nodes which contain SerialBus resources
> without being serial bus slaves. This keeps the ACPI device present while
> preventing the resources from being instantiated as I2C, SPI or serdev
> clients and conflicting with the actual devices.
>
> Suggested-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Edward Blair <edward.blair@gmail.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

and please route it as needed or let me know if you want me to pick it up.

Thanks!

> ---
>  drivers/acpi/scan.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7dcf78419..608527cda 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1770,6 +1770,11 @@ static bool acpi_device_enumeration_by_parent(stru=
ct acpi_device *device)
>          * attached to a serial bus at all.
>          */
>                 {"MSHW0028", },
> +       /*
> +        * MSFT8000 is a Windows Resource Hub Proxy device. Its SerialBus
> +        * resources grant userspace access and do not describe a slave.
> +        */
> +               {"MSFT8000", },
>         /*
>          * HIDs of device with an UartSerialBusV2 resource for which user=
space
>          * expects a regular tty cdev to be created (instead of the in ke=
rnel
> --
> 2.55.0
>
