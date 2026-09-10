Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0682FFDFC
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001752; cv=none; b=jCKImfNLVujTX6jUl/dKnzuyS+zDKkgxC0uNQhtriUE5nvvRJDBguyTnreJM5a1Fp86/Ow66Jyk1bUZrG4UWWJttxzQovfak0AOQEzqLEwBI31Lf4P8w8CnTkzE10yV9nI2r53Xzuw0lSTDjI6wDyYvPYgRVyFtB3ttc49tFSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001752; c=relaxed/simple;
	bh=SNUeng/BOkTzRfB4VBOIQAX1w1b7DHzT0zxXmfeGcc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np4pumh8ryv6zX6+M3Bo7VTfR1EUfANgV9eY5FNOpuZjQkGZYyNQ0mHn1xVD/ZX90mCp2g4nQFz2fd+WWZEiPUCwFqkX8xyjc6DlEsU8n0CvEV7xeUbNIcAl7afhwgjEGwUdSiEs/C6edHY3p+EDfP8WDV98xIkm/vlEWlLF0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoFEAOcN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoFEAOcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789001751; x=1820537751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SNUeng/BOkTzRfB4VBOIQAX1w1b7DHzT0zxXmfeGcc0=;
  b=VoFEAOcNa59v+iY+y8aBMEiugPZOn0sq5U6Oq0O5uBlnM4VDCEfdOKG5
   ATGIEVaUR4kYCaMwDWGWwTLZW+9eEi9d2PhKCN/EodBwARReJOp0PHCts
   w5FZIhpnPUQ4NDED2osdO5dPJjibHNZqQ3crHu8ReYypBlA6Y9f6gnpJB
   e7O+j+hOtptqhkj7FgyAv+L0lrfmeoP8pQe+g3F+COp/pM8j66JkC7n4B
   AE/m8ylLq/CPGgtxE2ZqG5xeFkweQxGC+/e9Y/TnrVwc5Et2R9MIXsX/9
   CMYIKEodyTtjDAqlkO1J+nLEhTnPorXOQUl3I9SRNE4nLbFj2NHKQtl8L
   Q==;
X-CSE-ConnectionGUID: TOw73lwqTSe01E4F/zMXBQ==
X-CSE-MsgGUID: Ms6hEzHnTKKdWQ6O3KtM/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93133281"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="93133281"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 17:55:51 -0700
X-CSE-ConnectionGUID: dHAqgPlbSXmfdxpMdpq46A==
X-CSE-MsgGUID: O1xENvRhSsuvse1238AnGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="275242206"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Sep 2026 17:55:49 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4T4s-000000001Ay-2r3O;
	Thu, 10 Sep 2026 00:55:46 +0000
Date: Thu, 10 Sep 2026 08:54:55 +0800
From: kernel test robot <lkp@intel.com>
To: Li Jun <lijun01@kylinos.cn>, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ACPI: button: replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
Message-ID: <202609100827.qM0GkvjX-lkp@intel.com>
References: <20260908014645.4165221-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908014645.4165221-1-lijun01@kylinos.cn>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v7.3-rc2 next-20260909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Jun/ACPI-button-replace-SIMPLE_DEV_PM_OPS-with-DEFINE_SIMPLE_DEV_PM_OPS/20260908-094645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260908014645.4165221-1-lijun01%40kylinos.cn
patch subject: [PATCH] ACPI: button: replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
config: i386-randconfig-061-20260910 (https://download.01.org/0day-ci/archive/20260910/202609100827.qM0GkvjX-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260910/202609100827.qM0GkvjX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609100827.qM0GkvjX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/button.c:164:12: warning: function 'acpi_button_suspend' has internal linkage but is not defined [-Wundefined-internal]
     164 | static int acpi_button_suspend(struct device *dev);
         |            ^
   drivers/acpi/button.c:167:49: note: used here
     167 | static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
         |                                                 ^
>> drivers/acpi/button.c:165:12: warning: function 'acpi_button_resume' has internal linkage but is not defined [-Wundefined-internal]
     165 | static int acpi_button_resume(struct device *dev);
         |            ^
   drivers/acpi/button.c:167:70: note: used here
     167 | static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
         |                                                                      ^
   2 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_SOC_SDCA_HID
   Depends on [n]: SOUND [=y] && SND [=m] && SND_SOC [=m] && SND_SOC_SDCA [=m] && (HID [=n]=y [=y] || HID [=n]=SND_SOC_SDCA [=m])
   Selected by [m]:
   - SND_SOC_RT766_SDCA_SDW [=m] && SOUND [=y] && SND [=m] && SND_SOC [=m] && SOUNDWIRE [=m] && SND_SOC_SDCA [=m]


vim +/acpi_button_suspend +164 drivers/acpi/button.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  163  
e71eeb2a6bcc62 Rafael J. Wysocki 2014-07-23 @164  static int acpi_button_suspend(struct device *dev);
1be532de834ab7 Rafael J. Wysocki 2012-06-27 @165  static int acpi_button_resume(struct device *dev);
d02d5d6f0a061f Li Jun            2026-09-08  166  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
