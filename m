Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F1466B09;
	Mon, 28 Sep 2026 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589257; cv=none; b=N/stukpXr5tTCZ1cKOimBbFd6+65C7lSFnaf/D9/taFpoMR6yjULcKNk49XAL0havehgVMBfkAE+Zc4DP3GnJFDEpso1WxT9q/2iANmH5jNw8ROUxzBNBo84bhoT1tX+8I2gr9BUz/50T97ZBPFmmsMvNye2CAbaRSzWh7EkZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589257; c=relaxed/simple;
	bh=Byz7ahQrpVAlTkfb7uhvJc3bj7qglIhdenh7tczHaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcg9izduP3mEjajOnVJQv62ZKEQRB/1jwnSPlsXvIbNEkkBtKBP6e9l+u9UdKIrtwJgKGodG5Y7ToW+i/SSOfyaxGaRONWGj5LhLI5fAm5oSD/FNPl4yEQEF43Fa20ZKDevRHyYIqNWqjeLP8v1w+BGc+LvzHyfj7Ie9bveKz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnmKvmGT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnmKvmGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790589256; x=1822125256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Byz7ahQrpVAlTkfb7uhvJc3bj7qglIhdenh7tczHaTU=;
  b=FnmKvmGTPmxsOJVIXBSJmrARataDaTFOVjH0XlO/DGfcT2pDw8O2xw2Z
   Fc0jaq1pnhhZ1ODPumX89YJKExF4R3hJFl1PoLwaPiKBtqyEb1wA1dZqV
   D3g/jqBrrKaLWkJ2dd/4RCLyizfRqnksW8qU1ZvGESzSdhae+fAxhOUdI
   uZAj26F7bfp0cETEkxTECv9nRF1C0OrXYXWM9OZeL+SMRdmUsf7y6yA9d
   ImDlXDeMMN+n8azbzKygJoBfAtLtLWWVcYbZQvCkWG/y+oBTgncuNLHZY
   /QJgvZCXBNVpVWvo53f3OZ31GZS+ktV7ym6V1qphsahYJzxwmWkjxNSXO
   A==;
X-CSE-ConnectionGUID: maQLTnjoREC6BBXJqQhEag==
X-CSE-MsgGUID: PYiaF/FTSNGPUCk5ptHnMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="95099260"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="95099260"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:54:12 -0700
X-CSE-ConnectionGUID: H6saJdx+QYWi7wTlSdOw/w==
X-CSE-MsgGUID: ksQEhulSR4eu0suTJCndyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278372663"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:54:10 -0700
Date: Mon, 28 Sep 2026 12:54:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartu Alev <bartualev@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Ignore AC adapter wakeup on ASUS FA507
Message-ID: <aro5Pz000gT7Q9t1@ashevche-desk.local>
References: <20260927014212.302743-1-bartualev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927014212.302743-1-bartualev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 27, 2026 at 04:42:12AM +0300, Bartu Alev wrote:
> The ASUS TUF Gaming A15 FA507 wakes from s2idle whenever the AC
> adapter is plugged in or unplugged.
> 
> In the CPMGPIO0 SSDT, GPIO pin 23 (0x0017) is declared in the
> \_SB.GPIO._AEI resource template as:
> 
>     GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullNone, 0x0000,
>              "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
>              { 0x0017 }
> 
> and the corresponding \_SB.GPIO._EVT handler issues a device wake
> notification for the AC adapter on pin 23 events:
> 
>     Case (0x17)
>     {
>         Notify (\_SB.ACAD, 0x02) // Device Wake
>         Sleep (0x05)
>         Notify (\_SB.ACAD, 0x80) // Status Change
>     }
> 
> Both AC plug and unplug transitions therefore trigger a spurious
> wakeup from s2idle. Add an ignore_wake quirk for this pin.

...

> I have one question: this issue is probably present across the whole
> TUF series. If I acpidump more TUF models in the future and they all map
> to the same GPIO pin, should the quirk list the board names one by
> one (FA507, FA506, FA707, ...) or match on the product family ('ASUS TUF
> Gaming A15', 'ASUS TUF Gaming A16' or 'ASUS TUF Gaming')?
> 
> The DMI outputs on my FA507NV laptop are as follows:
> 
>   board_name:     FA507NV
>   board_vendor:   ASUSTeK COMPUTER INC.
>   product_family: ASUS TUF Gaming A15
>   product_name:   ASUS TUF Gaming A15 FA507NV_FA507NV

I can't guarantee that, so the safest approach is to go with the one-by-one
quirk(s). If you get a confirmation from the vendor (ASUSTeK) in writing
supporting your idea, the patch will be welcome, of course!

-- 
With Best Regards,
Andy Shevchenko


