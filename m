Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724821;
	b=eujMbAg8TguHhHHhB6nBEtHPZB9Nkux0YwF2U9thDJVczG1vYP7fXKL5G0+kksE7/lco
	 BTPgmwZ4FWv0xVDxdt8UEL0v4hraKFHPz7FHdWUOV08pFzUi9n5bZ36tIRkBeF6sLE3In
	 ltA1lBmDchMOf/cgNZt+AYyW+7tjzlOkLpcG9MFKITFggXgfvv1himf8eG5ZDtf29wvuk
	 i8u6fh7s7tBibMobLKjhSji5tSUNKLupAzVoiRQfqPvfOWfxomt6Kbl8E9ZmlRdcKgAHM
	 H3pjg3/JyTTisff5JnRGD0CEjD7rK01ba/K7AfiWV5aUI8wrLWm6n+pPMS3J/A1PzWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724821;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=rmqYW8Kc0HAXG5a+0ph9BSq3YXy1p7rzWa8/VSlzA28=;
	b=k8U9OwMyTz7gCO1JWwaQ1v0VS6BOqPjJBAsaEiqv+M/eCcfmYNteHhd4cPRaykuAi9Xo
	 XCkHyWtTzOvkYagEoJNdMSxoa248FoSScnjiVSgHmKJ+X4vOHIpVTzD2nCCudnfzT+aPb
	 dpUNhXD5CDJ1og+aX8jCzDr3pesi0baGoG62QOKAJo0I8t5dB+msf+LHsaTWXuGYSLIUo
	 t72BpbQ4mP6nY2cvTbsfQ9zx98hQ94w33/l4JJz2TXJ2BFDBFKShXkie5vDRNjvJ92JBr
	 z/I8B4MsEFXOciX4iflgOzYPW6Xp1jSanfBy0rBdLrXKC2p2j63dAJDoGVttnzFAuaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J5KEEFSI;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AC606A327;
	Tue,  3 Nov 2026 16:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B60AC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J5KEEFSI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793724821; x=1825260821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oCEs8Ovg62dvJLD8k7Bo92+4CZGt4Q8SfQHR+EpgFgM=;
  b=J5KEEFSIwVuyJ821alZiyGkiuUyEyh4f1dw2QV5vbiKhiluBRPvtHEtQ
   J8leXz4AQNxOCSOCj7LGT6blVpbfv3fUVZgJD15TL2pNRpzpQ4UqzxIzg
   H1756b1B++RxfQtrWnlIm9FiE3MuCkbWfEj0sGt/wM68YbiYMzE71MBXf
   17gj0zStb/andSmZ7voCLPvvd8petCJsqkfmRSaflnZbKb7R4N1dOc71T
   1sL57x7pEIGbyEmeecbjBuIOYKLrACx/ztj74gZPaxADSKyBKF/167jS0
   f8LjXCLXI9aNRFMZDpR5a+7O8Tm6isDyY0Ze/PCi3GehD/xeWf7545fCE
   w==;
X-CSE-ConnectionGUID: wrLA3UZ7SGWJJ+rr52W/gg==
X-CSE-MsgGUID: 8QZCRoJCRMuu4TWtSoG31w==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2351469"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2351469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:53:40 -0800
X-CSE-ConnectionGUID: d3oS5R9pSwC0Nfydqp0ePg==
X-CSE-MsgGUID: owIiRPy5TmqRi6+PRh5HvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6379488"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:53:36 -0800
Date: Tue, 3 Nov 2026 18:53:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, Long Zhao <zl020895@163.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 12/13] gpio: pl061: tidy up IRQ trigger logging
Message-ID: <auoRjh2g7ckSlAhm@ashevche-desk.local>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-12-4f93114ea204@ambarella.com>
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
In-Reply-To: <20261102-cv75-gpio-v13-12-4f93114ea204@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 02:46:05PM +0800, Long Zhao via B4 Relay wrote:

> Join the level-and-edge dev_err() into one string literal so a grep
> for "edge detection" finds it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


