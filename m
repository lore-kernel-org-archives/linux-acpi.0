Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313A403AF8;
	Tue,  4 Aug 2026 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883489; cv=none; b=CTA6kCiY2knurZvABEzm3xMBLLQ2iyj6izk6IZWt0d4OE873p1IYoCIFwgAtVwJcwn8c1vwpng5jt8m1gTn8JL8J4/xdC0JMcscznUhrnCws2vZouFJ1ZcNMr4MC5RihGZKv8LQAje+kBC20yuAqo6T5ip5TXVoloQT7P8/o8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883489; c=relaxed/simple;
	bh=r0IphEcOPyKhSzCbbNGFOF/2AOB7cy6Ae1oYJmaozMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt4o9I+5omSuBR4LnHTUbjbPgIi0KIx8q9M/cQqmpmqadkcIPsnw3EcUOIX/IBI5vKxlTlIjXgqugQTG5q61kyfBeDhzhc6MJu5dCE3sczwX4ddDzax+Qwcv5Znp3FqmqsLb6k0d4wvIK5Fn/8KWno4mFKx35uragH7Hl34/bEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgDX/v2C; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgDX/v2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785883487; x=1817419487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r0IphEcOPyKhSzCbbNGFOF/2AOB7cy6Ae1oYJmaozMA=;
  b=LgDX/v2CGPsktaBrjxEu9rfO0v1eiPmXAGHzTWuzDchYvfK434HUyo7J
   UWfCDNeoPi1l5YXWc/i9utg2dLUtvLid8n2kv3Mt64D+i2/atimpakqGo
   RmvVq9jWfAsGj6LLGZ1xdYhAZQRjlf4sBkZykkwsU5IjtZzOUTXZAJvl9
   Qfc4svJVFTPdLOSxn+7AtW5c1UHJ0/45Mm0AGvohItCsAplpAn9k6jobj
   lVMKgfhMTpkxV7Nl4hMtpeV1h03elnhc0w3yamj5eg6B+LokINIFKxnyD
   0c2PIapphYMQGecpyFb4nYvOK/K6vp3HeSCJzo+oQryeCvHStYQXx3Yyj
   Q==;
X-CSE-ConnectionGUID: DJl9+bqoTQCjBeHb5La/Qg==
X-CSE-MsgGUID: xy/ZaBN7SUm03pcEt6Lpdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="73984239"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="73984239"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:44:47 -0700
X-CSE-ConnectionGUID: R4wZhYeLT1O44/n7kqKaRg==
X-CSE-MsgGUID: J83z7p5MR3qt3Vv/yfTBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="285004034"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 04 Aug 2026 15:44:44 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrNsH-000000004HK-3UxA;
	Tue, 04 Aug 2026 22:44:41 +0000
Date: Wed, 5 Aug 2026 00:44:27 +0200
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: IORT: validate RMR node array bounds
Message-ID: <202608050045.wC3xEg9O-lkp@intel.com>
References: <20260706094300.82618-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706094300.82618-1-pengpeng@iscas.ac.cn>

Hi Pengpeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v7.2-rc6 next-20260804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pengpeng-Hou/ACPI-IORT-validate-RMR-node-array-bounds/20260804-123552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260706094300.82618-1-pengpeng%40iscas.ac.cn
patch subject: [PATCH] ACPI: IORT: validate RMR node array bounds
config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260805/202608050045.wC3xEg9O-lkp@intel.com/config)
compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608050045.wC3xEg9O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608050045.wC3xEg9O-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/arm64/iort.c:199:13: warning: 'iort_rmr_node_valid' defined but not used [-Wunused-function]
     199 | static bool iort_rmr_node_valid(struct acpi_iort_node *node)
         |             ^~~~~~~~~~~~~~~~~~~


vim +/iort_rmr_node_valid +199 drivers/acpi/arm64/iort.c

   198	
 > 199	static bool iort_rmr_node_valid(struct acpi_iort_node *node)
   200	{
   201		struct acpi_iort_rmr *rmr;
   202	
   203		if (node->length < sizeof(*node) + sizeof(*rmr)) {
   204			pr_err(FW_BUG "Truncated RMR node in IORT table\n");
   205			return false;
   206		}
   207	
   208		rmr = (struct acpi_iort_rmr *)node->node_data;
   209		return iort_node_array_valid(node, rmr->rmr_offset, rmr->rmr_count,
   210					     sizeof(struct acpi_iort_rmr_desc),
   211					     sizeof(*node) + sizeof(*rmr),
   212					     "RMR descriptor");
   213	}
   214	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
