Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64330148C;
	Wed, 25 Feb 2026 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012788; cv=none; b=JSoG7owGy3qx/918CSZTFMUxyZTBTqHp+7CKrHVyoiTbsnuUnBQLQDjGpCUZcQDOWw1ga2AZH7SVfYmn08CbkmfbeV90ZmXYwE3pq18iHwYfue4kNiVAol8Q8JFbCK9sVrPaoVffNslFMYyWXuP0JZlYiFy/4B5xqXqXaupb3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012788; c=relaxed/simple;
	bh=UyxVOZZKjo1Fz2nVZ2f03ruHHkkNClE7gaWf8zNTCZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxbMrP++nTKYoTRp5ZBOLp5VBYGaof9lBADF29PVrwdBQ1IAadtirKbC6bXxe1P0zUkY3Z1sbPjENJlvb/UMZwVc+mMNfIYmf9vAEKkmS5qz5FCeGjLLlBocAU9nYW5Wlf8WFiN28Sz53CrORlNQCO0VRKbLoOxgnB2PGMAvCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCJ1/HA/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCJ1/HA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772012787; x=1803548787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UyxVOZZKjo1Fz2nVZ2f03ruHHkkNClE7gaWf8zNTCZY=;
  b=dCJ1/HA/L/L7ZR1jiQ7vaCiygI1Rcw3WKIIlxXrXdw/rASzTpX3GfprU
   cS+OWIIp0wdCp2s9tiIywm3R8y2m/EEartSfhAXilCkzY2NGGiJAdgB6O
   2gO05QBshJO7WftLnuJy6gpExuUSt5Jh3+vOH7FzIAjKM8oYcWFSgj2tr
   9jvlsF9DZRyeqVQyqut6iuWx//YeHJIyXWBUtK6h5urg/BfwhXl+g7qlE
   WEtW6K4qezFK8D6vViF2cOTmBXRUm/r3kVWVi/Ryk4qIB2ys2VVtKQB+5
   O+DDyYu/KHdLHb6M5WuSkeBm8frgawyNHFfC3eCbnSYQUJveqky0ma/hR
   Q==;
X-CSE-ConnectionGUID: Y+NPt8sIQwWj9AlcRLMmcw==
X-CSE-MsgGUID: GSmwvS3wQKagSh1YDnNI+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="83369732"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="83369732"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:46:26 -0800
X-CSE-ConnectionGUID: QJ0bVMx/QSyr+1pd8LiDEw==
X-CSE-MsgGUID: DfVrYeRKSku3Y+/XgAJlow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="213325553"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:46:25 -0800
Date: Wed, 25 Feb 2026 11:46:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mike.isely@cobaltdigital.com
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] software node: Use-after-free fix in
 drivers/base/swnode.c
Message-ID: <aZ7E7q6vdUHW_Wj6@smile.fi.intel.com>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 01:19:21PM -0600, mike.isely@cobaltdigital.com wrote:

> Correct issue in drivers/base/swnode.c that can lead to use-after-free
> due to kobject reference counting error, which itself is due to
> incorrect behavior with the "managed" struct swnode flag in
> circumstances involving child struct device instances where the parent
> struct device is managing a struct swnode.
> 
> Use-after-free in this case led to an Oops and a subsequent kernel
> memory leak, but realistically it's kernel heap corruption, so any
> manner of chaos can result, if left unaddressed.
> 
> This was detected in kernel 6.12, verified also in kernel 6.6.  Visual
> inspection in 6.19.3 source (the latest as of right now) shows the

The latest is v7.0-rc1 as of time of the topic message.

> same issue.  The nearly trivial fix was verified in 6.12.  While this
> patches against 6.19.3, IMHO this is a candidate for all LTS kernels.

Thanks for the contribution, usually for a single patch there is no need
in cover letter. The comment block can handle this (the place after cutter
'---' line in the message with a patch).

-- 
With Best Regards,
Andy Shevchenko


