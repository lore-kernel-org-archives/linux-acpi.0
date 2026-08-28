Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F53B813D;
	Fri, 28 Aug 2026 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946888; cv=none; b=VeM4oiw8xhD4whemQIhvEXHwpCTYMNEe9txKH5fESZTjX4+DSwcQNeI6AIK2aoJaNpDrTL2KFi+hxG1oUwcXMSfZhAQFw41LvAaVzD2m/SxWxEuAeC1de01UxoOn3rPLqsEH0q5CajLxNZwDFRh6PyBSsw/LE/Fprgd/t13gj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946888; c=relaxed/simple;
	bh=5iZX0wkpD+MNEcZhPumqgcBkerrHnfx/Lwndq8Q7CYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx8yoNgKRm45VaKgbShHnqNMZ1pBx2MokSWGPOhVQOE51bUCRJ75U0Bmvp530vJZOvH8V9L+HL8ddA4z9i31mBhd3iLBEA1ZJXnJOL2dBDMYj6pPxDuNr84E/Rw81f4IflqeInzmrhH5qJIdk8R6CnGxAcvomjNVcUZ4XsPqhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kipKh5fP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kipKh5fP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787946887; x=1819482887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5iZX0wkpD+MNEcZhPumqgcBkerrHnfx/Lwndq8Q7CYw=;
  b=kipKh5fP7z+mAHfOMRdX9OmOAwL7R1wLdUSIqMTvK8LwLhFT9Gk3E87P
   2zVzWVhuSeRZNvyGgya1h2nB9sm/uaNaW/AA4xAJiUxx19QDHesAvja8T
   XAUfCa9U4AYD69k8RLkvmA5Ja8Wo2jtEQWO0Om2ppQH04hgjEyH7PwAxb
   U3fJpjjcxIKYYYumfE/tCCfhH34pQ7/lD2LiIFswbkQfTNl97w9rNI2w1
   Ib3rxlj1M5ihcGW4tz/1qVQFuhlsu9Tw2uOnGYC1Xlr5LKbo2EwMTvtR3
   KfDpgdBXqOSDQn2FnXBDEUbIUBP+SIOb/eflpveIW1b+D4IzDd44JBnTf
   g==;
X-CSE-ConnectionGUID: Wcyt4lQfRhqIFArDYoKK2Q==
X-CSE-MsgGUID: piZ0BWQLQGSGUyrQEGZDHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="111236297"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="111236297"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 12:54:46 -0700
X-CSE-ConnectionGUID: PHEhfjWoRICSTULj0uJ4iQ==
X-CSE-MsgGUID: pxJOEjBwTOihx1J5QKxIRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="266929906"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 12:54:45 -0700
Date: Fri, 28 Aug 2026 12:54:38 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com, 
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, peterz@infradead.org, tony.luck@intel.com, 
	chang.seok.bae@intel.com, wei.w.wang@hotmail.com
Subject: Re: [PATCH] x86/topo: Map vendor CPU types to generic Linux such
 types
Message-ID: <dznktzvdfxqrlvugqvmkfkoarxxaqzpbmhkxou4lipuq2q52ss@crc6jbfrnmpl>
References: <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
 <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
 <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>
 <un5ex54iuszxdubdkjhhtezk4rqkgrzrx4ewgu74id3n3swkyy@hh4df7yq32ox>
 <20260722195105.GEamEfKQIPgWp4HiBk@fat_crate.local>
 <bpncabyd5x7q2niuopingb4ztimoxz7ldw3mha7yntyq5mbsyb@5qjrfihupvym>
 <20260722212314.GFamE0wsvHL6eLvTjT@fat_crate.local>
 <20260827204425.GDapChqT4IymVmrf7T@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827204425.GDapChqT4IymVmrf7T@fat_crate.local>

On Thu, Aug 27, 2026 at 01:44:25PM -0700, Borislav Petkov wrote:
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cc13164d948f..f14775968308 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5682,9 +5682,9 @@ static int adl_hw_config(struct perf_event *event)
>  	return -EOPNOTSUPP;
>  }
>  
> -static enum intel_cpu_type adl_get_hybrid_cpu_type(void)
> +static enum x86_topology_cpu_type adl_get_hybrid_cpu_type(void)
>  {
> -	return INTEL_CPU_TYPE_CORE;
> +	return TOPO_CPU_TYPE_EFFICIENCY;

Should be:

	return TOPO_CPU_TYPE_PERFORMANCE;
