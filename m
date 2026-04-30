Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B640626A;
	Thu, 30 Apr 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553150; cv=none; b=Z6f6lLiOd6XSgbF6E6AZbRuGxaoUFZdv5/kSYWKA6VhHCLGqXAoX6anZYci2yCQk1ZPuGUfm+0q1B5+d/nJDUQlM35gF6+boSARgWnvREbVB81VgAXQbdasUNxobymTvciKbYK867uTgNAXy2tbSzZ473j8BTnSiU0AnXm+az/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553150; c=relaxed/simple;
	bh=8FuyhcU0NeKHWu/h/BN34/C2sPypqOjPWw6HFO+7NIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXqf2LJUArvJARPhRDFR5CwXj9CZcTmXtJcvRe9Pb0etYmDjA5SttkouwrnF/4V5h81xLxbw1YcL772KLZ/uUaXUXgrQtPtH1ulvor0P5PtRL3bjjQ/nm8nL6flf9YlizjxwCEX9oVCAl89SjxwOP3/6sdqslOp0Wv5Lb9elzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZ55+oCU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZ55+oCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777553150; x=1809089150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8FuyhcU0NeKHWu/h/BN34/C2sPypqOjPWw6HFO+7NIc=;
  b=OZ55+oCU63HOubmqPJkMkUHW/8Jard4ysbI3E/HIyR2ImmkOKyE4lgjf
   c6wXDwsL+/UcvSHh/WEhsWh1MKwkDIKnfP+VNwVjaA1Lh6bszxGQVXkkL
   FYRbH/bm7JIftq0bDYzAje9EnmnSLAS1G4PxCpZP5NYy3w6Dg0a/Wf7I3
   XgJVpgkaQ+YZ9EITXufIHSKExtMzSpOpBRZbnEW9yLeAg+hO5413OJROm
   TpNusMw+yf23btj17QJxtvTWymQLUi7CpCNnS7chKIeeQJZDLB8voQ7nT
   eApQ2/Dnw12VR2bd0FeXH8KdLKV2xW6/BnPexJaMW8eMcIeA0f2WNxtRk
   g==;
X-CSE-ConnectionGUID: gjNaqOxoSMKu2n+vZuk4rw==
X-CSE-MsgGUID: 3IZZWYowRxytJhZl3qKjBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78690618"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78690618"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:45:49 -0700
X-CSE-ConnectionGUID: GZTtNbivQxSecGNk4u4Cpw==
X-CSE-MsgGUID: ZSHJZfEgS4aClLwmXRJ1oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233542862"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.42])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:45:44 -0700
Date: Thu, 30 Apr 2026 15:45:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	brgl@kernel.org
Subject: Re: [PATCH v4 1/2] ACPI: provide acpi_bus_find_device_by_name()
Message-ID: <afNO9Ub3qaOYLxUr@ashevche-desk.local>
References: <20260430-baytrail-real-swnode-v4-0-767bcda6667f@oss.qualcomm.com>
 <20260430-baytrail-real-swnode-v4-1-767bcda6667f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-baytrail-real-swnode-v4-1-767bcda6667f@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 30, 2026 at 09:34:05AM +0200, Bartosz Golaszewski wrote:
> Provide a helper allowing to locate an ACPI device by its name.

...

> +/**
> + * acpi_bus_find_device_by_name() - Locate an ACPI device by its name
> + * @name: Name of the device to match

 *
 * Caller is responsible to put_device() on the returned object
 * when it is no more needed.

Or use whatever wording that is already present nearby and around similar
cases there.

> + *
> + * Returns:
> + * New reference to the matched device or NULL if the device can't be found.
> + */

-- 
With Best Regards,
Andy Shevchenko


