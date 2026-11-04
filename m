Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827774;
	b=c+L6AadBfEeJ9nDscYST0cNmNyh6Nmvd1bfuR3ag4R0OFe6n9ORK7wuYXLLi5A/ITtip
	 KHCU7eBAQ4a+WBarD8BQIlYMyiS43LYecItBm7ef39WFzCvXrbx3u7f3EfUNUk0edcT0n
	 gWz6Gw2BgrgICQ5rEutS9kA6CtcxbCIx7zVrgOA6GdejQyDTaCfvCxR7JNXoyj0yrFhCM
	 PWWxqUjsQHcvrJpqcFmfjGmwPlkudUmOhZdH62UAcXoo2okfZPfFfnenOnc1g+NpTxajO
	 vG6dgiD3enhAFlhI5WIT9GL7cfWZTtXHK32hHoBNiQT9oPxh32dCDPC+OWKwyEMfUAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827774;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=+5fG09BaCpZZnYtMPZoRGCaZIyFAQL/UuYrKy2roHhQ=;
	b=IdgLQ6UNCC1/MTZ+6/4vqi369/aUy8BiNGkTAHsQmWZT0SJop/6qXPdQaOjFLSyR5egn
	 YeH+QwH1pKXwi7yE/6aEivGzq5JacJi/oqCQDs45tGtvueGu9+45F92r7lvPFPTAvvoTc
	 ttBy+N3c5sKkZlCioOYWK04GdknNpafWPPopCmVgresBho8Xp0wpgzRHEWlI3o53X9ZO2
	 niH68kCPF7fsXEvLWrHYCV7UisGhHM8U/OkDpfO8XQ/EkI488H/jJs4fByvkIyaS+vL0n
	 S2UI/MxEuYHkV92dQi9rX3I1Z3l5xPQyijeaKpzACQzjyfuCndufXtMaM7rDkrVaW8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cNsEsLM3;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB1606BA3D;
	Wed,  4 Nov 2026 21:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19AB1606BA3D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cNsEsLM3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793827775; x=1825363775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ER+AFJf30F+dN3H3UfwCZrOzwmylYesX3P33tOo15ss=;
  b=cNsEsLM3yeUzX3tE4C9kj6ODkdshgQhpTNdZipEAQqWNtdO7IlcZjbUg
   JPackwxJNvwL8Fn67efyb8zU1pKojSfRyeCMKUDyLxj6wjQS4K4SbwJhW
   zPBM95UuGPKMf2MltlbMOYvDyesyy1liJq9uy+Cw+PEWOSp5UEctHcsJS
   z9oyJpnDdFzovHJQiGDM2jfdlkwb0NR/f1cKzowes6Jxi2MNGR0ktSjfv
   On6c+kfu4Q73VCHYkE7McYynXV46j7edRiUlGVvpG8e4p/5uOl5EmOn9z
   fNFB3oRnprPEkO3jKSXu1uX4s3/H3XnYSUISACuhmYEujFXeOMqQJ6lD4
   Q==;
X-CSE-ConnectionGUID: /tJYaEe1Ru6hvAik4pz47Q==
X-CSE-MsgGUID: /40e0bWaRx6w/Gg6VgI9FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2702882"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2702882"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:29:33 -0800
X-CSE-ConnectionGUID: Nd+WyEeZSaukMzaT453Xmw==
X-CSE-MsgGUID: dTZse/3PQTWZ5DIwf9UDng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6881907"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:29:28 -0800
Date: Wed, 4 Nov 2026 23:29:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/4] software node: use kobject_get_unless_zero() in
 software_node_find_by_name()
Message-ID: <auujtfVvejcsyums@ashevche-desk.local>
References: <20261104-swnode-race-v1-v1-0-9406a67e25be@nxp.com>
 <20261104-swnode-race-v1-v1-2-9406a67e25be@nxp.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-swnode-race-v1-v1-2-9406a67e25be@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 11:43:14PM +0800, Peng Fan (OSS) wrote:

> software_node_find_by_name() also walks the swnode kset list and takes a
> reference with swnode_get(). Like the pointer-based lookup, it can
> encounter an entry whose refcount has already reached zero but which is
> still linked until its delayed release callback runs.
> 
> Use kobject_get_unless_zero() and continue scanning when the entry is
> already dying.

...

>  		if (parent == swnode->node->parent && swnode->node->name &&
>  		    !strcmp(name, swnode->node->name)) {
> -			swnode_get(swnode);
> -			break;
> +			if (kobject_get_unless_zero(k))
> +				break;

Can we rather see even in the previous patch something like

... swnode_get_alive(...)
{
	...uses kobject_get_unless_zero()...
}

?

>  		}

-- 
With Best Regards,
Andy Shevchenko


