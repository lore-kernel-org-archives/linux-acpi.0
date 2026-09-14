Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673B477E3B;
	Mon, 14 Sep 2026 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391510; cv=none; b=cDPTu2ecBdPFomhsycJHKy8ZElQJ9hoSRtNHtMm9n2a1pbTdhUlbafbpWyoBeA358W4e8B5fiREGMlSgQNmEUFNzpfiVBW25roqG9YsSDwkJ0vUYP6ECF6Hk71fUNLELwp6lJM21oQiba0NGPC1b5cGllBA+t0ACbhbwx5PusFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391510; c=relaxed/simple;
	bh=QdgDviqxQFEnP/DuV30dRUXhxcyHcSESyVJHflvqqsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkxlVOXex2BiG1qwxZ/0HXzAoTfRD2tGxyqJ8aNH/8Zvsu6L2wlnHORtWNKDufHhURgZOz8flws22VSCoPT7xmixf7wyFq/8B9HSk5FZefXQWbE/OR/p7R0fIpB3q0cwn3V7CPJottGL1pO0LQpS+oB+jnIoV8HBBtXH0QeIdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikGJk97D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikGJk97D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789391509; x=1820927509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QdgDviqxQFEnP/DuV30dRUXhxcyHcSESyVJHflvqqsU=;
  b=ikGJk97DbKVG/174ooukl7bsw4cNQ8DpU87uW6JF/Agc03LuC75omSAz
   re2K0/4ckbg0ImzP7cxbociorReTGdMIANKj3Z3hs/EItJ4fC0U5ryNR5
   djAQ5ceTvYWk/j8HbBERMglEKFfQTnengvrQPZVRBQzlJN9I6fRij31wl
   ocKK58gW2wPEFBX3Zee6uWRBBbb5uyrSPffIx5fZSdtlL1vT/aElEbfaz
   GM9dREZ36sF5rBRfvBNZ4HZ8NTbAeKTMHG/3OdI+Af/Z9KfMaJ12419jG
   NLQnWSyVJlsi3nRjbzdHd/L5JY5H83RSugPhZN4v+lsMOU72/ywu6/B/N
   w==;
X-CSE-ConnectionGUID: QkJFcYO5RmqhCdGKoTMQew==
X-CSE-MsgGUID: HcRzwxVYRPmmnOZlkR9Srg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="88682369"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="88682369"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 06:11:48 -0700
X-CSE-ConnectionGUID: znlbFcHhSi2uXKb2ZngVLA==
X-CSE-MsgGUID: xuUktpnjTBGxJxWEi+akKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="266427968"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 06:11:46 -0700
Date: Mon, 14 Sep 2026 16:11:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Garcia <miguelgarciaroman8@gmail.com>
Cc: rafael@kernel.org, u.kleine-koenig@baylibre.com, kmehltretter@gmail.com,
	corbet@lwn.net, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: device-id: document struct acpi_device_id
Message-ID: <aqfyj9saFPR2K8j2@ashevche-desk.local>
References: <20260913095111.2543502-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913095111.2543502-1-miguelgarciaroman8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 13, 2026 at 11:51:05AM +0200, Miguel Garcia wrote:
> struct acpi_device_id lacks kernel-doc, so extracting documentation from
> its header describes ACPI_DEVICE_CLASS but not the matching table entry.

ACPI_DEVICE_CLASS()

> Document the four members, ID and class-code matching, and the table
> terminator. This complements the pending documentation header-split
> update without changing its include directives.

> An LLM drafted this comment and changelog after being asked to address
> the missing documentation noted in the header-split discussion. The
> field descriptions were checked against the ACPI matching code. The
> extracted documentation passes kernel-doc and a focused Sphinx HTML
> build with warnings treated as errors; checkpatch reports no warnings.

This paragraph is more for the comment, no need to include as is into
the commit message.

...

> +/**
> + * struct acpi_device_id - ACPI device matching table entry
> + * @id: NUL-terminated hardware ID (_HID) or compatible ID (_CID) to match.
> + * @driver_data: Data private to the driver.

> + * @cls: PCI-defined class, subclass and programming interface code (_CLS).
> + * @cls_msk: Mask selecting the class-code fields to match.

Hmm... The only driver which uses this is AHCI. Yeah, that's fine, of course,
but might be that in the future we can replace that with a traditional list of
_HID:s, who knows...

> + * Use @id for ID matching or ACPI_DEVICE_CLASS() for class-code matching.
> + * Terminate the table with an entry whose @id is empty and @cls is zero.
> + */

-- 
With Best Regards,
Andy Shevchenko


