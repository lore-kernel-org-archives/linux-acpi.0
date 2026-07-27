Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B441A77D
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160445; cv=pass; b=lhXo1tGTtdmopxuwXvr0JFDnZn2FEkzj6Ffv31jGIDB878Rn/Xe9Zt8ZelYzYXlp1WlTpBma/VFZJh6QrK1nMnV7KqaZoo1p+mVlazij67A6VTYuBSbvOcl9CHZj48mk0xSOcPAw0mYp73E6HAyCZuFwHc/c3cWnPOOGyU73H04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160445; c=relaxed/simple;
	bh=fQJyxDv643pqDMxn0ByaDWbHqZIiq7Rg1W4GA2fAA2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW0M/OzNk2QPuErjg2pPQmydSkqS7nxzrQHMfJDfNlSQUuZhlUJIx0LNseNzYz6itb/0EYCqptfymNfjVGCVKqu+B2n9qwnn0dGNMKbJiZuOvyloLANboZMTlaTfyXWGevrMYhjLS0w8aQqiZBOllPiRzlrV5vjZlW7Jnsd1sbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=CPP6ZbNg; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="CPP6ZbNg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso20432705e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 06:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785160443; cv=none;
        d=google.com; s=arc-20260327;
        b=O7zR+z2PrpYoPJfh4vB497in6e62WunFnZ180ogdKVh2vVFwiH/jiqyhX/kqlfkuDJ
         wDXNVH3XGnFJemvHr+r5WAncf+CPtucnBHdSPvX/81W7cXGo5SWresHMJqEOWIEomX/G
         UsLrLrOWgxecABSyc058utyCWlIA8EqlunoxNGFXfotKMJKyXxCw6Wswph0DemTtoNqh
         biY8F3bgzPnRwfBFBrJxGlnbC3Dl/kfj3/yc5OgEOllh6eqL1xE+B7zA6BPVQJQ+UqCq
         ITKPfrV8ORT6CBNjegJAvuS9kQN6405WurB71dUfQbri6G3/bsyBRDyfi+8mF5smWcqF
         Sc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        fh=YsMgL1e3vDp4DynIWgboVC/27UfHpDOxdyYevbYVF8k=;
        b=kOy3pZ/Riuqd4iBcBlKG7QI2TNIUCf9cVvvKu2EAAbWBPaP03VGg/JkUobhjX7FDDJ
         PK+R8sHb7XVctJ+EB6co6n2AJcpl+Mr2rgf4rxYgzIF+juwoXrvByFz0DEn7awz/fawC
         Nettm7ZEFE9T0RWszp/5XOm5kZKSD9x8EqC7or0XieFCuI4GBKUuDvbwFcf0QnuFn7WT
         ymXt8ABGC1pGW8CaPrk0Eb3CDXy6uCNLFwkk9KQhddFkXUrv4Clpuocmf9uWrGtVrlcm
         6g1O3F21D8txzvN6YO530pKMfkcEWQpJEzKSSeSeiCsS3O0rNDLkNIQyI3ZJRS/LFyxc
         5O4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785160443; x=1785765243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        b=CPP6ZbNg6HDlf1OkpPivvEKY+RXI7VgWumYaxtrQrajy5k9EvuixeX9E91Ay7RsOAt
         ewpJq5nGCpUp1oCpEtMI7UDS3+g/zILvyeui24WHpxW1Z3q/x4POy/Kmu4glTINbMzBx
         n0eQbmP9cPrVH2xzKXRlYSC+6R517ZLZQqQ9ZCLjyB6IlWEDq5TKaXC4SNLOT6KIJbo2
         g3erZ7a06GX24K2zEFeLv9z6lpKacD6wx4GgE2XcgJlk7NTPAEftLJ0y3/zgSQtUni6U
         4hLK5iLqB1N/4JrDJOZNglLVmdsW9Ks66Qa/cgnAyNjGbq0nySjDSMQal4rD+XFCY8Lz
         nR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160443; x=1785765243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        b=XKEinsZhPwwJ2CJC5fyhO1Z0CdzdYR48qdj3szHlTOqBE7ifvDwUKZ5ig+FbzesJdv
         cON+LonG09+TIk1tJ9tgFmAy9vXmMprjmytMIDyttvT2LlcLpguLoA0c8nzaVEsiAFjt
         figeuklh54y/BkD8On7PxmAkc7Ss3zli51yeN/RNJAoQwCjo81JzyQ0PAnOVakpIfhjs
         JnIBUuhqq+dy+3g7+vvFIXAJEBsxiAAM33mh/RWJ7lcYVdn4Gi4lzkbV/JzxwLw+AZ0a
         50JgirHW9gw2eTamZ7+cB6G+46IG5W8VUepQ00a7EwAdV7zP9pfpXxuQvRmVZs99sd6Y
         MK1g==
X-Forwarded-Encrypted: i=1; AHgh+Rp5uo/PcgDM6Fdt2rFCG3kK5CyyEcSV+yBgFUsaTipR+CHyQ4oTIjnTOm7OhAHAyCrgJ5F0uX3JtPzq@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcJglfKoQM5MHWF3Nf0NXqBlaT6IB0tTaxJY6RQsYmW64pEnW
	6UzZZx1pJz1OJgZOJGTkgZN9GBPjBUaQ9pUWCpOIoI4IK8GVN338o0+FuVBOsFU6bbi6a4DfK3l
	ex66TeLXw7bdLEhXFMaIzlVve1jnmlqBbCi8NvkYB0g==
X-Gm-Gg: AR+sD10e4t4w5DqGHMXnrIgMwx6AQplr2elzU6Re7977V2xcmIS98L/GkdT72fPOi+x
	n6MI6L2CE78HHjRXLOcfbQhAESuyRULqe+ONJd1o48VYQcBXv9c1ZX9BXxCDOsnIgrJ+db3YQc2
	2aa8DI9TRHcg7LqTA0wsOaFpX+Mmgj7llg9s/wTncBQYK7pFFLT6Nt0la2uZ9qhW42EHc0if/vM
	/jCcEmexR6qiYQPz5sKSe4xOAAY9zdtQkOzUHTG3mLktzrgR27KaXVKy/VqImTQyS4jL5vhmIlZ
	guMBQkNYcaa9JgpG3cBy1uz1WSgD4SgebG73YL2eIRsunaQYg//ruRTV6CopVScCxLSP+VVNSpR
	+Ij4H
X-Received: by 2002:a05:600c:a12:b0:493:eccb:8cb2 with SMTP id
 5b1f17b1804b1-496b57297b8mr114877045e9.30.1785160442437; Mon, 27 Jul 2026
 06:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727084003.1951324-1-anup.patel@oss.qualcomm.com> <71fd5b46-4388-4106-aee9-b4510069975f@arm.com>
In-Reply-To: <71fd5b46-4388-4106-aee9-b4510069975f@arm.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 27 Jul 2026 19:23:50 +0530
X-Gm-Features: AUfX_my4QjrER3hRFjzxXael861bKnyaiQylY-XLFhSCxIc_XNnqTG1sq5MogY4
Message-ID: <CAAhSdy2cDHO2w8VX34WV1kBxHQ6N0H0Ra_r6aDKK86250nWFSA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: platform: Setup device MSI domain just
 before driver probe
To: Robin Murphy <robin.murphy@arm.com>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Rahul Pathak <rahul@summations.net>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, iommu@lists.linux.dev, 
	acpica-devel@lists.linux.dev, Sunil V L <sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:46=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 27/07/2026 9:40 am, Anup Patel wrote:
> > On RISC-V, the MSI controller (aka RISC-V IMSIC) is probed as a regular
> > platform device and MSI client drivers are always probed after the MSI
> > controller driver using fw_devlink. Unfortunately, this is not sufficie=
nt
> > to ensure device MSI domain is set for MSI client devices before driver
> > probe because OF framework sets device MSI domain at the time of platfo=
rm
> > device creation whereas ACPI framework expects arch specific code to se=
t
> > the device MSI domain at the time of platform device creation.
> >
> > Currently, to address the problem of device MSI domain being not set
> > correctly, various RISC-V MSI client drivers explicitly set device
> > MSI domain in the driver probe function using below code pattern:
> >
> >       /*
> >        * The device MSI domain for platform devices on RISC-V architect=
ure
> >        * is only available after the MSI controller driver is probed so=
,
> >        * explicitly configure here.
> >        */
> >       if (!dev_get_msi_domain(dev)) {
> >               /*
> >                * The device MSI domain for OF devices is only set at th=
e
> >                * time of populating/creating OF device. If the device M=
SI
> >                * domain is discovered later after the OF device is crea=
ted
> >                * then we need to set it explicitly before using any pla=
tform
> >                * MSI functions.
> >                */
> >               if (is_of_node(fwnode)) {
> >                       of_msi_configure(dev, dev_of_node(dev));
> >               } else if (is_acpi_device_node(fwnode)) {
> >                       struct irq_domain *msi_domain;
> >                       msi_domain =3D irq_find_matching_fwnode(imsic_acp=
i_get_fwnode(dev),
> >                                                             DOMAIN_BUS_=
PLATFORM_MSI);
> >                       dev_set_msi_domain(dev, msi_domain);
> >               }
> >
> >               if (!dev_get_msi_domain(dev))
> >                       return -EPROBE_DEFER;
>
> I stand by my previous comment that relying on ACPI initcall order and
> assuming fw_devlink is enabled doesn't really seem robust enough to
> justify dropping proper handling of this case, especially if pretending
> it's a generic interface.

I think you still fail to understand the root-cause of the msi_domain not
being set correctly in the struct device. There is no issue with the probe
order (or probe deferral) rather the issue is msi_domain being set very
early by OF / ACPI framework at the time of device creation when there
is no MSI domain registered.

Let's take the case of OF based platform devices with RISC-V:

1) The OF framework set the msi_domain at the time of platform
    device creation but unfortunately the RISC-V MSI controller
    driver is also a platform device (aka RISC-V IMSIC driver) which
    is probed much latter hence the msi_domain for all OF platform
    devices is set to NULL.
    (Refer call path,  of_platform_device_create_pdata() ->
of_msi_configure() -> dev_set_msi_domain()

2) The fw_devlink based probe ordering in the Linux DD framework
    ensures that RISC-V MSI controller driver is probed before the
    MSI client drivers (such as RISC-V APLIC MSI driver, RISC-V
    system MSI driver, etc) but still when these MSI client drivers
    are probed the msi_domain remains NULL for the platform device
    of MSI client.

3) Due to #1 and #2 above, the MSI client driver have to explicitlly
    call of_msi_configure() on RISC-V because no one updates the
    msi_domain of all platform devices after RISC-V MSI controller
    registers a MSI irqdomain.

This patch eliminates the #3 above by calling of_msi_configure()
right before probing the OF platform device.

Regards,
Anup
