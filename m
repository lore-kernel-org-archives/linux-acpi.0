Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EE3F86F5
	for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881908; cv=none; b=BV5Aq4l+dczFgFcR/U7Kq3OT2o/BGkUo4QNrdJ/y0mAk3RJmF909tojGuwS40HQtPqrRjroTvS88F/rFISVIOVFEpxEk5qP8wmGDs/gLPLMSVmDMU51tIBmVT5hH5/rieBGi+tCw0ZOK5PzUrjhji6lRNeHvCXmG8KfY+qMS1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881908; c=relaxed/simple;
	bh=C/JDoMskpVNUsPhkPS1ppZP++rW/kUPM4ELPNhRx98k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swq2T8csQ6hDEwIKg24i+stoSqFdpIEUsfbTgxOZGoIdmxthTwD1s16+oSNh1pPE7uxYLiDOrfEI7/DWliAPZWpzNpNX9U8Rn3FP7mOWnzCJqv246+VgF5IrszY7tqNld9+SUGfIbXDeepxmyfahtF7ueQJoyrLu84eqd6mrQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR3APR+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR3APR+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2899C1F00A3C
	for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881905;
	bh=DDPMa0fdpYJQTQJTQSaNefV6P/6fs1Q+aFlsuPZjNBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dR3APR+a8wJ1jq1ChSlC5tFGoMXAFQ0RAFnWIq1ij/QbD9KWR0s/GsgetNI5YCt5K
	 RNlDgHRv7YAKOIu/Kvoq/BECZDO79BzVbJMPYy87noZkhCDDinkRBYXK9Xj4dOdyo8
	 chXS8/ifsuBB5GTbAjU1EinUAEZ/aeLRcVymzaD1Fh0mgH3ksx8yG63WdtrRj3ZYNL
	 2lVgCDIEh+VILTumQ7vzFcPNfa1wZFRcnYdKdk2lFRT4HVu0UPLgm+AIASj+tQzhde
	 FJ3GzlEpJnF9HOKx6JvY/fSXdH8u1M/+NQL7o75HEL5HcZWyTkujy0KX8bEZnc8CUm
	 7FIYymL+eQeog==
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-57754ec3462so7770122e0c.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 04:38:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8fnKUSNEAQ57LhMCvp/jnnbTpMhowvRsDMPez+XLObIsR7dLbQoH4nFVuGWNcR42QBYS94KNsEzRdF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6U3G1Bevy7CPqfk6T/8MXOPUbbMDwwaI9+JGbZet05fuOIdP
	x/yRjzweC04MdbUeeqKP6DlEPszA5j1kNBIzpyyzwaq2B8/vroLLj0ZyyvRFANtJrLd2q/5FN72
	zTIHq3b1q7eiuZxn8SME0XC6NUT2qqKo=
X-Received: by 2002:a05:6122:4317:b0:576:1a8d:8989 with SMTP id
 71dfb90a1353d-58658a3d6f0mr12430648e0c.0.1779881904343; Wed, 27 May 2026
 04:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526025118.38935-1-cp0613@linux.alibaba.com> <20260526025118.38935-3-cp0613@linux.alibaba.com>
In-Reply-To: <20260526025118.38935-3-cp0613@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 May 2026 13:38:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0guqiYf-7u-XOHARWZEYytYBZ=5XahXmtXzZ7Urv8bnJA@mail.gmail.com>
X-Gm-Features: AVHnY4K470KiQWLSRdffFvGwoRgQxOZnZHDAqVE4J9GvFpSBp6vdb7nYMJ5CXEQ
Message-ID: <CAJZ5v0guqiYf-7u-XOHARWZEYytYBZ=5XahXmtXzZ7Urv8bnJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: scan: Honor _DEP for ACPI0016 PCI/CXL host bridge
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, djbw@kernel.org, 
	icheng@nvidia.com, bhelgaas@google.com, guoren@kernel.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 4:51=E2=80=AFAM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> CXL root devices (ACPI0017) declare _DEP on their parent ACPI0016
> PCI/CXL host bridge so that cxl_acpi probes only after acpi_pci_root
> has attached the PCI root and registered it for acpi_pci_find_root().
> However, acpi_dev_ready_for_enumeration() only consults dep_unmet
> when the supplier's HID is on acpi_honor_dep_ids[]; otherwise the
> dependency is silently ignored.
>
> Without honoring the dependency, cxl_acpi can probe before the PCI
> root is ready. The resulting CXL topology is broken: decoder targets
> read as 0 and no port/endpoint devices appear under
> /sys/bus/cxl/devices/.
>
> Add ACPI0016 to acpi_honor_dep_ids[] so the _DEP declared by ACPI0017
> is enforced. This relies on the preceding patch ("ACPI: PCI: clear
> _DEP dependencies after PCI root bridge attach"), which releases the
> dependency once the PCI root is fully enumerated; the two patches
> must be applied together.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 530547cda8b2..5f20e7748f36 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -866,6 +866,7 @@ static const char * const acpi_honor_dep_ids[] =3D {
>         "RSCV0005", /* RISC-V SBI MPXY MBOX */
>         "RSCV0006", /* RISC-V RPMI SYSMSI */
>         "PNP0C0F",  /* PCI Link Device */
> +       "ACPI0016", /* CXL/PCIe host bridge: CXL root (ACPI0017) depends =
on PCI root attach */
>         NULL
>  };
>
> --

If anyone has any objections or comments on this one, please let me
know.  In the absence of any, it will be queued up (as 7.2 material)
next week.

Thanks!
