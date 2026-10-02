Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9D4746C0;
	Fri,  2 Oct 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946277; cv=none; b=iNz1lyh6gEgp1T1p151x6CFwBWoXBUv+TexR6764qEU4A/v2hvd9YXbTo6K0GMbqA4HzXFdmiQ+ytWAJERakPxJ8F88TFlaKMXQgIJYlr+oseQRTbmqueDN1tc+Ss1XmjKKMdtNQv4G6wCSDpVhMb21e0ggPXLqEJUd0NVJ/+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946277; c=relaxed/simple;
	bh=qniuymbkHRlxCRM5N4hPqn+DRm34HinGda+Wva0ejJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4n/VQLuQ/8D/sk/9bjH6kXDgtKo0q4qUaYLAlJMp2mhzna4jUJC4+iqqya74LYDh+htkYuZGQa9lnJe69usPuHHPaBdtvMlENyetJZZCPGjL5misbN8XxXaRuaoLi6JNCE1hsyo1SYNicMbAl/gzvSJUtAy3TIOp/al997YakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AryOx3Ct; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AryOx3Ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790946272; x=1822482272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qniuymbkHRlxCRM5N4hPqn+DRm34HinGda+Wva0ejJY=;
  b=AryOx3CtcrEHNPKbMCwRMNlO7oOAbPlAMmBUOcL3GRU2YGHB6xZcHX+L
   QQ6vQ7BAf8iOXI1TdXOCQR69ucdo4HPAZuvvyVgWhCIawFGWlOUH9fxvf
   6v7lM9SAh4FrtRapyb0TNflkbebvPSj8hzz/DU6ak5o0HnWzhMM3EQunj
   YLDXe5i2sPVV3y13fXeHsK0CHrjgebG6PRgMt01TLgYMdWxYw2RHSdPAJ
   0GNhi+a6BC+7CnL0nJMD9zbCO7aizsLLiHM5dNGy5SaQOS3X4ZTX0edhp
   2c7o3r/aMNRTT1jZPZDkm7kb5+aVnPT/9krFiH2h+zCx6sTUqG5yICnSm
   Q==;
X-CSE-ConnectionGUID: R2fxddOoR/qtu10xED7bzw==
X-CSE-MsgGUID: WdurwS7JT66E49phQVhaqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102385290"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102385290"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:04:27 -0700
X-CSE-ConnectionGUID: PM3GQDSeSBCaZ/8gXptK6w==
X-CSE-MsgGUID: 2HpH8XT9SySFwGlrGZXgQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="276366351"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 02 Oct 2026 06:04:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 36D9A99; Fri, 02 Oct 2026 15:04:24 +0200 (CEST)
Date: Fri, 2 Oct 2026 15:04:24 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>,
	Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro V
 16S AI
Message-ID: <20261002130424.GG176164@black.igk.intel.com>
References: <20261002101800.51506-1-abduvaliy.hbai@gmail.com>
 <ar-Ja2AVJs1TzMpg@ashevche-desk.local>
 <CAPGafd=-SfJoVMXtjwpahEkZ8nB9gTjGm+C5WvP+F-AdjsGPjg@mail.gmail.com>
 <ar-qbsmktRJbFoF-@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar-qbsmktRJbFoF-@ashevche-desk.local>

On Fri, Oct 02, 2026 at 03:58:22PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2026 at 05:17:02PM +0500, Abduvaliy Abdulazizov wrote:
> > On Fri, Oct 02, 2026, Andy Shevchenko wrote:
> > > On Fri, Oct 02, 2026 at 03:18:00PM +0500, Abduvaliy Abdulazizov wrote:
> > > > On the Acer Nitro V 16S AI (ANV16S-41) the internal USB camera
> > > > (0408:4035) works on Windows but never shows up on Linux.
> > >
> > > While this all sounds legit, I'm worrying that the pin can be used for
> > > something more. For the record, can you share the DSDT table (or entire
> > > `acpidump -o NitroV16S.dat` file) via some file exchanger so we may see
> > > that?
> > 
> > Sure, here is the full acpidump (BIOS V1.14):
> > https://github.com/abduvaliy-engineer/acer-nitro-anv16s-camera-fix/releases/download/acpidump-v1.14/NitroV16S.dat
> > 
> > What I found when going through it:
> > 
> > - Pin 0x0B shows up only once, in \_SB.GPIO._AEI, as
> >   GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone). Its _EVT case
> >   only does M000 (0x390B), with no Notify.
> > 
> > - There is no GpioIo for it, and none of the M009/M010/M011 GPIO helpers
> >   are called with 0x0B. The only static mapping of the GPIO bank in the
> >   DSDT (OperationRegion GSMG at 0xFED81500) has fields for pins 23 and
> >   40 only.
> > 
> > - The PCIe reset pins in the NVMe SSDTs (RSTM) are computed at runtime
> >   from a platform table. Pin 11 is not one of them on this machine: it
> >   reads low after Linux takes it, and both NVMe drives keep working.
> > 
> > So as far as I can see, the firmware drives the pin as an output for the
> > camera and lists it in _AEI without a real handler.
> 
> Thanks for sharing. I will wait for Mika's tag and apply if he has no
> objections.

No objections,

Acked-by: Mika Westerberg <westeri@kernel.org>
