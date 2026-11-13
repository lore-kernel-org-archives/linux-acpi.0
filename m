Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538303;
	b=KmzZZDjYy4+r5OQ6TGyx1hF/Mtn/HsU18odegBpjJMmyV9w6N/wbdRawaq6G1+UFGeu1
	 cohEIs84PL1CyOJ/avaEdav8eQQl80MI2pZam2kGv54GnEL9uTSR29bdTTbHogFgwQfP3
	 SVnZ1sbSiVrS6Kg2iPWqEZ5iAF/RJfAFcvN7oHp38cHrUmYyxLGzwbag6/IyxCnXOkld0
	 JM2wxhdq+fr/iA45BXRbt5rFgGyrD0MWEIPOYj1gmB1iwreYDXWBAlSD8FODMSu8NwVp5
	 gf4rOiGVosUW/mLQc2bKMlnaHrDsfwfv4u2Otcsw0HJO6Zn60NtNjgz1Rbo8Gzhx/bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538303;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9q3WecW58AVzVN8/3AXX3WSFjtoBFejU4UH87CoM6+E=;
	b=gQoeOgZCPb0AHmrSRTM9Rc9SFzqwFF8Mzo/nHNb9R7DwkDaRbcQXE+2xm9ygXo6y931g
	 HzLEaIJNyzGr0DO13n09stQ1RdWO2EMV4QdF+ToFqbNvmRMCNvKqDprO2ZQ+fFfK6n1yI
	 ITl9qdMp1xCAlE9maby7+GneRmJveVrE/2KQzHIMChTM7mO2EnKLHnFsFZdD9Us0xhxFm
	 YEkblw08o2aTuEQlD5X/O6d5m5+J254dZsM/tq+nPJGv063ZE62tD8t/GZNV87jHgBzj0
	 umowP5+FVp50RnerM8vgVSml1+p93vDIVHlhzoFsLYgvXLozti2DJmw51+JxUMMCzwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hmsndqWY;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6660A3817
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 02:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E6660A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hmsndqWY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794538303; x=1826074303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fxqpdnvOspyiKnPiU9wfiXKu4XCKOXuYAgetxr629AM=;
  b=hmsndqWYvkivvkd5QAKKNdThBIEvxKZTBSj7IyB9f8MoQh47ZsDHIbuE
   ZmMRjxDvbZbjmcuFm1pTtnHgD/Oicb742zMezAu4lz180Wr4ZxErgPnrT
   QHL1NaUR+CCl5PPJK96dLKr3ZZrzKaFMHLyRO/WL4ixXg+oqB0rzwylf0
   g5IG7E/JVELM5Xkh+kPfBqygWfwOJb2cxA7aBguCJYdnRuzuNab+bzWUn
   QsM4nVb2rei1W9TOULScQrEIfEc0rnxh6mtzeyKlRHkv5c0iTQ79ARWkM
   xVE7rrWaXbWB0WMPS8ec+93aqfUDUmdS04rXcxqHBQkH+O86WIQBfnYbO
   A==;
X-CSE-ConnectionGUID: j0q+J46xSnymxqouxl520g==
X-CSE-MsgGUID: LKfktrCMRAes+4LFQO++sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3232618"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3232618"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 18:51:43 -0800
X-CSE-ConnectionGUID: yPq+HySaSR+ZKVdZDROT3g==
X-CSE-MsgGUID: ajzsGcyWSYijWq20X5aymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8831933"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 Nov 2026 18:51:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRhO5-000000012L5-1qoW;
	Fri, 13 Nov 2026 02:51:37 +0000
Date: Fri, 13 Nov 2026 10:50:57 +0800
From: kernel test robot <lkp@intel.com>
To: Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Jamie Nguyen <jamien@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dat Mach <dmach@nvidia.com>
Subject: Re: [PATCH v2 3/3] firmware: arm_ffa: Share FF-A version negotiation
Message-ID: <202611131010.OMo0VbqM-lkp@intel.com>
References: <20261112-acpi_ffh_ffa-v2-3-575a9dbed22b@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-acpi_ffh_ffa-v2-3-575a9dbed22b@kernel.org>

Hi Sudeep,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7475ea8b58616b33c04afb976cf0fbaad9dd63fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudeep-Holla/firmware-arm_ffa-Share-FF-A-register-field-definitions/20261112-111406
base:   7475ea8b58616b33c04afb976cf0fbaad9dd63fb
patch link:    https://lore.kernel.org/r/20261112-acpi_ffh_ffa-v2-3-575a9dbed22b%40kernel.org
patch subject: [PATCH v2 3/3] firmware: arm_ffa: Share FF-A version negotiation
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261113/202611131010.OMo0VbqM-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 1b1fed44d3dcca649a9877915d57c3357a98124e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261113/202611131010.OMo0VbqM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611131010.OMo0VbqM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tee/optee/ffa_abi.c:8:
>> include/linux/arm_ffa.h:189:30: warning: declaration of 'struct arm_smccc_1_2_regs' will not be visible outside of this function [-Wvisibility]
     189 |         void (*invoke)(const struct arm_smccc_1_2_regs *args,
         |                                     ^
   1 warning generated.


vim +189 include/linux/arm_ffa.h

   182	
   183	#if IS_BUILTIN(CONFIG_ARM_FFA_VERSION_NEGOTIATION)
   184	int arm_ffa_version_get(void (*invoke)(const struct arm_smccc_1_2_regs *args,
   185					       struct arm_smccc_1_2_regs *res),
   186				u32 input_version, u32 *version);
   187	#else
   188	static inline int arm_ffa_version_get(
 > 189		void (*invoke)(const struct arm_smccc_1_2_regs *args,
   190			       struct arm_smccc_1_2_regs *res),
   191		u32 input_version, u32 *version) { return -EOPNOTSUPP; }
   192	#endif /* CONFIG_ARM_FFA_VERSION_NEGOTIATION */
   193	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
