Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB95446821;
	Tue, 21 Jul 2026 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627121; cv=none; b=KEvwZWlQ+QWFvgNF5q+sIobKcXG5/z85E6po4XiW3YJDW/rdaN8IluUtJF6yfnA8TOeZC3uZ+yhTcC2S6LPdHf2urAkL3b1uPs+hhTZRCSCy2MSLtSA1s0VjeBmp5sY8YjQpAxTRBkHkDxK1pa37gfK1joGBGzcVfGK7Sbz0AYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627121; c=relaxed/simple;
	bh=7jH+mMZL+VtJZ7DwMf/4RpJ3CvaoVmwbPyWE47bnC3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKzbK6z723ps5kmY0FqLZNU/92bop16ZC80CGe3LdUoQaP7tcyi8FKnMlLaPaMePiFWCTGD+nS+4p6GlvP+BOh3m/4AoEHEXw7j/Wez30hO0/fiL7MDqC2xqwLTkGftUZ0UVVwr9TNoqxBYSJSdwD0rUOm17y8RxODWn4cYFgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egm+ZtiJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egm+ZtiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784627119; x=1816163119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7jH+mMZL+VtJZ7DwMf/4RpJ3CvaoVmwbPyWE47bnC3g=;
  b=egm+ZtiJMYG8yyqf/EcvByD5VVi35pL0Dco0ubUB+MNCEiW4baNiuBXC
   JjioIkueSsScj3lKCroE2bjhfmtMj8X/jow7OWr0Tca6zRyDVAqneXOet
   VxbrIZZawteFgDKIrTu7pIq9MoO5qTAXJVEtijmw7SOWxPTYoyl7af7qR
   1BZ7cM2p0PsQHS/z4cDgviV1+H0QOvou2ZOre8ct6MfhWRG/kb+Ub7Ybr
   aiMytJqMKHm7EA8QvCWrmIm9EC+5i7Tkd0QxugNocFnc5i/zTnDknIs6z
   XUZLLxaCOWVtJVau7cpmKJ/sUnfasdcfA6gGumtSjL/+0rwiM98lLudZ3
   g==;
X-CSE-ConnectionGUID: 7qhQIvaHQSm1iP+nLkqi+g==
X-CSE-MsgGUID: cvdx5lkATP2AWCC9tywG+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89045728"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="89045728"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 02:45:18 -0700
X-CSE-ConnectionGUID: bmkXgo0yTECDipe17NSmsw==
X-CSE-MsgGUID: AGrmp+8LTQaeBDLSadhyvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259693093"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 02:45:16 -0700
Date: Tue, 21 Jul 2026 12:45:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v2] device property: mark internal data as private for
 kernel-doc
Message-ID: <al8_qTwgTLyyV4Qy@ashevche-desk.local>
References: <20260721023218.3490573-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721023218.3490573-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 07:32:18PM -0700, Randy Dunlap wrote:
> Mark the @value union members as private since they are an internal
> representation of @value. This prevents kernel-doc warnings:
> 
> Warning: include/linux/property.h:406 struct member 'u8_data' not
>  described in 'property_entry'
> Warning: include/linux/property.h:406 struct member 'u16_data' not
>  described in 'property_entry'
> Warning: include/linux/property.h:406 struct member 'u32_data' not
>  described in 'property_entry'
> Warning: include/linux/property.h:406 struct member 'u64_data' not
>  described in 'property_entry'
> Warning: include/linux/property.h:406 struct member 'str' not described
>  in 'property_entry'

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


