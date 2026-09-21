Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E730D404;
	Mon, 21 Sep 2026 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971671; cv=none; b=QbMB+UOfktDwNjP4L/GyjlX28DCQ6CVSukYZGs/+9P3ItX/XW7AuynNg77LETLebp2TIIHPOV+6++569x8wd3TooitEh029nYiGVNZGS1KSgArUtXnCwf4R0cDdfhdnU1Ovq7imAoCwyH2sluIegj34OggCvQSSM4EjTtQi0YfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971671; c=relaxed/simple;
	bh=GokSPDn7Weo8FUjDTfA/UdlvauRG4Bu66u5qticJdms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6KM1HWRiUb9S5EYiXDvCIVnb/XVFYdnOmD7KUDuvqWU7JJxiCFUDOkLIzNnvb/5ykipwD8IcDfS92mUyqrGa0mmO/ESiGGkL8ddOgOdMGCRSZZyz9v00esHCF2ezbdQgBHoXrRLxhNpw1HdnAejqqy52ainpxETKKy0QNt0rXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ef0NKugI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ef0NKugI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789971669; x=1821507669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GokSPDn7Weo8FUjDTfA/UdlvauRG4Bu66u5qticJdms=;
  b=ef0NKugI0umeI2tSW5yr6L6XcWswTWkPLb1oOjEB3aCgis2BI81WroJf
   WsUIaMraz2Jv/qRGAEVl2c/gkaQ6afcJ1GZRwDQUC/ZXLsaJscXJqBFm0
   67dDcwh/1wNKMjhc9685e40W5HiZIZ/nwkAyrDH+RTLap3IBQ8S/dOH/d
   O2kfCEW6N5MAZyUTAPcO7XMFJlxPc8Us5tygR+WcAe41wfa5bakB0dAfQ
   A0btg9C9YvozgCygfN3Ll1AsF6+qe4/DdUAqJKdYMZff8Ut6jnboXwi57
   JB2McFqQDjS63GV45qEQnUtMZa/oYVYxu8hIHx+uKQee7pauCux4nXWYX
   w==;
X-CSE-ConnectionGUID: /usgXOdkRmK9NCfbopQ5+Q==
X-CSE-MsgGUID: Y43/Ny1WRMav3gb9QCx7Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101058783"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101058783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 23:21:08 -0700
X-CSE-ConnectionGUID: 6BaG3wQESymV/CwYbxPI/A==
X-CSE-MsgGUID: 032XlPM4TVuyNL/Qk6ek2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="272672014"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 20 Sep 2026 23:21:06 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 133A399; Mon, 21 Sep 2026 08:21:01 +0200 (CEST)
Date: Mon, 21 Sep 2026 08:21:01 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mateo Borda <mateob226@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for Lenovo IdeaPad Slim 3 15ABR8
Message-ID: <20260921062101.GP106095@black.igk.intel.com>
References: <20260920173904.6221-1-mateob226@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920173904.6221-1-mateob226@gmail.com>

On Sun, Sep 20, 2026 at 02:39:04PM -0300, Mateo Borda wrote:
> On the Lenovo IdeaPad Slim 3 15ABR8 (82XM), the touchscreen
> (GTCH7503:00) GPIO interrupt on pin 10 is armed as a wake source. As
> soon as the system enters s2idle suspend the interrupt fires, causing
> an immediate spurious resume, so suspend is unusable.
> 
> Disabling wakeup for the device via sysfs or booting with
> gpiolib_acpi.ignore_wake=GTCH7503:00@10 avoids the problem, so add
> a DMI quirk that ignores wakeup on that pin.
> 
> Signed-off-by: Mateo Borda <mateob226@gmail.com>

Acked-by: Mika Westerberg <westeri@kernel.org>
