Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1F3A542D;
	Mon,  4 May 2026 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892640; cv=none; b=W/lB81b0MKcpI5GGRi8492AU1/0++49U27y3MtdaVTZ52X2nk7RLb0ITSiCcC0xcSEQhYvSKZ8CfqmC0RWodMQOJCiUHenWPh2bS4v852jw6zBoipV++n3L2Hw5SicZIPqQmIdvq9Dtu0dEtI17DdH04/fLCf5LvCrnDgdueBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892640; c=relaxed/simple;
	bh=XC5hw9l5n+Yc6dUs8zLcR1At+vl5AcoyA6EL8K+FULM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S297GgKWsysv583BrDVrvgehS0rz8ejZFwwisYAKjbaOE2FGq8H3YetLc+mVS2JIfH9GzFW7CxsATFZEcnukLr0qOQqlNOBg+7I5s84DvE56oupcSoKIPNyMtSy2Ho21JBIF0fvW8qP3l+QTBnGwHlaVEqap3h4MRpxUwKWUeAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRNW1fhr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRNW1fhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777892640; x=1809428640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XC5hw9l5n+Yc6dUs8zLcR1At+vl5AcoyA6EL8K+FULM=;
  b=KRNW1fhrOLJEArsMvo6XgRmdHcLKlFL8zwRwSYVim9f+NKRMA1SKZvXd
   PYStAzrTEh73PziPhTlKv32QV0SG3WLae9DR7QZeKty/yh4KRu5GEJz0y
   oRA0EVmPeKqiw79ioD+iODP0neX/EFMg7bbIa5BFdTwYI8zUI5EHyPzEF
   TjFGt+89aNeWEAY3ftw4BTtYGyfnALj4ntlBRy2PHEL/5T6d0yCvaqCWP
   PVssLb0H7RDbRZKOoWuljt5JI7FuGK78fZcylBifX0eAAd8MpW+PUsSF2
   tLGMjnVydZtdzkfG1u/I4n/ail1PxGoI5iK4QSa6lo4YF5i+xCA6a7be5
   w==;
X-CSE-ConnectionGUID: cPa+oDIHTKuWcAUfqT7VJQ==
X-CSE-MsgGUID: j/ENBg0jSiekqP1bHMLdJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78610732"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78610732"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:03:58 -0700
X-CSE-ConnectionGUID: +sdGNIo0RTqs1g9KV8XngQ==
X-CSE-MsgGUID: Id5h40RoSK2pKftF/ks7dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="232339893"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:03:53 -0700
Date: Mon, 4 May 2026 14:03:51 +0300
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
Subject: Re: [PATCH v5 1/2] ACPI: provide acpi_bus_find_device_by_name()
Message-ID: <afh9F0uEkYKV5jVm@ashevche-desk.local>
References: <20260504-baytrail-real-swnode-v5-0-c7878b69e383@oss.qualcomm.com>
 <20260504-baytrail-real-swnode-v5-1-c7878b69e383@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-baytrail-real-swnode-v5-1-c7878b69e383@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 12:58:56PM +0200, Bartosz Golaszewski wrote:
> Provide a helper allowing to locate an ACPI device by its name.

Hmm... I thought Rafael gave you his Ack, but I may be mistaken.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


