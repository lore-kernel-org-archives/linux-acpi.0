Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1BC388388;
	Mon, 30 Mar 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867705; cv=none; b=DZePwI0wy7Nza1qk/wiu9VZgYRiEQF7LOXHoVSMts/z7PCBlu+028DqcQgl5Pra9HKhj5BrPlwbGvSpIyRthh9kZd0AXJbpSdTrgCEB7P/cisbzIoU+7cnQ+9M165vDk2FVahbkRi83HjZDkLPr+Fb2QqsiKfPlUtuMDknbhpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867705; c=relaxed/simple;
	bh=qoEROf9eB0JbmV7TcREDRbEkHfLqtcPLInOGRaPpWH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJEM4jX7Xwuf/KMMHiXb1GecWkFtXypyJEa/3j5RZJ49J1jQA1zbcCqFLyGoQrvlrin4uGHjCxAP+uhK+BhVyY8zsGuZtfytmx4p8ONnb20md1tsifrTfsXwTz2PDLpaC2J7TfiAbpBcQUqAcea0rxCKbw8WnZ/rq0OSCiV0HjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYf0Q/71; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYf0Q/71"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774867702; x=1806403702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qoEROf9eB0JbmV7TcREDRbEkHfLqtcPLInOGRaPpWH8=;
  b=AYf0Q/71M0m/xfJH3AiMZtCAkGEMvUEhkVhSIOCgb3aQk9dJW8wftCPg
   27ZQJXzP1RYqfwShFKrH7a7hBWXNCa648wt1R0ciy3MgDpVzadcQgP5vV
   U+KYrqfvKIcpSf39hYQLYRtV2x/I5HWYND+P5hnUr6vcOf2/FU5FaPR5K
   j4xAKvPuNBocR+FFVbat4Hin5C/nUGjyfKe9JaQCG+8NNNFWJ2XSHojxU
   HHYHSI2ZFddG5VKvPkjCK3XFH5PoXyMgX/MxvEtwgSUwq03qckYpIM7jI
   t/1jX7AGfeTjDHCiRS3/MICQ/3XaQ1hV08CO/Ie6yOcgl8g7Lqk14TwkJ
   g==;
X-CSE-ConnectionGUID: XlMbb1J2TQmg+4Dfq58Jqg==
X-CSE-MsgGUID: g+xF1VxGQDW395DQ5IZLuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75753130"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75753130"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:48:21 -0700
X-CSE-ConnectionGUID: f0FjVNYqS5uDYD3d0GHDHA==
X-CSE-MsgGUID: Os1wDqYxR3uHuIAXFmIdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="249224910"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:48:18 -0700
Date: Mon, 30 Mar 2026 13:48:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 4/4] x86/geode: use PROPERTY_ENTRY_REF for GPIO
 properties
Message-ID: <acpU76DX4m7Vcq1c@ashevche-desk.local>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-4-3cca5ba136d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329-property-gpio-fix-v2-4-3cca5ba136d8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 29, 2026 at 07:27:51PM -0700, Dmitry Torokhov wrote:
> Now that the PROPERTY_ENTRY_REF macro can accept a pointer to struct

PROPERTY_ENTRY_REF()

> software_node_ref_args directly, we don't need to use the more
> cumbersome PROPERTY_ENTRY_REF_ARRAY_LEN(..., 1) variant.

...

> int __init geode_create_leds(const char *label, const struct geode_led *leds,

>  						       leds[i].pin,
>  						       GPIO_ACTIVE_LOW);

Wondering if we want to have a wrapper for the above like

#define PROPERTY_ENTRY_GPIO_REF(...)	\
	SOFTWARE_NODE_REFERENCE(...)

(naming most likely sucks, and yeah, it would make sense if name is shorter
 than the currently used one).

>  		props[i * 3 + 0] =
> -			PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &gpio_refs[i], 1);
> +			PROPERTY_ENTRY_REF("gpios", &gpio_refs[i]);

-- 
With Best Regards,
Andy Shevchenko


