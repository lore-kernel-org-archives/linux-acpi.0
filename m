Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89D78F4A;
	Fri, 24 Apr 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037592; cv=none; b=XU0rEiQCWWwrzTLX5bcGpCo78bOjWqb3uY/Yrv+4qWaT7jkEaENYCYn8h9EnGO8zeH+ombm3bOrpb9PwCX5OPgAov8okd7sbSTctILtN0b3XzoAwW5H1ZvJ56hOvfs7HH7/kNla+Z1oWBFJT/12Ayf4qMRYdeZdrZtmmX8OOwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037592; c=relaxed/simple;
	bh=BxPc+7iahjpb/CxTUGbPxS5kERM4lN3q0tzckLdAeQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7gOlrZja7jIZOMMGTnIWfZ1NbBmvtCLokn3XzvqNkMleGIhhuHS63hHa3ppvrdx9IMyh7v26LdP+jwntxK658ATh6sUiTZRJXfVQjKX5v+6OBN0ezeOgBtgHGFzNHQdrWnIhjLPWrtCAhUCzztgGDTQr6CP94Vq5yUIjUz1m0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxWtiFTR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxWtiFTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777037591; x=1808573591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BxPc+7iahjpb/CxTUGbPxS5kERM4lN3q0tzckLdAeQM=;
  b=bxWtiFTRIlEVxH4pW6xjO5GYNz/KPasGzLXEOwlXv3f5C4qhdd/XDNUl
   DtrGHnvu9snTRXgTvSHNwUvMEngwEMAoL4+10J7w6aKhjdPH24IUMKsh1
   rr+zz19IN/QUU+8tnqGYbpNTvABPlAgnvUgM/ZKeUy5gKzhUIevSbEOeg
   QJf77Gkl0VHTgjZYBMZL0bQoA+DA6bBu8DRKpr2czgcpNBT78rj3N0Gc4
   x0Q8p2TdXuXzp60nNnGtxJ/BDvj2cDmtTel7au+45SpegY4ctbVORFQtc
   RqmGD9JUNMDNXG8x/AfC4xvjwoS4FOCxgGwXda/aHkHYTnT9lmIhVOW04
   A==;
X-CSE-ConnectionGUID: PLO3tL+ATv6khBLtNQumgw==
X-CSE-MsgGUID: aLCAnVd1TQGDoLcd7fIuug==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="103479089"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="103479089"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 06:33:11 -0700
X-CSE-ConnectionGUID: +m2BoJGgRRWEy8MsT2dsww==
X-CSE-MsgGUID: O4gNinr4Qf6s8Fl+WbudkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="236926347"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 06:33:08 -0700
Date: Fri, 24 Apr 2026 16:33:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	brgl@kernel.org
Subject: Re: [PATCH] software node: provide wrappers around kobject_get/put()
Message-ID: <aetxEcjE8wD4-ZyV@ashevche-desk.local>
References: <20260424124250.92890-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424124250.92890-1-bartosz.golaszewski@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 02:42:50PM +0200, Bartosz Golaszewski wrote:
> Make the code more readable by avoid constant dereferencing of the
> swnode's kobject when managing references. Provide wrappers that take
> struct swnode * as argument and make them hide that logic.

...

> +static void swnode_get(struct swnode *swnode)
> +{
> +	kobject_get(&swnode->kobj);
> +}

Isn't a pattern to return the object itself so the code can bump the reference
in a single statement (if appropriate)?

...

>  static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
>  {
>  	struct swnode *swnode = to_swnode(fwnode);
>  
> -	kobject_get(&swnode->kobj);
> +	swnode_get(swnode);

Like

	struct swnode *swnode = swnode_get(to_swnode(fwnode));

>  	return &swnode->fwnode;
>  }

...

>  	list_for_each_entry(child, &swnode->children, entry) {
>  		if (!strcmp(childname, kobject_name(&child->kobj))) {
> -			kobject_get(&child->kobj);
> +			swnode_get(child);

Becomes inconsistent with kobject_name()...

>  			return &child->fwnode;
>  		}
>  	}

...

>  		swnode = kobj_to_swnode(k);
>  		if (parent == swnode->node->parent && swnode->node->name &&
>  		    !strcmp(name, swnode->node->name)) {
> -			kobject_get(&swnode->kobj);
> +			swnode_get(swnode);

Also not sure. Maybe use 'k'?

>  			break;
>  		}

...

Otherwise LGTM and makes sense.

-- 
With Best Regards,
Andy Shevchenko


