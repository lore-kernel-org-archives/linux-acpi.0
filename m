Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56710367291;
	Tue, 21 Jul 2026 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647350; cv=none; b=Y4YNwQ7llJaGQCACDkQVZHWpnTiHKyx51QRIzn83xpOn4euzTrk/YGAp2IDhU6b1oUUcAGKxh7U7IA/bj5H9CSEvE9AnRnX4mdHJG4qFXyXUmladhu6aT9HDVJflu7yshtUiPxNAoyjDZIX5eWeP1QEppDrsBOerGv3wiplOkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647350; c=relaxed/simple;
	bh=qflAA0FTjvHJSlUr+jE5Thqagb5URzhem9CNsyj3U1U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U4OuHMMH0beMLKMH/MNiMabqTU7fWnMz8auwBavpmzBSZV6UHVXmCxHMHpJ3pcca4Cc8wbt58IlwPhgI81XDWyMQDT9yKceofnBpa63WXdb8UU+KM83lIRvPbW5qoalKD0tkGIV8nMzTudkER9FH7Y3cGTBD2EOm3jSxse0iKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFw2+TtC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFw2+TtC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784647348; x=1816183348;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qflAA0FTjvHJSlUr+jE5Thqagb5URzhem9CNsyj3U1U=;
  b=AFw2+TtC9FZcwiJYHQafSAwxRNO6LpnSpzL13t5TW1rU7KO0D8j+44gK
   7zWdzQwzoqfFh8Wo7lTHMqv1FtrvI14+ywYZ8qypna3D8Iy/5ZoJyJzBX
   CBtb1YYGekQ3rN+KnqqijuwP+Rt/DXVo4S0jc6ciAhI1ZQHf1it0RsSCD
   jaNAkCsv/LPQf5+51PdtaPiRtbQWIyquczhq+gdse5ZcjCw18wR0e3/d6
   TRUpBG1wupOII4ShFioy1xuYizOXenFnTlf9tn5fa1cV4AFK2184kCU5X
   ocrqYlD+sYWvVAdWMN2RfZ5V9f55HJ4GjUow20YRQeGMzpO6zwgBDgtVQ
   Q==;
X-CSE-ConnectionGUID: vBu9ieI+Rm2eCuxfPhx0ow==
X-CSE-MsgGUID: Fcw3flzhRauzeUeaFLr/9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95847560"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95847560"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:22:27 -0700
X-CSE-ConnectionGUID: oglzvjPaRuab58OifE8hDg==
X-CSE-MsgGUID: YNaAMIsqR9GDtw2/nNyqzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="262079989"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:22:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 18:22:17 +0300 (EEST)
To: Marco Giunta <marco_giunta@outlook.it>
cc: tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com, broonie@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    Hans de Goede <hansg@kernel.org>, linux-acpi@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, wangweidong.a@awinic.com, 
    nadim@symbolic.software, imitoy@imitoy.top, munzirtaha@gmail.com, 
    yakov.till@gmail.com
Subject: Re: [PATCH 6/8] ACPI/platform: add AWDZ8399 to
 serial-multi-instantiate
In-Reply-To: <DS7PR19MB772444EB48828D8ED8EB3175FCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Message-ID: <8b477bc9-f461-a242-2522-8ac87e2bb2e7@linux.intel.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com> <DS7PR19MB772444EB48828D8ED8EB3175FCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1703166405-1784647337=:1265"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1703166405-1784647337=:1265
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Jul 2026, Marco Giunta wrote:

> Register the AWINIC AW88399 ACPI hardware ID "AWDZ8399" with the
> serial-multi-instantiate driver and add it to the ACPI scan ignore
> list so that the two I2C amplifier instances on Lenovo Legion laptops
> are enumerated as separate I2C client devices rather than a single
> ACPI platform device.
>=20
> The SMI node creates two instances named "aw88399-hda" with
> IRQ_RESOURCE_AUTO, matching the pattern used by CS35L41.
>=20
> Tested-by: Nadim Kobeissi <nadim@symbolic.software>
> Tested-by: Xia Yun'an <imitoy@imitoy.top>
> Tested-by: Munzir Taha <munzirtaha@gmail.com>
> Co-developed-by: Yakov Till <yakov.till@gmail.com>
> Signed-off-by: Yakov Till <yakov.till@gmail.com>
> Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
> ---
>  drivers/acpi/scan.c                             |  1 +
>  drivers/platform/x86/serial-multi-instantiate.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9a7ac2eb9ce0..4f4552b1551b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1752,6 +1752,7 @@ static bool acpi_device_enumeration_by_parent(struc=
t acpi_device *device)
>  =09 * by the drivers/platform/x86/serial-multi-instantiate.c driver, whi=
ch
>  =09 * knows which client device id to use for each resource.
>  =09 */
> +=09=09{"AWDZ8399", },
>  =09=09{"BSG1160", },
>  =09=09{"BSG2150", },
>  =09=09{"CSC3551", },
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/pl=
atform/x86/serial-multi-instantiate.c
> index 1a369334f9cb..3e89fcdd45f7 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -307,6 +307,15 @@ static void smi_remove(struct platform_device *pdev)
>  =09smi_devs_unregister(smi);
>  }
> =20
> +static const struct smi_node aw88399_hda =3D {
> +=09.instances =3D {
> +=09=09{ "aw88399-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09{ "aw88399-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09{}
> +=09},
> +=09.bus_type =3D SMI_AUTO_DETECT,
> +};
> +
>  static const struct smi_node bsg1160_data =3D {
>  =09.instances =3D {
>  =09=09{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
> @@ -405,6 +414,7 @@ static const struct smi_node tas2781_hda =3D {
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>   */
>  static const struct acpi_device_id smi_acpi_ids[] =3D {
> +=09{ "AWDZ8399", (unsigned long)&aw88399_hda },
>  =09{ "BSG1160", (unsigned long)&bsg1160_data },
>  =09{ "BSG2150", (unsigned long)&bsg2150_data },
>  =09{ "CSC3551", (unsigned long)&cs35l41_hda },
>=20

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1703166405-1784647337=:1265--
