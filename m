Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaY/nxrd"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38F6A7;
	Thu, 14 Dec 2023 03:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702553290; x=1734089290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8P2DmvTYt9Ql0vuLL0KEMLs+5zqY+u1T7WEG1CiG2Fw=;
  b=ZaY/nxrdGcoMEtGab9/5j3LMKjwhv7yfovj/3jrvpBlZOneeM0CO/wDg
   nrzIX984hPYFM9O7ZB+7i5dGmsAU+o1SJkECO79JUd3NNX5nB1t0Y7UFy
   RsKQNDUqCzpUe37voKduVgyfO4IH+yKaAuDZ9TczmyI6DTiSpW9RiTfdf
   rh1P9q/LunyXxC+ErpU/Ugg955Cgd4h1OYUH2MayWm9bEP/4uIumWtLdK
   bd6ZWq0J+ZqQyEFCuq/KkRSKEaaVQ27CYKsE96nxIlx5Geknf91r9dKai
   piHy/YRAv4lTSfOMq8AoLyICsfF1+hUuIFfucZTGeLpqHUnTGPcwupBUZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="385520104"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="385520104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:28:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="918025281"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="918025281"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2023 03:28:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A3C8644A; Thu, 14 Dec 2023 13:28:07 +0200 (EET)
Date: Thu, 14 Dec 2023 13:28:07 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ACPI: utils: Introduce helper for _DEP list lookup
Message-ID: <20231214112807.GU1074920@black.fi.intel.com>
References: <12358058.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12358058.O9o76ZdvQC@kreacher>

On Thu, Dec 14, 2023 at 12:07:55PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI LPSS driver and the Surface platform driver code use almost the
> same code pattern for checking if one ACPI device is present in the list
> returned by _DEP for another ACPI device.
> 
> To reduce the resulting code duplication, introduce a helper for that
> called acpi_device_dep() and invoke it from both places.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
