Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781347;
	b=qa35aGtlt8puGUQ8LT4dAKObqZixf9/ttAKnmxpn10+Pe6QqHz3rlaO7NKWM+mqs7mhG
	 8ji3Nmko1zegn/ztGlBs3rM5Rb4SzgqPSi7eU6P20sLcJquFOnDGapXFx4Smd2tZDLpm8
	 ErwosdFrOV0aUJI6f/AYgwmX4k9+vPcYvDyOaHpdSpnr+N/C4ozrBlbt07r5+3MJr5gHm
	 GQK1XlGzjEONcVNA+iuQlNK9oMSjwM0Enck9ngaRofoI+fyugwL2fbqXn7ZGPSeMONgrP
	 z0GWQnAMk1xhaxtOugVZDdG+qUGrrC8QMoj0dLSMavrFIMLTLQSzdUegWxmMzQLH/kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781347;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=/uMLBHxWohgE/F8ooDLhRcSeD3BAuoZ4IO/H8eSEi0E=;
	b=p6lMkXa9GYYvR57foBj/x2zyMD9/UW4jmUTu0GMvwqQms2GL/EDQVlyxIGFTV5StM4ig
	 g9qH/H56bhXYnrzm1kOYaIjOwXr2Ja/xr5bHze9YaluaYsw6NjD5l0HIVArs/K8GCwN3H
	 fQBGpSjWGhPCA2BLGCgSx5UiXDMMWutuwpprJHKrj8ZOcieST9s3tq5D/lApYBcH5yWge
	 uf0H3anr6tfAjOjZ0fTrsvv+16JmsmlMLIl07Jh3tF0wGtG1JJNgRCahhZ2Q4gikp0IDl
	 exk82mEKhoTnIJMoQCvxqsPXherphg8fOYgSpNSpS58pHO5Sf36T1f6p0lXiwOadXJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ax2z4BTc;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B1606A31B;
	Wed,  4 Nov 2026 08:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9B1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ax2z4BTc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793781348; x=1825317348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uKOSyayJx9+QMQNFXoH1UFqc1dN/TFUA+vdki/ypgVA=;
  b=Ax2z4BTcJsZW5iId9Ba8RI7mhgVPfFeA7Iyp5eXhh4b4uLvhLt+dqskr
   xIDHiISOHYotFpndRh+OErYnmK+uEZGfpVGK/ayQNhLEyQ4ybwKMcQNSt
   p771caOP9CSp8OeCUU/Os9RodAEEfv5x5irH+YiFDYZiLUe5ugcFu/HJd
   NVWGouyC3IHZACmJCxIrgHwVEnlCfneHgeDZh8JimIv9hnCgs37711pwx
   6bqvKK8pq8ib2wojB9i0gS3mCg2UN/ssnEwENdVF4+1MZ6FUo1C3n+NE5
   t/OjzWAv6I05xi3P3G2vZagVgV4snwQ9twkPSlBGtxkFUUctNJlc9g1GC
   g==;
X-CSE-ConnectionGUID: qLHR8Zg9TAGbwDKUxdRrSQ==
X-CSE-MsgGUID: UP72V06RQ8uE2jnI5bncfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2525259"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2525259"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:35:47 -0800
X-CSE-ConnectionGUID: Umcevaq5RXio3yCNslldBg==
X-CSE-MsgGUID: hNKdN2YWRw+PUKv+CqpZNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="7217576"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:35:43 -0800
Date: Wed, 4 Nov 2026 10:35:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Vivekanandan, Balasubramani" <balasubramani.vivekanandan@intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <auruXXGTDMU1wcwU@ashevche-desk.local>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
 <aurU5Z1CNl87uMrU@bvivekan-mobl1>
 <aurqev-AgiGYo5DT@ashevche-desk.local>
 <aursSlF3yRXrBPjH@bvivekan-mobl1>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aursSlF3yRXrBPjH@bvivekan-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 01:56:50PM +0530, Vivekanandan, Balasubramani wrote:
> On 04.11.2026 10:19, Andy Shevchenko wrote:
> > On Wed, Nov 04, 2026 at 12:17:01PM +0530, Vivekanandan, Balasubramani wrote:
> > > On 02.11.2026 16:25, Bartosz Golaszewski wrote:

...

> > > > Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> > > > Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
> > 
> > > > ---
> > > > This is my approach at addressing the bug reported by Vivekanandan
> > > > directly in driver core. Please test it if you can.
> > > > ---
> > 
> > > Reviewed-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> > 
> > Thanks, would it be possible to test this?
> 
> Tested it already. Kernel crash is fixed.

Thanks, but we expect a formal Tested-by tag. Reviewed-by is only about how
we read the code.

-- 
With Best Regards,
Andy Shevchenko


