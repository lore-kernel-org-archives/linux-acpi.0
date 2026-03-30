Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2835B632;
	Mon, 30 Mar 2026 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866106; cv=none; b=heFg5NbmBDctr5dD+Aa4LN/4XzUsWwvlJfaZbFXKbpTrF/1+tkOKkTPOUg90cTZOfVdIClF6JU6369QynUb97aPGRnk7qA+Vfh8N9cEi4LkvqQkzfy6m+LeRraZ3RNgdKkBivz4k8gLY5hZizJacZ2DdtM5yT/5QYl5MXYC4qmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866106; c=relaxed/simple;
	bh=6jQdI40/7L8YYUie6MYI7wxR86hS3AgorX549QWYEkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRN+h85N9VL1E8o1AccZ4kuFNnPznZ/1Sl9h8y/QYjAaer71U4VbLK7AyQ+tZ0Mzaim/G4pz2t51tn6fIa42qoXOK5aJF3q/sF3bmVrBT1vVlLLi208IQskoxPHHWonAWG6kB0sG2l1Qzb7IsmiecrstUP0wOq265w3kiAMH5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2cIrvKE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2cIrvKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774866105; x=1806402105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6jQdI40/7L8YYUie6MYI7wxR86hS3AgorX549QWYEkM=;
  b=d2cIrvKEFh3odNaBg0dkLBzXuU5YY03Y99f5Qjr2uhNKTIFUi1B2zmxY
   9hNPCiY8hROQaArnyI4sIfNNl8FWO8Q4iXxHL4p/9hIGAJCBULgevmEtb
   pXoSHopvesDJ8X9VyG8cuPShVCQR+I6Ga0NEhpgoDXYBKBVLggLqxiYFX
   V/zeFe3ViwugZBlqqKWZ2f93e7tu/k+3aSNzvq2pmgSf2S9RDuWM5iceU
   thEu6nSAuF9JgsZjsNNTXZdv017A2WrxUXorSZmElBCqzd+lV+sRGq5iC
   y8VTykDI+0qtsvPbiJ6h8ofmaVp/qVanjokA+sbngxC8HzUkfNoyaV6iE
   g==;
X-CSE-ConnectionGUID: cymQ5CymRb+0t06/SIMwJA==
X-CSE-MsgGUID: Va8iTlx9Ra2ghuFtuuxcmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="93437330"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="93437330"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:21:44 -0700
X-CSE-ConnectionGUID: pesm5x5+R1a1jw2v4v3bfQ==
X-CSE-MsgGUID: iyRqnefOQz2pxe0ocMSi+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="222703879"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:21:41 -0700
Date: Mon, 30 Mar 2026 13:21:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 2/4] software node: allow passing reference args to
 PROPERTY_ENTRY_REF
Message-ID: <acpOstd47g9mPoYv@ashevche-desk.local>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-2-3cca5ba136d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329-property-gpio-fix-v2-2-3cca5ba136d8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 29, 2026 at 07:27:49PM -0700, Dmitry Torokhov wrote:
> When dynamically creating software nodes and properties for subsequent
> use with software_node_register() current implementation of
> PROPERTY_ENTRY_REF is not suitable because it creates a temporary

PROPERTY_ENTRY_REF()

> instance of struct software_node_ref_args on stack which will later
> disappear, and software_node_register() only does shallow copy of
> properties.
> 
> Fix this by allowing to pass address of reference arguments structure
> directly into PROPERTY_ENTRY_REF(), so that caller can manage lifetime
> of the object properly.

...

> +#define __PROPERTY_ENTRY_REF_ARGS(_ref_, ...)				\
> +	_Generic(_ref_,							\
> +		 const struct software_node_ref_args *: _ref_,		\
> +		 struct software_node_ref_args *: _ref_,		\
> +		 default: &SOFTWARE_NODE_REFERENCE(_ref_,		\
> +						   ##__VA_ARGS__))

Make it a single line

		 default: &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__))

AFAICS it has no continuation and fits the given format well.

-- 
With Best Regards,
Andy Shevchenko


