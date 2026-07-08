Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DDD4A13A0;
	Wed,  8 Jul 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521255; cv=none; b=RUvm2FZ8SFOck/pva8AzBQYag49B19Eu0E6SJtfP+UPPXqPifSZ6pP2R7h/iXbQXdllHUMuFJDtxCZAtGsDg/QmD6nUP4lvg1LvDhMjCnjJVi9QOP72Vb9eO1zeQpuab1zidYrkdOt/IvGPgiy5c/zFJGp0/FOHX08+9PGm3H/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521255; c=relaxed/simple;
	bh=D+twBn5tTFEiRsPqJZL9Fk9iw0iYQWHKiZm+7uDf668=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwpfGvK0xCKqQJDACMvzke0iwB6TGd/arP6+DTPwOXanyTXSfF9NO7Cst7/2TbQh7L+0SKxPBNQ/MAllGfrKqawmdkcOWmweFEeyYmp544yPZu6Un+4KYDTmKSjZ8td1HBh0xzTDfyuRD+cdn2xIdWWiKTwHVLx9JuGitKvvYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fol0BllK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fol0BllK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783521254; x=1815057254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D+twBn5tTFEiRsPqJZL9Fk9iw0iYQWHKiZm+7uDf668=;
  b=fol0BllKjEI6yw+B9fPxDV7tNfNthjwAKaN9WDfNoMPQ+cx7uAsWZO6q
   BkEQXd83an4qudSWup7xCgMNWgPreKXXVe7/PyDzniJZklYW+fO0l6g3Y
   ikY/khTP+QgXLrF1wZmdCmuxOa2bq/Mcexh0RwutJd4o3maPUW8WdUnEa
   2JqIJ8A1+2bRfRcpoz7rxT79I/Iiv8YR8hGnpmUya9y2H+TUza/6tCzXT
   5o/9NWgSqrJC4kP1eD63R/t1NP7N2J/wMbMc4sD89Zfznz/JBo3NA0TGm
   yUxjVer4voDxjo9i4fNsBBEQPFw8iDh2OmkvAX9HJfuusIzBFzJGVdm4O
   w==;
X-CSE-ConnectionGUID: R5GuCHONTy+JbrK6H2/+jA==
X-CSE-MsgGUID: pNcdxftPRfaB1jQXE/1qiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95701141"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95701141"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:34:13 -0700
X-CSE-ConnectionGUID: cnCkGHCzSd2y5rb12IF2qA==
X-CSE-MsgGUID: v0y3ccFETsOwfzKo+waDMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="278691715"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:34:11 -0700
Date: Wed, 8 Jul 2026 17:34:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: PAD: xen: Stop setting acpi_device_name/class()
Message-ID: <ak5f4YQ8zJE1YIdP@ashevche-desk.local>
References: <2384190.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2384190.iZASKD2KPV@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 02:42:20PM +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() and acpi_device_class() which are
> never read afterward, so make it stop doing that and drop the symbols
> defined specifically for this purpose.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name and device_class from
> struct acpi_device_pnp in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


