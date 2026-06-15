Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8733B2FDD;
	Mon, 15 Jun 2026 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552703; cv=none; b=cQaRQ/FSz2PVBnFJU3+MJkj+hFWuKBuYJ4Dj5zw3IhY7ip4ZMvbpdmziaQYkdmZn1qCq8xFQ3iJ6pOIO9zyTdxpwarA4RjZZbUztCZQ4dCH8hluhTil30hAI+O/85gg2X05h/ZjnD9vaiB9WjFBbpxMNq/01h9oLOh+MBfLA5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552703; c=relaxed/simple;
	bh=6A7/TKhNXTrjhM8YrCcOswyRqBSZfi5KD2KistyDfxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smk54QaiHaWEVgxiyGrPdZKgfnf7tS/50b38WBAe+GdOYb/SUGAcRAe13bpch2Il854bWm5Tzr4jNY+hlFjNdOBPvTSQXT8nlZASy8VgO59PNGaV8wVKrQW7wYp7e+NOotoYcOijGufG7DaOcnrR0VIUiBkUWg6FZsKviD87hVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVWje9zG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVWje9zG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781552702; x=1813088702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6A7/TKhNXTrjhM8YrCcOswyRqBSZfi5KD2KistyDfxU=;
  b=YVWje9zGL44ssN0a5jrz4ziSBDZw6WfcPDvCBskvmuaRkZ+239kyX4am
   02U0duMMDOzxJRitCv+1/+fU1Mh04MjnJqNzhqG8N3uLTfbeLwfnETfZT
   8lH6MJyaxR3WoHmJAVyWK78iMpZiWGdHLmH36R9WY2OxmvkCs4VJjFfk9
   iwhfxCqJVyzuVxP+cGwKA5SqCwYC4/KXBnqqhQMeACkfq40f4c5pr6Pya
   IEj9sw19cHPxcpoQ3wHE04GZQpGVQscIAV+lk4RHHBcTL7iHxf+GjWoDx
   VWMzzVdDApYibDk/msA6Vh4ireToYJoybCRMemzIom0DhDOO64oEoIplN
   w==;
X-CSE-ConnectionGUID: +D0CSOAKRNSUOs5d4OPS6A==
X-CSE-MsgGUID: vbImozNfTaGh0RAt/xvuMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82200774"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82200774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 12:45:01 -0700
X-CSE-ConnectionGUID: dRKBKlU7SkGxJz/QYkoaDg==
X-CSE-MsgGUID: YV7o4/qXTji8ZKwZDpIdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="277749421"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Jun 2026 12:44:59 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZDEu-00000000SJ8-1y6y;
	Mon, 15 Jun 2026 19:44:56 +0000
Date: Tue, 16 Jun 2026 03:44:16 +0800
From: kernel test robot <lkp@intel.com>
To: lirongqing <lirongqing@baidu.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH] ACPI: processor: idle: Add __cpuidle to
 acpi_idle_lpi_enter
Message-ID: <202606160341.VjG95TFw-lkp@intel.com>
References: <20260615065401.4611-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615065401.4611-1-lirongqing@baidu.com>

Hi lirongqing,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v7.1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/lirongqing/ACPI-processor-idle-Add-__cpuidle-to-acpi_idle_lpi_enter/20260615-150110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260615065401.4611-1-lirongqing%40baidu.com
patch subject: [PATCH] ACPI: processor: idle: Add __cpuidle to acpi_idle_lpi_enter
config: x86_64-randconfig-072-20260615 (https://download.01.org/0day-ci/archive/20260616/202606160341.VjG95TFw-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606160341.VjG95TFw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606160341.VjG95TFw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> vmlinux.o: error: objtool: acpi_idle_lpi_enter+0x44: call to acpi_processor_ffh_lpi_enter() leaves .noinstr.text section

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
