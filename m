Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9C3CBE7A;
	Fri,  3 Jul 2026 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080628; cv=none; b=eWGiFRJwo98Mm5T80tBEaYsseayU4jNN4RXeEhFIR2Z+mo+71QF1edU+HrqQbe/hJHrKfLtGz3W0rqeRMnnnAIt8cj9Ss6g329I8MCnwQ/S0VzBApXy1PM32JUUnK5/8DdT7axwrWXycx2frG9XKUlrRi3am+BwlFl0jvTkVqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080628; c=relaxed/simple;
	bh=kNg/6Iu2YKTJrh+N4ZU6cyY4SWVxfOR7OuJeJQoYlXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgFwBLGnamTHoVHtylq8ppT3gG+bVMW9rWEdqliyy0xBIo2WYZO+XS2OwPEy/YaPnGRzWtYl40l81xHrNytHnqyFuHP7pLcfqk5rVIEXNVqTcrxp9sMfxmeoFsjcU3CeBLUafXYCLP+hDWMmYnUOWKAb5gucOVNcVGK4C2h2EAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdBCF5J1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdBCF5J1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783080626; x=1814616626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kNg/6Iu2YKTJrh+N4ZU6cyY4SWVxfOR7OuJeJQoYlXQ=;
  b=IdBCF5J1sgRFVcBOmPUXYcXFGTAGNXDCnsB0ICl2HnCRYIp+13UJTMh/
   MSisuihFoxDSd+pRYBQQgKRFys5HuKq2YMWyWT/G5Q+c2JpLUNvAbgLnq
   fdrL96UBcpYyxF/lcGxVnuTHr+K44s2HYm3BbZU0n9Uw5BE3aQjKzIcdI
   1LcGTakjCinm4XecHrkGDKXdH9bBVqNNiI3DqGV9nJxlDU4aqQjgZMxfj
   f5e1XV7Wnehrek4evh4tqQuij3trJc0OgzTqX0yCrNh9URnBKvG+l/Qf+
   +bLsxWCetZhUNB2isFLoByO5dsd6SM1Nm/XqEfjQNPNa5V1rOwvzNBxEC
   A==;
X-CSE-ConnectionGUID: XIp1KywtQoWk9q6d5/iJ9A==
X-CSE-MsgGUID: mnSeWV2RSkCtN9hsPuf2WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="106631122"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="106631122"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:10:25 -0700
X-CSE-ConnectionGUID: x3XTvo6FSxWQyNxYn0dM+w==
X-CSE-MsgGUID: /ANcCoj+Tcmk9gT5+MUAow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="256992913"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:10:22 -0700
Date: Fri, 3 Jul 2026 15:10:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Kenneth Chan <kenneth.t.chan@gmail.com>,
	Mattia Dongili <malattia@linux.it>,
	Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH v1 00/10] platform/x86: Stop using
 acpi_device_name/class()
Message-ID: <akemrOqzWtcDVqey@ashevche-desk.local>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5135166.31r3eYUQgx@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 01:15:01PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> There are two fields in struct acpi_device_pnp, device_name and device_class,
> that were supposed to be populated and used by device drivers, but they have
> never been used consistently and some drivers just populate them and don't
> access them later, and some drivers use them uninitialized.
> 
> All of that is confusing and messy, so the drivers for core ACPI devices
> have been updated to stop using those fields which are now slated for
> removal, but they are still accessed in some places.
> 
> This series updates platform x86 drivers accessing those fields to stop
> doing that.

In most of the patches you have double space in your name in From. Can we have
some consistency here? Or is it deliberate (in which case I'm wondering why)?

-- 
With Best Regards,
Andy Shevchenko


