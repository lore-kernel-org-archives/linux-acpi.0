Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162037B002
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267982; cv=none; b=qzXrKrlrMOTLhgOAowgx2Np5+TYSu2qx7jfoHA8tU56M5WHSfAkkJ0g8k0YSrzh7BWsSE13KM1P70R6BxBYMnyisFHXUPJw5Ef2LTsNmJ+h1xgDHTHHlwTVldoghumyT8AcSJCU4aV2PRYxCTpeQWVsI759wlYZ+t+snNWN0Oog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267982; c=relaxed/simple;
	bh=zcjVkFYefsLMo6GxyToLR7NRNRr/X8RrBP3ifnomebE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAK53OCS6IsvwHZL5vg7kzplIC1cMhrB3x8MFdrkVbmn494g2JG0bzF+YuflTdm8wffUrAbQZV5Q27+ck3U0Fx1TO37KUhfzM3HfX55IEKNl+ZbE2itBFyXQTOLuV5RvGA3iNer5nRUOtlrhZTOpnL+wf2UEASUqO1OQree7kg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRPM9TAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRPM9TAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83B9C2BCF5
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778267981;
	bh=zcjVkFYefsLMo6GxyToLR7NRNRr/X8RrBP3ifnomebE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VRPM9TAowG+G2KAHJMHr42lsLQlHuiu3TnwZqO5LdccMNjjR7MbNSKgMCuXwtTrMz
	 19Q1pEOPzEqGJftlVpqOmwdPwQqQUFmsrqYVRnJNjkzDfyu3VTzvaSzbaozSJwGHU/
	 sdC1+07o5F8wAPCOo3JSpoub1WQuxpHOh2MXjbGi8RjMZ1+uzXaRlzvrDuc0Ju92ut
	 taScqbmeo5nRLGigA4xjeb1M3rbAO3yWw3R86RC7wNG9nCa3yd2/ZMOuO6mb781A7Z
	 QmOd+Z7KdXYVpa/wc/SaOTAp8zlPytXZzOCATi+dhxYACAL89wh3n788hzrTjDPo6Z
	 P+b+z26pf2qCw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a525aedb24so2302443e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2026 12:19:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8vbUNipzbj1s5dOseYRMA5Vq0z3w0EKHYI2czYFwG//WXAWC/5c2Rx4dqdTq4f84U6CByoT1aZFy7a@vger.kernel.org
X-Gm-Message-State: AOJu0YxfDT+Cm34KLyKoQhDGR51tgGaqyWmYRTONW2DnILf3hC0EbqYg
	l9C8tuoW89Ndv3JF0OQMd+48LlBAf7L1maBSxol8/TEy5cS9CR3NmpuBDzWxO9EdVjVfMV0ZyFg
	27eFqyml4wsXr2MSJwuWKrsN9YGL9+80=
X-Received: by 2002:a05:6512:1309:b0:5a8:64a4:3d8c with SMTP id
 2adb3069b0e04-5a887ce996amr5016467e87.28.1778267980347; Fri, 08 May 2026
 12:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-acpi_spcr-v1-1-fd4bc6f4eb53@posteo.de>
In-Reply-To: <20260505-acpi_spcr-v1-1-fd4bc6f4eb53@posteo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 21:19:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jzgDgw1eMugtSPc7ceeTXUM17=3uUaVY8OBkV7nBLsvg@mail.gmail.com>
X-Gm-Features: AVHnY4JhgRdkxZtY59U4Zn6NdRrVOx9sHHW5yhIgRGnM8hyFsLrg5l9w2SZJgDw
Message-ID: <CAJZ5v0jzgDgw1eMugtSPc7ceeTXUM17=3uUaVY8OBkV7nBLsvg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: Support UART clock frequency field
To: Markus Probst <markus.probst@posteo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 9:36=E2=80=AFPM Markus Probst <markus.probst@posteo.=
de> wrote:
>
> The Microsoft Serial Port Console Redirection (SPCR) specification
> revision 1.08 comprises additional field: UART Clock Frequency [1].
>
> It contains a non-zero value indicating the UART clock frequency in Hz.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports=
/serial-port-console-redirection-table [1]
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/acpi/spcr.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 73cb933fdc89..d80ad87efae0 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -220,6 +220,9 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool=
 enable_console)
>         if (!baud_rate) {
>                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype=
,
>                          table->serial_port.address);
> +       } else if (table->header.revision >=3D 3 && table->uart_clk_freq)=
 {
> +               snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%u", uart, =
iotype,
> +                       table->serial_port.address, baud_rate, table->uar=
t_clk_freq);
>         } else {
>                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iot=
ype,
>                          table->serial_port.address, baud_rate);
>
> ---

Please have a look at the sashiko.dev feedback at

https://sashiko.dev/#/patchset/20260505-acpi_spcr-v1-1-fd4bc6f4eb53%40poste=
o.de

and let me know what you think.
