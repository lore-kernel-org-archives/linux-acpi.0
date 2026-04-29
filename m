Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809D3C2781;
	Wed, 29 Apr 2026 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456513; cv=none; b=K00I5J8M31ms1Ky9Ino4gtyxLZ/H9ZTtD/RofZR211p64D8Oz3dqMvF7h3E3C2iTLfkf/3kX+6xYhQ6OeaxpIzhJ728z1YlkYQ2UGsYREx7jxdia8qh0MZXkIC8zK97NXJa38hayzeBcyamaMwukQYEIXeaDyEm+mQc1ZslG5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456513; c=relaxed/simple;
	bh=i4g81PTUWusksn1VQRzddmbepw6SAMy/nja9wr1wz90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU/8yjUahdNryCg19DQWxhRiZCkN1LC634Q9TPv/+lzRN42cEDC4S5yGAoe9rMKkdoCPqCl0GSiZmxCsibEZoEp+OLi/leCmV7NVKJqa698Adk0/UbWmWLpM1cdjENXa9n3bURUlC4JXhEiqcGycE04lvJ3Tfh3uE4GAT12Kmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mu6n6WG7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mu6n6WG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777456511; x=1808992511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i4g81PTUWusksn1VQRzddmbepw6SAMy/nja9wr1wz90=;
  b=mu6n6WG7KyZMIa3YKijYvCnMcJrvBRrox7md4Qywo0mrqNXkijoFAois
   chhzOh1TtS/Ct0EIMGAk0S1IyE77Ha7tFtDiubvnDldXUdGuulr3+TNrD
   u1DNxwfjgG4eZObxAqvEWVrMlGh8cROh1Zr2squCB7S01yiN72znUQz9P
   quCUwQ9ZnPuREhD463EWEDOl4IbI+1kdHNzK1NYah0R5TfHPvdNYIhAtw
   Xdq8KV6krWumRzYimeJ/L2FNWjyMJyA/jp65F6XQPeUAbihTOglQO1eG+
   NKyzp3Oi/SaIzxmeRgxl1B6QWhCgjHnKIuBGphdGNcDFiHP72ZyMw/eYw
   Q==;
X-CSE-ConnectionGUID: 8F12m61FRA2UaBEkRlqwKA==
X-CSE-MsgGUID: 9CrC1yvnR26zzk54V8k52w==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="81988636"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="81988636"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:55:10 -0700
X-CSE-ConnectionGUID: HRYMlwjTTN6DeGUPpzjDiA==
X-CSE-MsgGUID: fazMivYyT5aEbTQxcewUSg==
X-ExtLoop1: 1
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:55:08 -0700
Date: Wed, 29 Apr 2026 12:55:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, andy@kernel.org, westeri@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: pmic: Replace mutex_lock/unlock() with
 guard()/scoped_guard()
Message-ID: <afHVeVavSJ2NZ480@ashevche-desk.local>
References: <20260429012432.120830-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429012432.120830-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 08:24:32PM -0500, Maxwell Doose wrote:

...

>  v4:
>  - Added else keyword to if statement in
>    intel_soc_pmic_exec_mipi_pmic_seq_element() per Andy's request.

Nope, sorry if I was not clear. The idea is to drop 'else'.
Also make the patch less invasive.

...

> -			       __func__, i2c_address, reg_address, value, mask);

> +				__func__, i2c_address, reg_address, value, mask);

Still a stray change.

...

It should be

	int ret; // also left untouched, drop that from commit message as well

        if (d->exec_mipi_pmic_seq_element) {
		// the below if-else-if just should be left untouched.
		if (i2c_address == d->pmic_i2c_address) {
			...
		} else {
			...
		}

		return ret;
	}

	if (d->pmic_i2c_address) {
	}

	...warnings...
	return -EOPNOTSUPP;

We may get a second patch for deeper refactoring later on.

-- 
With Best Regards,
Andy Shevchenko


