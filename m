Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126449250D;
	Tue, 12 May 2026 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579626; cv=none; b=o6akoBB9ae3jr0FSnqCbvMyqNnxNLDH681T1QdUBcsfYZlumiDPH0acHrMIJDa8VmeZcNK/kmXpjhhWLOTiE2kR934tdtThx0/tgDFy3QSSYX7yyvxE7lLFWTxRE6teLKQ6uUAPQjDV4oyqPg8kcIKBPmLEKTIW9vQj0REYMx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579626; c=relaxed/simple;
	bh=BIK+kn7bBypwc1dFd2hMNvaIr8YgsWs8NGIF+loU9os=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n4t9LamK3Z5gSvtgBP+oPtqtal/vN2QgY+Bz+g10AlKzE0UngG6MiBBlni09DNR2WcYnmpAHPY2tJ8tMWISMqTQsGznMT+bdl9ZGV6brwre4b2b9FZsF37+Br3zVyr2RlGcnFb3bcLb8O994qkk4MEi9jq65lquQJ2gie2e18dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxDsHqJ0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxDsHqJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778579625; x=1810115625;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BIK+kn7bBypwc1dFd2hMNvaIr8YgsWs8NGIF+loU9os=;
  b=YxDsHqJ0NdVS/9Q/+MQhpRNr0Uh9t7YJjauLvR4SMuNpdu+OVMGgHjJ0
   ia/L8B8XWXNQQFpsr8k33hfUOrWXtfLfmy/QlKC1IL+YOWdcVRXsdGrZU
   y4s4KTKuCLBx+vi/vAu9fkiOeo3D6rPwPutUUlPnmDFGM0sutYzggRD1B
   iUR/dIwNbqwb2pzkNGQ8wrwj/9KrIta55VW9AH0uCcb0D33wdVM7SgQnR
   aWrjSI+DU9fPuB7o1eoIxaItGtUVJwn+W2TK4HixWJcHer4kUHr8Et+uh
   knc8VbTcOmfAJei5vsMOUx3qEg1ZetFllp7NqD+3Y4s3bJigEpMsqgFNL
   Q==;
X-CSE-ConnectionGUID: wkN0g8nMR/+xAOxeWDL0LA==
X-CSE-MsgGUID: PrxsmW4gSYerdp8MV3AC0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79594574"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79594574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:53:45 -0700
X-CSE-ConnectionGUID: 8VExXSzQQ9KrDh6P1fPiQw==
X-CSE-MsgGUID: rSD84105RaqbApV13wlXTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="235054893"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:53:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 May 2026 12:53:35 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>, 
    Matan Ziv-Av <matan@svgalib.org>, Kenneth Chan <kenneth.t.chan@gmail.com>, 
    Mattia Dongili <malattia@linux.it>, Jeremy Soller <jeremy@system76.com>, 
    Azael Avalos <coproscefalo@gmail.com>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86: Check ACPI_COMPANION() against NULL
 during probe
In-Reply-To: <agLV5STILBnNNfWH@ashevche-desk.local>
Message-ID: <2bb54d48-e06c-f187-4d0f-53d9c4567e74@linux.intel.com>
References: <5990022.DvuYhMxLoT@rafael.j.wysocki> <agLV5STILBnNNfWH@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 May 2026, Andy Shevchenko wrote:

> On Mon, May 11, 2026 at 09:48:26PM +0200, Rafael J. Wysocki wrote:
> 
> > Every platform driver can be forced to match a device that doesn't match
> > its list of device IDs because of device_match_driver_override(), so
> > platform drivers that rely on the existence of a device's ACPI companion
> > object need to verify its presence.
> > 
> > Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> > against NULL to multiple platform/x86 drivers that have been converted
> > to platform drivers from ACPI drivers recently.

I was already wondering about when the NULL check is necessary not that 
long ago, as some many places seemed to be lacking the check.

> > Fixes: 578bc2a53ae2 ("platform/wmi: Convert drivers to use wmidev_invoke_procedure()")
> > Fixes: f7e648027d7e ("platform/x86: asus-wireless: Convert ACPI driver to a platform one")
> > Fixes: ba19eb10170b ("platform/x86: asus-laptop: Convert ACPI driver to a platform one")
> > Fixes: 3a96c7915d93 ("platform/x86: toshiba_haps: Convert ACPI driver to a platform one")
> > Fixes: 553b2ac59fbb ("platform/x86: toshiba_bluetooth: Convert ACPI driver to a platform one")
> > Fixes: 246d6cefe525 ("platform/x86: toshiba_acpi: Convert ACPI driver to a platform one")
> > Fixes: 19ebacfb442b ("platform/x86: dell/dell-rbtn: Convert ACPI driver to a platform one")
> > Fixes: 80b8f68b94ab ("platform/x86: system76: Convert ACPI driver to a platform one")
> > Fixes: de6837243af0 ("platform/x86: panasonic-laptop: Convert ACPI driver to a platform one")
> > Fixes: 6da22b031a3c ("platform/x86: fujitsu: Convert laptop driver to a platform one")
> > Fixes: d5c9212ccfaa ("platform/x86: fujitsu: Convert backlight driver to a platform one")
> > Fixes: bd13b265d386 ("platform/x86: fujitsu-tablet: Convert ACPI driver to a platform one")
> > Fixes: 8507277ef132 ("platform/x86: wireless-hotkey: Convert ACPI driver to a platform one")
> > Fixes: 3471415c8186 ("platform/x86: topstar-laptop: Convert ACPI driver to a platform one")
> > Fixes: 138db7ee58c0 ("platform/x86: sony-laptop: Convert PIC driver to a platform one")
> > Fixes: 14004dd31caa ("platform/x86: sony-laptop: Convert NC driver to a platform one")
> > Fixes: 2d9cb20610f7 ("platform/x86: lg-laptop: Convert ACPI driver to a platform one")
> > Fixes: 8a44bd3ffdb2 ("platform/x86: intel/smartconnect: Convert ACPI driver to a platform one")
> > Fixes: 163a68a31f74 ("platform/x86: intel/rst: Convert ACPI driver to a platform one")
> > Fixes: 079b59fd2d79 ("platform/x86: eeepc-laptop: Convert ACPI driver to a platform one")
> > Fixes: b30a462720ad ("platform/x86: acer-wireless: Convert ACPI driver to a platform one")
> 
> Looking at this I would rather see the series, but am not a maintainer here and
> I'm fine with the result.

It would probably be better to split this per driver. Lets say somewhere 
in future stable people want to backport some other fix which has this 
change as a prerequisite, it will be simpler for them to handle if they're 
not all together.

> As a single patch or as a series
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ...
> 
> >  static int acpi_fujitsu_probe(struct platform_device *pdev)
> >  {
> > -	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> > +	struct acpi_device *adev;
> >  	acpi_status status;
> >  	int error;
> >  
> > +	adev = ACPI_COMPANION(&pdev->dev);
> > +	if (!adev)
> > +		return -ENODEV;
> > +
> >  	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
> 
> Don't you want ACPI_HANDLE() actually? (Note it's not directly related
> to this change, but perhaps a material for further improvements.)
> 
> >  			fujitsu_walk_resources, NULL);
> 
> ...
> 
> > +	device = ACPI_COMPANION(&pdev->dev);
> > +	if (!device)
> > +		return -ENODEV;
> > +
> > +	pdev_info.fwnode = acpi_fwnode_handle(device),
> > +
> >  	status = acpi_install_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
> 
> Similar Q here. And some more drivers seem use handle in the given context.
> 
> >  						    &lg_laptop_address_space_handler,
> >  						    NULL, &pdev->dev);
> 
> 

-- 
 i.

