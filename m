Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767393A451E;
	Thu, 20 Aug 2026 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209696; cv=none; b=hQEIr8mOWvDBjV+HB6ABJ9O+yKT23ekEVhTTVM0Ttm5Gsjg/RjqnhSyhQvHNoNb/cc5gduYaW5ZPf6SFxWbSoG+gPqJmqgS6szbhZwgVrmq+YERwAz90PNar5MS2nWuw8728uPqnVfcYi600f8v5d2RLdlhtYk2AitIRBv1kV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209696; c=relaxed/simple;
	bh=RB4iJc8U90ire5vLiFfUfbO8g7vzff0zB3s16jOos1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijOBFmHEUxtD9KAcZedm1siBqsmbStian9DelBMMnGnqDoVs0Atkww5XLlli7o2TOocOK/p2THZ8XA2Hs7t8UxQnGlkDtOJehEuTCR3rVthPTXmc4rPIJ6z1U2NZwZ+qDKMsguBdkiiY/i2vmAbP84NPZTrUuWoMjpMEzqYYVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MM69+KBH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MM69+KBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787209695; x=1818745695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RB4iJc8U90ire5vLiFfUfbO8g7vzff0zB3s16jOos1w=;
  b=MM69+KBHfoQrhZYUknTf6qC9+tv1qjpPFyjj2yKCYFxbW9kGQGLYIDL7
   EMcOodocjvuCUFoN2TKJGCsyZeaD++O7l/mnPc0QKNOzawFY5LoXSeE3O
   Iuv9dUHyAcgGgOYXlAjaq/iOlN/9RXqxG9sMB6hHaMVSXXMn3XCHRTkho
   28BkJQjcuiCxOcJPuRxzN511QG18sw4vULkNA6DVsP1uqOGi6YxawZBqI
   RKesQF2X8CcG4qTgpBh+zQJfskl1NUY5hicumk0w/DNbiGvVmy11898SR
   +kdb4MIW2L105XR+CuufYiHz66xq3aYRmUZaut2VipfWKwr/I6cBFa+Jy
   w==;
X-CSE-ConnectionGUID: AreubvxpT/WCZ0Jy71/bNg==
X-CSE-MsgGUID: z5NAcUhRTMuRP4MTW6AGHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="113274264"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="113274264"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 00:08:14 -0700
X-CSE-ConnectionGUID: LntU9oBCRKOlRn8m2yHVqw==
X-CSE-MsgGUID: 8lScQ2nASu6KrgmbxsubXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="261643636"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Aug 2026 00:08:12 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwwsj-00000000iBZ-3U2V;
	Thu, 20 Aug 2026 07:08:09 +0000
Date: Thu, 20 Aug 2026 15:07:13 +0800
From: kernel test robot <lkp@intel.com>
To: Baorui Liu <baorliu@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Len Brown <lenb@kernel.org>,
	Mario Limonciello <superm1@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	Baorui Liu <baorliu@amd.com>
Subject: Re: [PATCH] ACPI: button: Report wakeup key only for power button
 wakeups
Message-ID: <202608201432.sqYAY4nF-lkp@intel.com>
References: <20260806122732.533-1-baorliu@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806122732.533-1-baorliu@amd.com>

Hi Baorui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4d823c9d06aaa91476b58e56e4d44c4112da2811]

url:    https://github.com/intel-lab-lkp/linux/commits/Baorui-Liu/ACPI-button-Report-wakeup-key-only-for-power-button-wakeups/20260806-202732
base:   4d823c9d06aaa91476b58e56e4d44c4112da2811
patch link:    https://lore.kernel.org/r/20260806122732.533-1-baorliu%40amd.com
patch subject: [PATCH] ACPI: button: Report wakeup key only for power button wakeups
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608201432.sqYAY4nF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201432.sqYAY4nF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201432.sqYAY4nF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:27:
>> include/acpi/button.h:18:52: warning: 'struct acpi_device' declared inside parameter list will not be visible outside of this definition or declaration
      18 | static inline void acpi_power_button_wakeup(struct acpi_device *device)
         |                                                    ^~~~~~~~~~~


vim +18 include/acpi/button.h

    17	
  > 18	static inline void acpi_power_button_wakeup(struct acpi_device *device)
    19	{
    20	}
    21	#endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
    22	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
