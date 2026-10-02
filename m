Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313C2110E;
	Fri,  2 Oct 2026 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915774; cv=none; b=KqXrws8N3pkFSwT5wmtFmqUgP8XyID0uw8PRd1oaMPOFXIhS1VGmOZ+uQ9KTkrwvuswMNLSxPCXHRHqUzlbPvPXoUi/c4DytweNC3B6kdEhFdJykom8iesCILW1C3wNXS2AkJE/UHDCnp4aZwABG7EkBRw0ryiRsRZCoTHRJ7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915774; c=relaxed/simple;
	bh=ID4KO+UjhO4DpJR95GHQ1KZJ+lCimhFuLVkB4Pb2BzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPJDyRFXFM+qmqam1QxhaOF6OM7msijpcD95Jv6a2GyranZV4vWyN1mSWpXxbaiL9zpIJmvd8Jikpprs5BPhZcBaA38ItZuNrhQi1suDd06xKATbrkcY20GAPqsTKUk0Ve59qwS3ZZwBd+NJxixdliyDdBFWe5BhJDoHld4rHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVaHt75H; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVaHt75H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790915772; x=1822451772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ID4KO+UjhO4DpJR95GHQ1KZJ+lCimhFuLVkB4Pb2BzM=;
  b=DVaHt75H51+RsPEDGpl0M4nShRECeFJ4oG0GrhRBYMr0JiunzZGcvKtR
   Ql9PTbH6dylL38AgpaTQiaeKXEac0CcjmQHYpIAzvKwOCjbvexEeAEi8s
   Sc9THiJ8VswOdt0jvs4T+iokmLhEmWo+2HINz8luFwZ41CwoHLxX/HLVV
   Bv0ahG/iyMurmyxt0BqRbVaIBka1DPMIt1vS+kE/sgs5V0PSVbBP4Cvr7
   OUCzvZhTiazPBKDLMGB9qZEuBoogVV4z1zis020mDmSadmxjwMFM9Omeg
   5U4zyR8L2zAPaZDrbrIB2LaSOzOD7qFA9ILU6ohP8Lde76IuXWL3vrOsI
   Q==;
X-CSE-ConnectionGUID: j3b15shESaW/brZdqwWtbA==
X-CSE-MsgGUID: 09iKkmzmTrKipDrEllP70A==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="79240154"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="79240154"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 21:36:11 -0700
X-CSE-ConnectionGUID: wpPO79/gQXyTO0QvTv4H3g==
X-CSE-MsgGUID: xKr/NR2gReuoYPYilGeLHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="272575952"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2026 21:36:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id DB59899; Fri, 02 Oct 2026 06:36:08 +0200 (CEST)
Date: Fri, 2 Oct 2026 06:36:08 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alban Bedel <alban.bedel@lht.dlh.de>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Fix GPIO lookup using relative path
Message-ID: <20261002043608.GE176164@black.igk.intel.com>
References: <20261001152343.1995157-1-alban.bedel@lht.dlh.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001152343.1995157-1-alban.bedel@lht.dlh.de>

On Thu, Oct 01, 2026 at 05:23:43PM +0200, Alban Bedel wrote:
> ACPI allow to use relative path in resources, pass the device handle
> to acpi_get_gpiod() to allow resolving such path.
> 
> Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>

Acked-by: Mika Westerberg <westeri@kernel.org>
