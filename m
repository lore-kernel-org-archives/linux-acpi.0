Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05FB3783DB;
	Sat, 28 Mar 2026 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774690212; cv=none; b=sC7fJtRYE1MhMEG9NLVhZOLSWruqlw1I8WRzqV9pzWqJ5rGkDXF0d30sHLeYG63qQ6BA1vfmZYTLvtcUi46KWMM2VPI636aNz9Frz0C5aBBaXxdxedl7wL3nZ6cUMNTERxRvJ0kzuT7qfMgncox6E51xQMIWkDge+kqaSfVR5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774690212; c=relaxed/simple;
	bh=ZIN3K4vAZh3AbifESV3YvOZ2UBDwIgV0cDjy1tNXvQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrKj+X5im4DpRx9Gn9sqIlTrZvHnDKbtQ/Tzco0DoAkKFL10ow9UsDG2le1teVKS8lMWmELcl1SDRhLuvHYI9pwa/PJM4RM3ydr/69y3Zb6HHf27tZaY0y1rvblv8SvMMHFGK9xWBfDDi3E9GaoBbCinSa9ymQ5Vu56EztkLGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwYKXg3G; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwYKXg3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774690207; x=1806226207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZIN3K4vAZh3AbifESV3YvOZ2UBDwIgV0cDjy1tNXvQ0=;
  b=HwYKXg3GDgfK23O9DJaQ5Iaz6MNpliB/1uMWvtOVy0vP7IP0yIx4IsHm
   1hHySCcvgAdDix0ZR+thH3JKbxrWDBi8Pri3lc6voQbYqd4frOUR2a6Z0
   TL8d/BN0wFcKcJVvnnuLpFMjBUfXEyFtILg2avnX8YcCI/K0StOEZfWgf
   GBaY79y8MNjuurWtk3mDLoBX4WbESarpQEfluS5CtTwXl+LSOGzAugm9s
   iUYy7levgNlvVUwofPgT9pMtdYdBeGc9WmdPD+Nw+1hmfvSK0YtqZi51K
   UCPx1RZrngFYdzfTmHDl0S2qee0U3nRREIt2z6ampVuksSsL6lU03KdQ5
   w==;
X-CSE-ConnectionGUID: xL2qoIjxS5muyH/LT3MTRw==
X-CSE-MsgGUID: DlxQXf0dT9+6fDqmEZ1Zqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75722002"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="75722002"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 02:30:05 -0700
X-CSE-ConnectionGUID: begHELPwQrmwIbfPmJ5N3w==
X-CSE-MsgGUID: gTghySnRSh+1Dz4nJQtBgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="256047578"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 28 Mar 2026 02:30:03 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6PzU-000000007ev-0K6O;
	Sat, 28 Mar 2026 09:30:00 +0000
Date: Sat, 28 Mar 2026 10:29:43 +0100
From: kernel test robot <lkp@intel.com>
To: Padmashree S S <padmashreess2006@gmail.com>, rafael@kernel.org,
	tony.luck@intel.com
Cc: oe-kbuild-all@lists.linux.dev, bp@alien8.de, guohanjun@huawei.com,
	mchehab@kernel.org, xueshuai@linux.alibaba.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Padmashree S S <padmashreess2006@gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: make einj_initialized static
Message-ID: <202603281058.fgnC9vIy-lkp@intel.com>
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
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260328/202603281058.fgnC9vIy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603281058.fgnC9vIy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603281058.fgnC9vIy-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "einj_initialized" [drivers/acpi/apei/einj.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
