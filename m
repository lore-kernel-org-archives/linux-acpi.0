Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFAD4F68DF;
	Tue, 13 Oct 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897707; cv=none; b=JBFSA27yf6ER9qSU2xkZtR21KjdAbx8BkYmTd6csE0jydeaBjw99h/g1SiutxCbaQ/zTtDKYcoNIPggcvYQNcIfj9XjHm9RkGRgqIs+riRwzEQRR5EtOYgCpFRP82ipqpb6JIBihdCAyql7D7wjHfOAoOkWWbiFuJ6xHf1sWzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897707; c=relaxed/simple;
	bh=phRW5ewg23xc34NdzY7oGXso7g+/z4XfVbWkRQUireU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb8NOls8sgNQ4pmHeZcdT90G8jB3Lmp6dGDefCdTV+yLnUVEzC2jy5BWQPD9UVLbDtJQ04hfq2Xk0OKkyS8bkGIeEfH5FJK/Wq7YL8uVm3I8U8tck2rm7MfjDHEb9fHTyovO12IzA8B7Oh9okUWtXP0S5Sn8V3er9JPL7JZOUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfK6ZSCY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfK6ZSCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897707; x=1823433707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=phRW5ewg23xc34NdzY7oGXso7g+/z4XfVbWkRQUireU=;
  b=TfK6ZSCYWNnu8pF/RP4SjmzG9/mFmE9BsR64Je4SCFn738Y1uyteZIx6
   nshhKpGUiXkPwPMs6bIg8gw8TDt1PRvd+iyEVRBcnBE0DcR0GySjf5Eep
   nTg5FmHYi0cjTrBheb/QvOIbBDlVIY9gO2+s9IlVSN1qSLueCuJ6nrVyE
   i3R5v9UhIechcetDoSv36luiiePEF/S0N1uELIBOC6xgX3inl8fVBWFN7
   +0/aHosiI5U6khIvsJ6DQSiQAi+meTLZUbsxtxpPQEaSD2fsORVdBXaxZ
   Wktm5ceJ7XqF63K/C+5L5pV5s6tQHwCE9gW/LSfxvYiTzZHwxzkYfHAN7
   g==;
X-CSE-ConnectionGUID: aRA31wk5QyS9kZr6FKuvCg==
X-CSE-MsgGUID: ToG7hwrcRs6hIIERJtlpEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="615651"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="615651"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:21:46 -0700
X-CSE-ConnectionGUID: PEMlfMdWQJ2+PwqCvYuhlA==
X-CSE-MsgGUID: 1Mt+akoCQkmW95aZdby4nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1249797"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:21:43 -0700
Date: Tue, 13 Oct 2026 16:21:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eduardo Ruiz Duarte <toorandom@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: sakari.ailus@linux.intel.com, bingbu.cao@intel.com, djrscally@gmail.com,
	heikki.krogerus@linux.intel.com, tian.shu.qiu@intel.com,
	lixu.zhang@intel.com, linux-media@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ipu-bridge: hold a reference on the IVSC software
 node
Message-ID: <as4wZeHPziPV3nKU@ashevche-desk.local>
References: <20261011131518.48838-1-toorandom@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011131518.48838-1-toorandom@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Bart for the double check of the approach. This sounds like it might need
to be fixed in driver core (software node implementation).

On Sun, Oct 11, 2026 at 03:15:18PM +0200, Eduardo Ruiz Duarte wrote:
> ipu_bridge_instantiate_ivsc() attaches the IVSC software node to the mei-csi
> device with set_secondary_fwnode(), but never takes a reference on it, while
> the driver core unconditionally drops one when that device goes away.
> 
> device_add() calls software_node_notify(), which does a kobject_get() on the
> swnode behind dev_fwnode(dev). device_del() calls
> software_node_notify_remove(), which does the matching kobject_put() -- and
> that put sits *outside* the "if (swnode->managed)" block, so it runs for every
> device whose fwnode is a software node, managed or not:
> 
> 	sysfs_remove_link(&swnode->kobj, dev_name(dev));
> 	sysfs_remove_link(&dev->kobj, "software_node");
> 	kobject_put(&swnode->kobj);
> 
> 	if (swnode->managed) {
> 		set_secondary_fwnode(dev, NULL);
> 		kobject_put(&swnode->kobj);
> 	}
> 
> csi_dev is the mei-csi device, which the MEI client bus has already added by
> the time ipu_bridge_instantiate_ivsc() runs. The add-side get therefore never
> happens for this node, but the del-side put always does.
> 
> On hardware where the MEI bus resets -- which it does on every s2idle and S4
> resume on a Dell XPS 13 9340 -- mei-csi is destroyed and recreated each cycle,
> so the node loses one reference per resume. INTC10CF-N starts at 3: one for its
> own registration plus one for each of its two port children, since
> kobject_add() of a child takes a reference on the parent. The third resume
> therefore frees it, software_node_find_by_name() starts returning NULL, and
> isys walks the fwnode graph into freed memory:
> 
>   refcount_t: addition on 0; use-after-free
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x7e/0xb0
>    kobject_get+0x94/0xb0
>    software_node_graph_get_port_parent+0x89/0xd0
>    fwnode_graph_get_port_parent+0x70/0xd0
>    fwnode_graph_get_endpoint_by_id+0x93/0x280
>    isys_notifier_init+0x92/0x180 [intel_ipu6_isys]
>    isys_register_devices+0x3c9/0x4e0 [intel_ipu6_isys]
>    isys_probe+0x3df/0x500 [intel_ipu6_isys]
>    auxiliary_bus_probe+0x4c/0x70
>    ...
>    deferred_probe_work_func+0xa5/0x110
> 
> followed by an underflow and a saturate on the same kobject, and the camera
> never comes back.
> 
> Take a reference so the attachment owns one, balancing the put the core will do
> when csi_dev is destroyed. Where csi_dev is never destroyed this leaks a single
> kobject reference, which is what the lifetime of the node already assumes.
> 
> Found while making the camera survive hibernation on a Dell XPS 13 9340
> (ov02c10 behind an INTC10CF IVSC); with suspend-then-hibernate the first cycle
> burns two resumes, so the failure consistently showed up on the second
> hibernation. Tested on 7.0.0-1015-oem: two consecutive hibernations with the
> node alive throughout and no refcount warnings, where before the second one
> hung the machine.
> 
> Signed-off-by: Eduardo Ruiz Duarte <toorandom@gmail.com>
> ---
>  drivers/media/pci/intel/ipu-bridge.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -765,6 +765,15 @@
>  	if (!fwnode)
>  		return -ENODEV;
>  
> +	/*
> +	 * Balance the kobject_put() that software_node_notify_remove() will do
> +	 * on this node when csi_dev is destroyed. That put is unconditional,
> +	 * while the matching get in software_node_notify() only happens at
> +	 * device_add() time -- and csi_dev was added before we got here, so it
> +	 * never ran for this node.
> +	 */
> +	fwnode_handle_get(fwnode);
> +
>  	set_secondary_fwnode(sensor->csi_dev, fwnode);
>  
>  	return 0;

-- 
With Best Regards,
Andy Shevchenko


