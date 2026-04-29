Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB43F54C9;
	Wed, 29 Apr 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464528; cv=none; b=d/t/eshGeq+b6e8FS61/A3wVtWobptV7d0B7//No1LCb5BKHCYjeUfFe+5LEHbZ6f6crqnIF8vQntEzRJpdxTz00UizBcPmIos1fYC2NiJpAaH1Hatfg/uCBTivgJcw0/6OnKiG09BXMgyQ+jizEag6Lx0AUzMirw8zUXIEwm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464528; c=relaxed/simple;
	bh=ftfT6M3bcClOthlHU6MH+1n0wwxkUuOIK4O84BZqI+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO4bNCrw26fZNgFaYMW/E7Ft9VD5BwqCn5vuJZ9ek0Ht7GFOm+DxolcrMlb7+nZ4noEe8UbB25o3wS/6F4Xs4GEyVUDFKxEQ0WNKmrEccUcbyA53FVr6tWPr+NRiBw6l1iAJaurlfFPtwqIua/R65Mw+jkozrOzfQko+cdjvLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKOn7i2+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKOn7i2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777464525; x=1809000525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ftfT6M3bcClOthlHU6MH+1n0wwxkUuOIK4O84BZqI+Q=;
  b=iKOn7i2+2glu/u2GYE46+3nWn9YEz78OV6tXMHQjh4lph1amzzhKrqdb
   5BcABHq2w2sYNYmIl6Ur4Y64R7uxEpPQiPjlRSzjE5sz/fpavBv1wC0hF
   60Uz6ciy3/xyktAx2fCfWVw0SNQud3s+z1Jhh4cCnY9DBj6Im4a6VvjW6
   d7090dl12dsNW/DliVFzjm8QJ/svtE6DtGGU+B00UdWmGSwW500xcBYoI
   xHnGXQqO8EG38FHFbN+JtNmf4nzvlxBeNNEqXSGM/OZurMXxBBirfvUBl
   xEEXaef7YHu1oIri4gaeEXGZNV+2xvri63Cw2CuMqS08fzDYRSpdTuGjO
   Q==;
X-CSE-ConnectionGUID: fgHWG4MZTIC+/gAWf5FUtA==
X-CSE-MsgGUID: xhCJ6An8Rhm0iduRj95hRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="101052167"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101052167"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:08:45 -0700
X-CSE-ConnectionGUID: DP57z2dnQ/ynTRC1HYGUfg==
X-CSE-MsgGUID: IUpH19rkSoiZQ29VMHzRog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229903168"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2026 05:08:42 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wI3iZ-00000000B12-3y12;
	Wed, 29 Apr 2026 12:08:39 +0000
Date: Wed, 29 Apr 2026 20:08:34 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Doose <m32285159@gmail.com>, rafael@kernel.org, lenb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: pmic: Replace mutex_lock/unlock() with
 guard()/scoped_guard()
Message-ID: <202604292034.cYbHcCIM-lkp@intel.com>
References: <20260424035501.219946-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424035501.219946-1-m32285159@gmail.com>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v7.1-rc1 next-20260428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Doose/acpi-pmic-Replace-mutex_lock-unlock-with-guard-scoped_guard/20260424-192647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260424035501.219946-1-m32285159%40gmail.com
patch subject: [PATCH] acpi: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260429/202604292034.cYbHcCIM-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260429/202604292034.cYbHcCIM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604292034.cYbHcCIM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/acpi.h:11,
                    from drivers/acpi/pmic/intel_pmic.c:9:
   drivers/acpi/pmic/intel_pmic.c: In function 'intel_pmic_power_handler':
>> include/linux/cleanup.h:302:9: error: pasting "class_" and "&" does not give a valid preprocessing token
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:70:9: note: in expansion of macro 'guard'
      70 |         guard(&opregion->lock);
         |         ^~~~~
>> include/linux/cleanup.h:302:9: error: 'class_' undeclared (first use in this function); did you mean 'class'?
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:70:9: note: in expansion of macro 'guard'
      70 |         guard(&opregion->lock);
         |         ^~~~~
   include/linux/cleanup.h:302:9: note: each undeclared identifier is reported only once for each function it appears in
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:70:9: note: in expansion of macro 'guard'
      70 |         guard(&opregion->lock);
         |         ^~~~~
>> drivers/acpi/pmic/intel_pmic.c:70:26: error: 'struct intel_pmic_opregion' has no member named 'lock_t'; did you mean 'lock'?
      70 |         guard(&opregion->lock);
         |                          ^~~~
   include/linux/cleanup.h:302:17: note: in definition of macro 'CLASS'
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                 ^~~~~
   drivers/acpi/pmic/intel_pmic.c:70:9: note: in expansion of macro 'guard'
      70 |         guard(&opregion->lock);
         |         ^~~~~
>> include/linux/compiler.h:165:17: error: expected ';' before '__UNIQUE_ID_guard_200'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |                 ^~~~~~~~~~~~
   include/linux/cleanup.h:302:27: note: in definition of macro 'CLASS'
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                           ^~~
   include/linux/compiler_types.h:16:23: note: in expansion of macro '___PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^~~~~~~~
   include/linux/compiler.h:165:9: note: in expansion of macro '__PASTE'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^~~~~~~
   include/linux/cleanup.h:422:22: note: in expansion of macro '__UNIQUE_ID'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:70:9: note: in expansion of macro 'guard'
      70 |         guard(&opregion->lock);
         |         ^~~~~
   include/linux/cleanup.h:302:41: error: pasting "class_" and "&" does not give a valid preprocessing token
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                                         ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:70:9: note: in expansion of macro 'guard'
      70 |         guard(&opregion->lock);
         |         ^~~~~
   include/linux/cleanup.h:303:17: error: pasting "class_" and "&" does not give a valid preprocessing token
     303 |                 class_##_name##_constructor
         |                 ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:70:9: note: in expansion of macro 'guard'
      70 |         guard(&opregion->lock);
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c: In function 'intel_pmic_thermal_handler':
>> include/linux/cleanup.h:302:9: error: pasting "class_" and "&" does not give a valid preprocessing token
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^~~~~~
   include/linux/cleanup.h:441:14: note: in expansion of macro 'CLASS'
     441 |         for (CLASS(_name, scope)(args);                                 \
         |              ^~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
>> include/linux/cleanup.h:302:9: error: 'class_' undeclared (first use in this function); did you mean 'class'?
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^~~~~~
   include/linux/cleanup.h:441:14: note: in expansion of macro 'CLASS'
     441 |         for (CLASS(_name, scope)(args);                                 \
         |              ^~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:33: error: 'struct intel_pmic_opregion' has no member named 'lock_t'; did you mean 'lock'?
     183 |         scoped_guard(&opregion->lock) {
         |                                 ^~~~
   include/linux/cleanup.h:302:17: note: in definition of macro 'CLASS'
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                 ^~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
>> include/linux/cleanup.h:441:27: error: expected ';' before 'scope'
     441 |         for (CLASS(_name, scope)(args);                                 \
         |                           ^~~~~
   include/linux/cleanup.h:302:27: note: in definition of macro 'CLASS'
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                           ^~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
   include/linux/cleanup.h:302:41: error: pasting "class_" and "&" does not give a valid preprocessing token
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                                         ^~~~~~
   include/linux/cleanup.h:441:14: note: in expansion of macro 'CLASS'
     441 |         for (CLASS(_name, scope)(args);                                 \
         |              ^~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
   include/linux/cleanup.h:303:17: error: pasting "class_" and "&" does not give a valid preprocessing token
     303 |                 class_##_name##_constructor
         |                 ^~~~~~
   include/linux/cleanup.h:441:14: note: in expansion of macro 'CLASS'
     441 |         for (CLASS(_name, scope)(args);                                 \
         |              ^~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
   include/linux/cleanup.h:424:28: error: pasting "class_" and "&" does not give a valid preprocessing token
     424 | #define __guard_ptr(_name) class_##_name##_lock_ptr
         |                            ^~~~~~
   include/linux/cleanup.h:442:14: note: in expansion of macro '__guard_ptr'
     442 |              __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);       \
         |              ^~~~~~~~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
>> drivers/acpi/pmic/intel_pmic.c:183:31: error: 'struct intel_pmic_opregion' has no member named 'lock_lock_ptr'
     183 |         scoped_guard(&opregion->lock) {
         |                               ^~
   include/linux/cleanup.h:424:36: note: in definition of macro '__guard_ptr'
     424 | #define __guard_ptr(_name) class_##_name##_lock_ptr
         |                                    ^~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
>> include/linux/cleanup.h:442:34: error: 'scope' undeclared (first use in this function)
     442 |              __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);       \
         |                                  ^~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
   include/linux/cleanup.h:426:30: error: pasting "class_" and "&" does not give a valid preprocessing token
     426 | #define __is_cond_ptr(_name) class_##_name##_is_conditional
         |                              ^~~~~~
   include/linux/cleanup.h:442:45: note: in expansion of macro '__is_cond_ptr'
     442 |              __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);       \
         |                                             ^~~~~~~~~~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
>> drivers/acpi/pmic/intel_pmic.c:183:31: error: 'struct intel_pmic_opregion' has no member named 'lock_is_conditional'
     183 |         scoped_guard(&opregion->lock) {
         |                               ^~
   include/linux/cleanup.h:426:38: note: in definition of macro '__is_cond_ptr'
     426 | #define __is_cond_ptr(_name) class_##_name##_is_conditional
         |                                      ^~~~~
   include/linux/cleanup.h:450:9: note: in expansion of macro '__scoped_guard'
     450 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:183:9: note: in expansion of macro 'scoped_guard'
     183 |         scoped_guard(&opregion->lock) {
         |         ^~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c: In function 'intel_soc_pmic_exec_mipi_pmic_seq_element':
>> include/linux/cleanup.h:302:9: error: pasting "class_" and "&" does not give a valid preprocessing token
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:354:9: note: in expansion of macro 'guard'
     354 |         guard(&intel_pmic_opregion->lock);
         |         ^~~~~
>> include/linux/cleanup.h:302:9: error: 'class_' undeclared (first use in this function); did you mean 'class'?
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:354:9: note: in expansion of macro 'guard'
     354 |         guard(&intel_pmic_opregion->lock);
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:354:37: error: 'struct intel_pmic_opregion' has no member named 'lock_t'; did you mean 'lock'?
     354 |         guard(&intel_pmic_opregion->lock);
         |                                     ^~~~
   include/linux/cleanup.h:302:17: note: in definition of macro 'CLASS'
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                 ^~~~~
   drivers/acpi/pmic/intel_pmic.c:354:9: note: in expansion of macro 'guard'
     354 |         guard(&intel_pmic_opregion->lock);
         |         ^~~~~
>> include/linux/compiler.h:165:17: error: expected ';' before '__UNIQUE_ID_guard_203'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |                 ^~~~~~~~~~~~
   include/linux/cleanup.h:302:27: note: in definition of macro 'CLASS'
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                           ^~~
   include/linux/compiler_types.h:16:23: note: in expansion of macro '___PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^~~~~~~~
   include/linux/compiler.h:165:9: note: in expansion of macro '__PASTE'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^~~~~~~
   include/linux/cleanup.h:422:22: note: in expansion of macro '__UNIQUE_ID'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic.c:354:9: note: in expansion of macro 'guard'
     354 |         guard(&intel_pmic_opregion->lock);
         |         ^~~~~
   include/linux/cleanup.h:302:41: error: pasting "class_" and "&" does not give a valid preprocessing token
     302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |                                         ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:354:9: note: in expansion of macro 'guard'
     354 |         guard(&intel_pmic_opregion->lock);
         |         ^~~~~
   include/linux/cleanup.h:303:17: error: pasting "class_" and "&" does not give a valid preprocessing token
     303 |                 class_##_name##_constructor
         |                 ^~~~~~
   include/linux/cleanup.h:422:9: note: in expansion of macro 'CLASS'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/acpi/pmic/intel_pmic.c:354:9: note: in expansion of macro 'guard'
     354 |         guard(&intel_pmic_opregion->lock);
         |         ^~~~~


vim +70 drivers/acpi/pmic/intel_pmic.c

    49	
    50	static acpi_status intel_pmic_power_handler(u32 function,
    51			acpi_physical_address address, u32 bits, u64 *value64,
    52			void *handler_context, void *region_context)
    53	{
    54		struct intel_pmic_opregion *opregion = region_context;
    55		struct regmap *regmap = opregion->regmap;
    56		const struct intel_pmic_opregion_data *d = opregion->data;
    57		int reg, bit, result;
    58	
    59		if (bits != 32 || !value64)
    60			return AE_BAD_PARAMETER;
    61	
    62		if (function == ACPI_WRITE && !(*value64 == 0 || *value64 == 1))
    63			return AE_BAD_PARAMETER;
    64	
    65		result = pmic_get_reg_bit(address, d->power_table,
    66					  d->power_table_count, &reg, &bit);
    67		if (result == -ENOENT)
    68			return AE_BAD_PARAMETER;
    69	
  > 70		guard(&opregion->lock);
    71	
    72		result = function == ACPI_READ ?
    73			d->get_power(regmap, reg, bit, value64) :
    74			d->update_power(regmap, reg, bit, *value64 == 1);
    75	
    76		return result ? AE_ERROR : AE_OK;
    77	}
    78	
    79	static int pmic_read_temp(struct intel_pmic_opregion *opregion,
    80				  int reg, u64 *value)
    81	{
    82		int raw_temp, temp;
    83	
    84		if (!opregion->data->get_raw_temp)
    85			return -ENXIO;
    86	
    87		raw_temp = opregion->data->get_raw_temp(opregion->regmap, reg);
    88		if (raw_temp < 0)
    89			return raw_temp;
    90	
    91		if (!opregion->lpat_table) {
    92			*value = raw_temp;
    93			return 0;
    94		}
    95	
    96		temp = opregion->data->lpat_raw_to_temp(opregion->lpat_table, raw_temp);
    97		if (temp < 0)
    98			return temp;
    99	
   100		*value = temp;
   101		return 0;
   102	}
   103	
   104	static int pmic_thermal_temp(struct intel_pmic_opregion *opregion, int reg,
   105				     u32 function, u64 *value)
   106	{
   107		return function == ACPI_READ ?
   108			pmic_read_temp(opregion, reg, value) : -EINVAL;
   109	}
   110	
   111	static int pmic_thermal_aux(struct intel_pmic_opregion *opregion, int reg,
   112				    u32 function, u64 *value)
   113	{
   114		int raw_temp;
   115	
   116		if (function == ACPI_READ)
   117			return pmic_read_temp(opregion, reg, value);
   118	
   119		if (!opregion->data->update_aux)
   120			return -ENXIO;
   121	
   122		if (opregion->lpat_table) {
   123			raw_temp = acpi_lpat_temp_to_raw(opregion->lpat_table, *value);
   124			if (raw_temp < 0)
   125				return raw_temp;
   126		} else {
   127			raw_temp = *value;
   128		}
   129	
   130		return opregion->data->update_aux(opregion->regmap, reg, raw_temp);
   131	}
   132	
   133	static int pmic_thermal_pen(struct intel_pmic_opregion *opregion, int reg,
   134				    int bit, u32 function, u64 *value)
   135	{
   136		const struct intel_pmic_opregion_data *d = opregion->data;
   137		struct regmap *regmap = opregion->regmap;
   138	
   139		if (!d->get_policy || !d->update_policy)
   140			return -ENXIO;
   141	
   142		if (function == ACPI_READ)
   143			return d->get_policy(regmap, reg, bit, value);
   144	
   145		if (*value != 0 && *value != 1)
   146			return -EINVAL;
   147	
   148		return d->update_policy(regmap, reg, bit, *value);
   149	}
   150	
   151	static bool pmic_thermal_is_temp(int address)
   152	{
   153		return (address <= 0x3c) && !(address % 12);
   154	}
   155	
   156	static bool pmic_thermal_is_aux(int address)
   157	{
   158		return (address >= 4 && address <= 0x40 && !((address - 4) % 12)) ||
   159		       (address >= 8 && address <= 0x44 && !((address - 8) % 12));
   160	}
   161	
   162	static bool pmic_thermal_is_pen(int address)
   163	{
   164		return address >= 0x48 && address <= 0x5c;
   165	}
   166	
   167	static acpi_status intel_pmic_thermal_handler(u32 function,
   168			acpi_physical_address address, u32 bits, u64 *value64,
   169			void *handler_context, void *region_context)
   170	{
   171		struct intel_pmic_opregion *opregion = region_context;
   172		const struct intel_pmic_opregion_data *d = opregion->data;
   173		int reg, bit, result;
   174	
   175		if (bits != 32 || !value64)
   176			return AE_BAD_PARAMETER;
   177	
   178		result = pmic_get_reg_bit(address, d->thermal_table,
   179					  d->thermal_table_count, &reg, &bit);
   180		if (result == -ENOENT)
   181			return AE_BAD_PARAMETER;
   182	
 > 183		scoped_guard(&opregion->lock) {
   184	
   185		if (pmic_thermal_is_temp(address))
   186			result = pmic_thermal_temp(opregion, reg, function, value64);
   187		else if (pmic_thermal_is_aux(address))
   188			result = pmic_thermal_aux(opregion, reg, function, value64);
   189		else if (pmic_thermal_is_pen(address))
   190			result = pmic_thermal_pen(opregion, reg, bit,
   191							function, value64);
   192		else
   193			result = -EINVAL;
   194	
   195		}
   196	
   197		if (result < 0) {
   198			if (result == -EINVAL)
   199				return AE_BAD_PARAMETER;
   200			else
   201				return AE_ERROR;
   202		}
   203	
   204		return AE_OK;
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
