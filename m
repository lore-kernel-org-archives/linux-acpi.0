Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E530F80C;
	Sat, 28 Mar 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705115; cv=none; b=SO0pfHxsQNqauLl9moTAcuCFVd3lQsfCuwBvyP1AYv5gLETSaIQG7H9PuOw/kwmdBT+E7x6z0vzB8PFxvrjbsvtWr33LMGfMvqSC4pt9DOOBHESwyYBJ15Qh036C/YImZXtl78RG50Yj3KRPb737st56IQ8ZEZGk4Vw7em94YcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705115; c=relaxed/simple;
	bh=byIR1qZKNcL1GXNXgyCdpE80OXp3a+M7PYrfwM4alSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkPfN2C8ppmsQjWeRIcXUGd5Y1pF4Vskxm9sSljC2xaScifbUtRbRBF/PirLcCFeaNgvo7HEM9wUEvLBz3PCX5fZMt97V4M8tgHhftfxUHBBy0dVxczXOMdOIiC3it5ixZQvLI8zhJj1EglV80yUgaQQ0wPUJ2sotZQqddDTAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVwUSQRS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVwUSQRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774705115; x=1806241115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=byIR1qZKNcL1GXNXgyCdpE80OXp3a+M7PYrfwM4alSc=;
  b=kVwUSQRSEOTdtzn58sppGQXUffky863+DheE1ozwasxu6mEqe7F91Tys
   mQm+NK9GM5wxCv65D/9JwBaJexlqof2qjJ2es1lWgdldTveT99kH2k8DX
   pc1fUJ59OifJHaXHHXBDD7PaXIptbNtdnpzwpj3E/vsmnMzQRBgXJWq59
   IBAX+Dkf8p6VfYa60psQaCHhLPtRo/i7hSdz8SgcesyEXnB13BakNzWVt
   dVU/CAd/zVYd5Lgy3wzHgbkG4tr4zxnRG+l3Z99wI23ceZj2qWMydyxpo
   LC5Nm25Ja/FsSKyptDlVccjE7s3LBmC0TvTVRyLKSe2i2c7BIFuuaC0T/
   Q==;
X-CSE-ConnectionGUID: mzk3YHW9R22yttJrnQPR9A==
X-CSE-MsgGUID: qpkOhzL2R9q7Q50fFlS9CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="93339218"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="93339218"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 06:38:34 -0700
X-CSE-ConnectionGUID: 1hTsr1//RK6XiVNed44YnA==
X-CSE-MsgGUID: tFYT2+qRTNCPiJcilD1dpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="222708780"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Mar 2026 06:38:32 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6Trx-00000000BS5-01Zx;
	Sat, 28 Mar 2026 13:38:29 +0000
Date: Sat, 28 Mar 2026 21:37:41 +0800
From: kernel test robot <lkp@intel.com>
To: Padmashree S S <padmashreess2006@gmail.com>, rafael@kernel.org,
	tony.luck@intel.com
Cc: oe-kbuild-all@lists.linux.dev, bp@alien8.de, guohanjun@huawei.com,
	mchehab@kernel.org, xueshuai@linux.alibaba.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Padmashree S S <padmashreess2006@gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: make einj_initialized static
Message-ID: <202603282131.etycgFYz-lkp@intel.com>
References: <20260325034626.405366-1-padmashreess2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325034626.405366-1-padmashreess2006@gmail.com>

Hi Padmashree,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v7.0-rc5 next-20260327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Padmashree-S-S/ACPI-APEI-EINJ-make-einj_initialized-static/20260328-022553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260325034626.405366-1-padmashreess2006%40gmail.com
patch subject: [PATCH] ACPI: APEI: EINJ: make einj_initialized static
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260328/202603282131.etycgFYz-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603282131.etycgFYz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603282131.etycgFYz-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "einj_initialized" [drivers/acpi/apei/einj.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
