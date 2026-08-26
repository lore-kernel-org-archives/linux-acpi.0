Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDD2882D6;
	Wed, 26 Aug 2026 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727848; cv=none; b=CIVBn8rzTi9TxbiE1hvobzosF9AFO/K3cZOkQAxP1lDBdvSpSbsxsmLg256pKPWlfT5d2c2CbYQCdsED4Drfm8WwvSJQMeKEpQU3j6IMXYFxZ3ourZ6or52hpZRNknwjgbARTbEV2wALHdydqIPQbf9Mc85cb9M4zvzQCDycp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727848; c=relaxed/simple;
	bh=22JDLPCvqO9mQwJ1JEhz+5Eo1o/r95PMdiTc+1EfyKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4sXKDfLq70RcYqxbRRAJsaQgJbr+pX9cvls0mBTNusSXluhF1gjCsH8EA81rvk6iHfWgU4FVSYTmh3/55cObsa1BPXZq3Y6Iblu8i8N9YaoeNw40mhFmuwHLwVmgNZLqdiMCMpsvgrwb4pkCVjefODNFKRhUv0BlKNf/ZEavAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTcVUh0h; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTcVUh0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787727847; x=1819263847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=22JDLPCvqO9mQwJ1JEhz+5Eo1o/r95PMdiTc+1EfyKM=;
  b=QTcVUh0hVCQjOp1jCFZezX5J1jLer47loBEneXc6PePWmGbGGzerJWrx
   OdbCBVAiaCpLxyT7T4zB3z109eKRcfKfC9Z5ETCD3T1LfsI1IOMBPNR6J
   AwpXAPOetrgySYIL7EMXM3FD0Tjs9bF23LoEXAcre/sVOAatBLfvdb/lP
   QbgahVtsC+m56nqQbaAXK47dRhbUkgEUTTKjDfJKzXXDNvyOwYl93Z2iN
   QIWi1Z3QD1RoWDlmSPzrZpY9zlkv7sGf0xmmvWJ2y07nHBYTKxuHNm5wC
   JQ7J9hTYDDcieaYurm6iEICAhc2PGbO932jmx97++ImQqR4Vg7w9lafZG
   Q==;
X-CSE-ConnectionGUID: 0SkBbaknQbejaX0AIPgZuQ==
X-CSE-MsgGUID: IEto+oa5Rz6iIeISz91Mag==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="105728439"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="105728439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:04:06 -0700
X-CSE-ConnectionGUID: Nju8ON1tQA6WA8wt0VPP3w==
X-CSE-MsgGUID: g9fkz5xIRbWsjJ6Taqn7xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="264901564"
Received: from abityuts-desk1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.215])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:04:04 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E7EB611F961;
	Wed, 26 Aug 2026 10:04:16 +0300 (EEST)
Date: Wed, 26 Aug 2026 10:04:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: linux-media@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/3] platform/x86: int3472: Fix uninitialised variable
 warning
Message-ID: <ao6P8POpBLSDOZSI@kekkonen.localdomain>
References: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
 <20260825203553.3725132-3-sakari.ailus@linux.intel.com>
 <CAPybu_1J4z2Z0Xv1PyHZa2U+PFsTWPVyifJr2p8DgkQRTJm6YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_1J4z2Z0Xv1PyHZa2U+PFsTWPVyifJr2p8DgkQRTJm6YQ@mail.gmail.com>

Hi Ricardo,

Thanks for the review.

On Tue, Aug 25, 2026 at 11:04:51PM +0200, Ricardo Ribalda Delgado wrote:
> nits:
> 
> It would be nice to have the error message that it is fixed in the
> commit message (also for 1/3)

There's actually a compiler warning on this, too. I'll reword this being:

Fix a compiler warning about an uninitialised err_msg variable by printing
the error where it is handled:

drivers/platform/x86/intel/int3472/discrete.c:440:24: warning: ‘err_msg’ may be used uninitialized [-Wmaybe-uninitialized]
  440 |                 return dev_err_probe(int3472->dev, ret, err_msg);

> 
> Would you consider adding a Fixes? This patch fixes a compilation
> error (with the right kernel config)

Fixes: 5de691bffe57 ("platform/x86: Add intel_skl_int3472 driver")
Cc: stable

It seems it's always been there but I think it's a false positive: the
compiler probably just can't figure out err_msg is unused if ret is
non-zero.

-- 
Regards,

Sakari Ailus
