Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE5348463;
	Thu,  7 May 2026 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138726; cv=none; b=PNMpvNqDyhszNmCdK+dIlkXWhszyC2Nv14ai56WWmTiZIljHzI1oBU1fYldVh1HhUL3bHchlZ/j8Vx1BO0baQgxFRYisXd3u3rjpYp2TcyqPYTniFIpDfwXeigT1gTNKqYxpa2KMy1ZJSzDqt4T9DjYV0ACDyzHPS84IWQni/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138726; c=relaxed/simple;
	bh=pL59kLZ0TSRXYpk6p6E3c7Sc5FErfiqpx3+I4G0LGnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjhEckd6fLlXik9DRsM81Coq+iIbbEgj0qFQSnCDcZVg+m/5aZbuHRPrCV4BQJf+fwjTUcJ1uoG5V/eIMZKuL3P24roiLXSEXkMAK1eSBrcuOl8P8B5UEQj7yST+EO9gDvcTEOL5Y6cJfB5NqzcH9fFkdqr9PhmUWYzkQs3fL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAsTnxA7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAsTnxA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778138720; x=1809674720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pL59kLZ0TSRXYpk6p6E3c7Sc5FErfiqpx3+I4G0LGnI=;
  b=gAsTnxA7bK/6EYCfwmGs+P0+qP3k6j32niGEZE7glrfGrKiwos3TKl9D
   u3jL0YZL3M5Hhx/lo44S/cxq5ITEeGUVGqKQTUFj4AIFZ9u03K0hAgvun
   X74FAs0QnWe7nTdxPMduz+5tj4RxKxgNbeoIEKugxYicRtYLfF37+VDkG
   SAoSAaKnBbLy/Qu1Tg8JK0BYLsDa9UiraagTC7f8SL8uOrhifxtTJlKpG
   RVXv0Z0ruwtoAiMOjIMER7j3jg7QSI25ieE4tSo4EKin8nfh+ZU1A3LDL
   7xg9ZoegXQTD3MUCOuh3KM+bBLEYpF1FsVpnIuqZg1ZGX4QjU3sQ2D1zN
   w==;
X-CSE-ConnectionGUID: XnvElsFARyWHAFjT9Jin4g==
X-CSE-MsgGUID: UFO4kQigTRusgKMc2RSAIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82925999"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="82925999"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:25:19 -0700
X-CSE-ConnectionGUID: Ob8Pgo+sSH6yhS8/poQHgg==
X-CSE-MsgGUID: M4OUYidHTWKCr8w03KSK/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="229995422"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:25:16 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8949711F8DF;
	Thu, 07 May 2026 10:25:14 +0300 (EEST)
Date: Thu, 7 May 2026 10:25:14 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	brgl@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in
 fwnode_init()
Message-ID: <afw-Wtz-yOWqLUl1@kekkonen.localdomain>
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>

On Wed, May 06, 2026 at 01:57:00PM +0200, Bartosz Golaszewski wrote:
> If a firmware node is allocated on the stack (for instance: temporary
> software node whose life-time we control) or on the heap - but using a
> non-zeroing allocation function - and initialized using fwnode_init(),
> its secondary pointer will contain uninitalized memory which likely will
> be neither NULL nor IS_ERR() and so may end up being dereferenced (for
> example: in dev_to_swnode()). Set fwnode->secondary to NULL on
> initialization.
> 
> Cc: stable@vger.kernel.org
> Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
