Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A536998A;
	Tue, 24 Feb 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923822; cv=none; b=YkKFTsVyEWwNnlbL8VccMHhWRVAO7J7ISbaUY6TWEKsQuB4IrCaYhtZ0LeJzqi/ikVS55wI79IU1ucRp9LNNbYYnWWaYyXdkg8L51Fi4KWpF20x9aO403Zqete6OqWx9DPASHUzuZ8DbUuhwB7+Cbf1McKGpVEuF+G2ww2gZQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923822; c=relaxed/simple;
	bh=2gpEbsePqK4vNA+6hYPIJwHlkROFkEq9QgR4xhFm6jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3BKFnOQRfbm9w/ypowsn4/l67D7qeJkKj5gNpDB2OtdL8e7AhKip+6UhgWdlQhu16GohWJe5Km4fykIMJVhD4WpUK/uvq/bDnn4PzW6BzzOrM73tRa78NvZK5KfunI3LNQAVV8PhC8UZwy40QwgU79cAWWDV16WMHSY3KuIumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqbZoQ1g; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqbZoQ1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771923822; x=1803459822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2gpEbsePqK4vNA+6hYPIJwHlkROFkEq9QgR4xhFm6jk=;
  b=OqbZoQ1gjfyAP9rl2UNX3qmLQV539xuduMphnnlhtbd8pS/j4KvF+aDz
   L/26gZ7/oUFO98x9+2ibfIXR1Ptw7cbZI9GRci0EjjmieBOR52A/Z41l7
   RtqXdRdYGr6NZXnv5BeXkRjunRKjoaOMGBcrVL/sUSQh4Elyz0OAnPUsg
   V+TVtydmQdWMislS3bMXmssSEFHX1WU0d6s1gCkE4VlsFeXAM/G1prKuL
   7ULssYtlkENhJI4BnQjfBS7HRdPk5eGDG8QJPT2EV/ofZeULi/usM09lI
   N8YHWuGQ+RGfbw4qAFtZ+MHhLOxq9pGuIqLClARErySgm6o3PluMyj0x7
   A==;
X-CSE-ConnectionGUID: PQq9/N2uSgmP7XKAqLcjYw==
X-CSE-MsgGUID: /AY8rt8lQeSp4pnF2UOqrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73039188"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73039188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:03:41 -0800
X-CSE-ConnectionGUID: QjWVuc03RcqGO4FMyW+1DA==
X-CSE-MsgGUID: 4ONdD0zxRp+2CwOU7JZbkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="219935720"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:03:38 -0800
Date: Tue, 24 Feb 2026 11:03:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 3/3] driver core: Split device related fwnode API to
 device/fwnode.h
Message-ID: <aZ1pZ1UM2IqihAbg@smile.fi.intel.com>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-4-andriy.shevchenko@linux.intel.com>
 <2026022443-cornmeal-overstock-cd70@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022443-cornmeal-overstock-cd70@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 01:33:21AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 23, 2026 at 09:30:32PM +0100, Andy Shevchenko wrote:
> > device.h is a huge header which is hard to follow and easy to miss
> > something. Improve that by splitting device related fwnode API
> > to device/fwnode.h.
> > 
> > In particular this helps to speedup the build of the code that includes
> > device.h solely for a device related fwnode API.

> You lost the copyright notice.  While not really needed from a legal
> point of view, it's not all that nice from a developer point of view :(

Oh, it wasn't my intention, thanks for catching this!
Sure, I will address this important issue.

-- 
With Best Regards,
Andy Shevchenko


