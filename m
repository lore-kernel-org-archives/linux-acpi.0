Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076B3368B5;
	Sun, 19 Jul 2026 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450277; cv=none; b=Vrbqvd9PFYm5iBMZeaIpUl1cwPHcmbw+r5AOo5wdrJivOIqKY+ieCPTp+j70JA75jjbcqsN8M/jtZLStu0JbbfpFfnWZPCBVY971HrV7UEiRxDRUrwIG6e8g5rymxYJ6OKdxnk+pQwz1eva74bgVajTjE+NEyCkluFIEbFQ276Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450277; c=relaxed/simple;
	bh=6A1AAWCG1HXME5VojPiVPd/SvTC7z3zlEgixnlAcm6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmdiMVxU5Z/3C2OgJ8Rvg2/Jq04+zcWTSVYMpydV36EeaPYGJeH9FS1SIfWlc1aiFsXlzcudyzkGm5PqCI1SeCzqF9xK5neP3/MP3HSwCpP3iJobTSDuw/K+67IrhVdElXAsYfwgG0LnkLF+RFziyFBVhDpe1mb/Fj7K5AysYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SH+I4UYp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SH+I4UYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784450276; x=1815986276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6A1AAWCG1HXME5VojPiVPd/SvTC7z3zlEgixnlAcm6Q=;
  b=SH+I4UYpudOFEMvcq5s9lYAIga5ByFNYb2QvXjiUZhUKD6FWvXfuKf6L
   WeJ5638hodyClLcaG7XeOejVePLnVm6zb4c7qaRKIDpl7M6zwj3ni42q6
   HbxvmySqG9SOgpL0FTbd5PZNUzVoGijjMIYF/eTjsOBZVfbRNN1AihFIM
   T4JuYLq4B0fie9pk0A41b+zpMxcVeZDow61xzrWsrf9bp3pfonrGImzmR
   CvW34/u4ciRV/tRZU9p1LHfpOoIhn/xvRhBUoFa8LLw/byFhiGH+gyhfX
   hhdZTaPdaLjVIfyKWE/gOQhO5eVjS8Hq38KmWmPsOUR6jNflnlC8jMFPL
   w==;
X-CSE-ConnectionGUID: yku8rTHBTCeHTvmnbMI7Mw==
X-CSE-MsgGUID: JeZNhq8GS4K2aIUqw+38+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="85262744"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="85262744"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 01:37:55 -0700
X-CSE-ConnectionGUID: MPlDAIe7Te2ViXWmZ77pGg==
X-CSE-MsgGUID: c7dMYrhZSzG9mcavhyURVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="256610099"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 01:37:51 -0700
Date: Sun, 19 Jul 2026 11:37:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] device property: add test cases for
 fwnode_for_each_child_node()
Message-ID: <alyMt-ya5skHmhtx@ashevche-desk.local>
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
 <20260611203537.1786399-4-andriy.shevchenko@linux.intel.com>
 <DK1RFV9AABBD.KP0VPMWKFYWM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK1RFV9AABBD.KP0VPMWKFYWM@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 18, 2026 at 04:18:12PM +0200, Danilo Krummrich wrote:
> On Thu Jun 11, 2026 at 10:31 PM CEST, Andy Shevchenko wrote:
> >
> > Add test cases for fwnode_for_each_child_node() API.
> >
> > Test command:
> > $ ./tools/testing/kunit/kunit.py run property-entry
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This patch broke the build [1], hence I dropped it from the queue (but kept the
> first two patches of this series).
> 
> of_node_init() can't be used from modules, either it needs EXPORT_SYMBOL_GPL()
> itself, or of_node_ktype needs to be exported for this kunit test to work.

Oh, thanks for pointing out.

> [1] https://lore.kernel.org/all/202607181651.RnUuV8n6-lkp@intel.com/

-- 
With Best Regards,
Andy Shevchenko


