Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5D48F828;
	Mon, 19 Oct 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395573; cv=none; b=o3GDDLoUi/GaqYCWlEzIWxm02okJv9qH0zl3fs5kIuuR+4aiBzOjB/vBibc5gKpnbSxTHyncQkeApaLZwKp3xpLwDeFeMAN+dK5gAVdeyKYawKp+jc1x9Axohc5Qeb1SBeY1QWLEIdow0RHE+L4UU7fwevxr5JaQ5c8J2otlaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395573; c=relaxed/simple;
	bh=1OyCKhRLaKm27vMEaGkvpx3V2Q+EAjnGyMadxo1SJDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7jDh7AgsLHebcNfveW45DYSR51JZtT7TpWzTXCiLG/s4vsrP4S6uSQVTa954JUQuIgHevBA+ZigM7VvrbxhqTYEo+NaBgr9hARxIATdGdOeFTNJcQZteEQxaQvo8oco+jGW/GkABF5xia3kp8LD3xoahR7LFnzGs0wvcK8Yc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLuQEYGc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLuQEYGc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792395572; x=1823931572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1OyCKhRLaKm27vMEaGkvpx3V2Q+EAjnGyMadxo1SJDg=;
  b=LLuQEYGciOgdoLYcpGy6I3FmgYy2V8q/GCdhxpMEOcjzMyM0UdrL8eax
   Nd5ZofHrjkS6BP3WLpxijfiAIC/jXz/ynRiSqKCR2ViacYcqVcc3EqbZe
   lzZAyCFQIbls1ScBdc7jDdrKF3Eevk74x4WFZxmRsUXZsEVNynNHzOZFw
   J7g/jltiPGOupBnLMPfYZal2PbW1zy86WO/awVReLUhh6OpZ3tJkfN0Rw
   xEAIRHI53kwk6E06BF1GQXacXYDV9dHZNILogUNdmMWqOZEvsE7yVT7/D
   BQWQYb2SWsAI5Ac+OB5CRTDuIBTarcFKMSo3WYhSZby49iLJ8C8/ze1Cm
   A==;
X-CSE-ConnectionGUID: +dWrr1ZAQBu7j2XbJtRqLA==
X-CSE-MsgGUID: viDckE5qRAusHlFd229RTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1084959"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1084959"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:39:31 -0700
X-CSE-ConnectionGUID: G9NiRom0Tg6Crkp6+qS3LQ==
X-CSE-MsgGUID: MLeb7jQhQ0Ckdr/tgVvEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2466994"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:39:29 -0700
Date: Mon, 19 Oct 2026 10:39:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nikodem Sanecki <nikodemsanecki@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: ThinkPad L13 Gen 2 AMD (21AB): Caps Lock LED broken by ACPI GPIO
 11 interrupt conflict
Message-ID: <atXJLs354lk3lFES@ashevche-desk.local>
References: <CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com>
 <atEaguJD7dh7xNs0@ashevche-desk.local>
 <atEb6FN6ZbKI9xgf@ashevche-desk.local>
 <51c151fd-31cb-4ebe-8f3b-eb7634e68c31@amd.com>
 <4ba482fe-8b34-48ad-9d13-99ab532cbd97@app.fastmail.com>
 <CAAUQFRPDq6zdyySWtGM8i_uq-iZJK1qpvCvxTrRweLmS2+-AMg@mail.gmail.com>
 <8a94b2bd-70ae-405e-ab01-2a0d37dcc551@amd.com>
 <CAAUQFRO49_T8iRdL3zYaj82Y_rgPTgM6VjScN3rqK89NmRzLqg@mail.gmail.com>
 <CAAUQFRPFkwMe4fx7xV1iDb2sAb-opYcVo=wLr-F5hwjEEU8ymw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAUQFRPFkwMe4fx7xV1iDb2sAb-opYcVo=wLr-F5hwjEEU8ymw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 07:33:49PM +0100, Nikodem Sanecki wrote:
> I've tested your patch on my ThinkPad L13 Gen 2 AMD. The Caps Lock LED
> works without the kernel parameter, including after cold boots and
> suspend/resume. All other hardware I've tested works normally, with no
> regressions observed.
> 
> Tested-by: Nikodem Sanecki nikodemsanecki@gmail.com

Wrong thread. Please reply with the same there.

> Thanks for the fix!

Thanks for testing, but please stop top-posting!

-- 
With Best Regards,
Andy Shevchenko


