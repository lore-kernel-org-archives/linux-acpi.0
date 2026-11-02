Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656080;
	b=zrBIKhCeGr59zS/xfq4CpOYeNoTa/Fwk6mrOu6H0VyPPhyteMhguguqLBZ9CaR0BWBSn
	 bHjA32l/1LWt6pwJY6uRGs/UMmTkoHHWeO9n4yUYETLN4RFgB6y4rIfMDNy5bs8bkOX3y
	 yRK9Pyzc3IgmzGIr3lEIxuXt491j35PloBxy0VIxR8d/3WBihCGeTK/9aOkd80mQi9+2+
	 AcCVRfW5/KHMFTy1YMIFKc0ELvpR+W3i3jHt4vfeejm2yZPxU473ehJ5arChBTpgBUvar
	 wOIQuEVuqfMqTLsgb4gjzfDC+COWRitbHmJ2Vwf99mQnUgUlFOTYenXZ5ue5Vj1udcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656080;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=aUDLACHlyrxhpmZGNWGB4QTE3dHwiL05kQfWOo8WH70=;
	b=Jc36XTc+CaxH8tB6QyHS7QVzm3JFthLB+u46gvUOASbF7EQVxw5HhofqkozHsYJXjTdN
	 Cm8JvoTVH9uOmi0Ej3+G3EV0eYNKFaPyKBR9XAe70j3Uz1voO7AaAb6CNOVJ3LrXji94H
	 g3QwjczcwuMjCYJ05ZARYJVtLBRs0LDKBJnQxOKsnh3NSXhCMVkaYyqFkI/ra1OR1r6CG
	 /eVEDDJyyxxczdcEUhqWF0MHCfzbBYSNFErsdurxuwMhPRHXk9JxwHcm5kB2cd9vtciN6
	 HsLPrQ35OXe5Rx5OKEfxLrWjs4aAquqfNhffDZMecXM718n4Pdp1S8avERtMR0ElhdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dCakfed5;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F1606A327;
	Mon,  2 Nov 2026 21:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D6F1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dCakfed5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793656079; x=1825192079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+k5sFKZYE6g5VogYmHeXbYF3Ix0grhxDoNMr2/mr34A=;
  b=dCakfed58714ri75L3jIu4VD2nyt3TxhKZ7JpQJnkATEghqT9tYpeza3
   iTdBb2okQc/k+Rw76YFzkxm165+euZVW/j2V8cuOIVZFwQsZRh6gUcYO4
   bUXkXBNsCFkOB3997+x5BV9Czz0R/zXXIntABTr9+PwJ+vUT++H6MSZi5
   LmFffW/Fob1eR52Io/Mwoc1IGqauttGtff8qfX5Pb6hV+fb/0XJviHnCv
   e164CERPLqo2MnEinN263dwEC4Jy2JKTIdUoCkBSiYiI9IxkANBkS1K+R
   h3FbXRyXxytzxcCBs2LAUat+s+yu8FkOAMqWMJdIegOMo2KxQQN93gUbc
   g==;
X-CSE-ConnectionGUID: duLhCtfpTUat+gcZ6oIhDQ==
X-CSE-MsgGUID: 8FdEYz7iTG2N58h+TzmMOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2373261"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2373261"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 13:47:59 -0800
X-CSE-ConnectionGUID: wkZDEhLfRpyproKLtvzocw==
X-CSE-MsgGUID: ZcDCcwAfR72GqeNUK/o4Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="8069525"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 13:47:57 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNzsg-00000000htI-0DiS;
	Mon, 02 Nov 2026 21:47:54 +0000
Date: Tue, 3 Nov 2026 05:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Baorui.Liu" <baorliu@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	kernel test robot <lkp@intel.com>, "Baorui . Liu" <baorliu@amd.com>
Subject: Re: [PATCH v6] ACPI: button: Report wakeup key only for power button
 wakeups
Message-ID: <202611030545.3st9p1ha-lkp@intel.com>
References: <20261102091049.856-1-baorliu@amd.com>
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
In-Reply-To: <20261102091049.856-1-baorliu@amd.com>

Hi Baorui.Liu,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baorui-Liu/ACPI-button-Report-wakeup-key-only-for-power-button-wakeups/20261102-171049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20261102091049.856-1-baorliu%40amd.com
patch subject: [PATCH v6] ACPI: button: Report wakeup key only for power button wakeups
config: arm64-randconfig-1001-20261102 (https://download.01.org/0day-ci/archive/20261103/202611030545.3st9p1ha-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611030545.3st9p1ha-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611030545.3st9p1ha-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:27:
   include/acpi/button.h:28:15: error: unknown type name 'bool'
      28 | static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
         |               ^
   include/acpi/button.h:30:9: error: use of undeclared identifier 'false'; did you mean 'else'?
      30 |         return false;
         |                ^~~~~
         |                else
>> include/acpi/button.h:30:9: error: expected expression
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:


vim +30 include/acpi/button.h

    17	
    18	/*
    19	 * Set in acpi_suspend_enter() when the fixed power-button status bit is
    20	 * observed (IRQ-disabled context). Consumed by the button driver on resume
    21	 * so KEY_WAKEUP can be reported without calling into the button driver from
    22	 * that early path. Implemented in sleep.c (built-in); safe when
    23	 * CONFIG_ACPI_BUTTON=m.
    24	 */
    25	#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
    26	bool acpi_sleep_pwr_btn_wakeup_pending(void);
    27	#else
    28	static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
    29	{
  > 30		return false;
    31	}
    32	#endif
    33	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
