Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52E514761
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061378; cv=none; b=Oj9sHj7s0PtOSXNgogLZ8hjDVD55Q9BR3RIm0chk91mXQP88o/+XMDvufZEkQpxd8OrHRUmD0E6lIwCVVEm19bvotzweCx/QRlyKet06jBUePd1ifTw0v4UQPmocMUJX3LJuezYC29ZpAQ9e/BmT1JHv6p4+oYrNTjF69xi61/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061378; c=relaxed/simple;
	bh=IpANxtylzokS12X5AZWkkOW+gKIoDnRIPCS9c12npeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgCiRnrDPS4yX8z1mZ/Pm9Dy4AJjSOSYP2zP/ahaDkZoMu1wbhueLhMAyNbzjiJZzZ1Xdj/wDDiH4FAWlKDs/oiVQiuWJ51Z/IP0FF0z9hyHiCvgRDLAW/QhmSDl2qlAjARnzhTYsF4ALF8KC3SYWb1wDPTprzfJ/dFDWE4Yez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvF6DJ2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvF6DJ2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02A61F00899
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061367;
	bh=NNwG7e62XZ7vvoeKoM9Eyl0Ic/zmIJFrL59t1jT3ud4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UvF6DJ2JifFULIXXfgBNUFe+Zh3bV5WXacE5egwyUzDaEHslxcQnZOwfN4/MaYgSH
	 liElSByLV7pgbsNBeT4v/8oU7dGR4J0Zt2TABW3Qn7nPqv1r3kz881xVavI/JuHPP0
	 AG0EqLMJOH3GaIdXhBiE6VA/wL9Wnlp7uWUbWhisoROux7CY6I9CvfltatuzmKYDnM
	 ba9TBDaMy8s5DkNxB9uZOqFU92yWRg5O9vendtewXtH5ZucHk2edm2IAjdNU6Hd/mU
	 CMMjsU7dH0d4rYFU0+M0FdqX77EUAkTG2uFfxGfsfc5omswxPpPvDF9ycPva3ph7Yk
	 2dEMAwVjOrZxA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a2e985245eso124021fa.0
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:29:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3vt73ic0MEfHvXC6zPpoxCbN1rEVUcrpxMU5lGpz9Lq2x24Y0sDlsnEEO+UA16hnzPvwhjC2mPDPz@vger.kernel.org
X-Gm-Message-State: AFuF++maoqfjMGHdxWGCxnDe0sv1gHv+WxDPa3QjACJFb0wLDfVAIQBT
	Op2RNPc7Upw2fVBAxWoh4D7ngqd1vGNTEvPkjv66TP1+Jl27Kt+G76v+RwZsQrC66visAvKCsUy
	/OzHSf88prVLT27mbsntlvb7k0YgQKz4=
X-Received: by 2002:a05:651c:2214:b0:3a4:8527:2a90 with SMTP id
 38308e7fff4ca-3a485274a15mr24891711fa.25.1789061366053; Thu, 10 Sep 2026
 10:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909163918.368017-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260909163918.368017-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 19:28:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNBbZbnXCKX__vZ-Dkm_y9scfF9YQy8rKEM4RYc2OcwA@mail.gmail.com>
X-Gm-Features: AcwNN1WYBUZJmjJfp84vmtfYw58EYEw76VKZTAAd7ItgoSVZv9SF07FTeLT7-I8
Message-ID: <CAJZ5v0hNBbZbnXCKX__vZ-Dkm_y9scfF9YQy8rKEM4RYc2OcwA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: bus: Reduce runtime memory footprint of
 struct acpi_device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 6:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The ACPI handler is heavily used by the ACPI code. Making it as
> the first member in the struct acpi_device reduces code size.
> For instance, the drivers/acpi/scan.o (with `make allyesconfig`)
> gives this statistics:
>
> add/remove: 0/0 grow/shrink: 3/8 up/down: 50/-169 (-119)
> Function                                     old     new   delta
> acpi_device_add                             2294    2319     +25
> acpi_add_single_object                      6523    6544     +21
> acpi_dev_get_next_consumer_dev               602     606      +4
> acpi_tie_acpi_dev                            169     165      -4
> acpi_scan_drop_device                        319     315      -4
> acpi_dev_clear_dependencies                 1151    1147      -4
> acpi_bus_attach                             2898    2894      -4
> acpi_dma_get_range                          1420    1415      -5
> acpi_init_device_object                     5497    5485     -12
> acpi_bus_check_add                          1940    1923     -17
> acpi_device_hotplug                         3407    3288    -119
> Total: Before=3D77509, After=3D77390, chg -0.15%
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/acpi/acpi_bus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index a10a591c18b2..64ae66ca456e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -435,9 +435,9 @@ struct acpi_device_software_nodes {
>
>  /* Device */
>  struct acpi_device {
> +       acpi_handle handle;             /* no handle for fixed hardware *=
/
>         u32 pld_crc;
>         int device_type;
> -       acpi_handle handle;             /* no handle for fixed hardware *=
/
>         struct fwnode_handle fwnode;
>         struct list_head wakeup_list;
>         struct list_head del_list;
> --

Applied as 7.4 material, thanks!
