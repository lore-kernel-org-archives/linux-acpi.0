Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9268348BD5B;
	Mon, 28 Sep 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588522; cv=none; b=gabbJ7u9YThXbq55EgCVqsBXirtGS6h0SHN9ldDOqINufomq+IWxdd8xJURo3r2t+kXcpdxTnSC+8B7B8Uh8rL2vHGT9oQd5JfKT8WZjlFlqj6mvbmk0D/tlljp20F7ZVO94NpHCHk4wd1h+RSdJTN6Q5xXSQS2G/XCWryXuCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588522; c=relaxed/simple;
	bh=u/7ok1URphFvd0R1Kj9k7YkKWqpAOEXGIJcbB2FPtzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELw2StTtCEbdvMABTbtWSeHjd/GJ6sRaHVcFg1vklm4D2SpeRGbq/zcZo7jM2W8YahZv5TPgWvDCRcRi4wX6CzBg5sdTWXcJEoqOXRF3VPJMQgoPswbfhH4opPR5Ov0TMBmCQOURH0Hw5JV/LI31anUyFAK5/4G37RQIueQlV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wrb1RJhf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wrb1RJhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790588520; x=1822124520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/7ok1URphFvd0R1Kj9k7YkKWqpAOEXGIJcbB2FPtzM=;
  b=Wrb1RJhfop2nlNqBkH2jWXUCCqeclatmMj+5zlL5JznHdWmat5/F0Ins
   AX6BapA66qM7Z2w1Wsh31hUUGgYumtMjaiGYf2Y3pMqwB/t8+sbXgQbxq
   pew86xm0vIvm6mK8PP4fVzL8eRjLrcyTK7sc/sg/SpWwXueh9XanA5lkx
   XR607m8OAClj5xaLdKun8wgq23BTenx4MNnMMwwySxuiKdYD5UWSGmyFH
   cTSMlJUHtw9WrkjYXfKqSNHAnWaDyVT+k0J5sGKshjxIXxmJtdy0uQBqc
   Ak4uMqGZmgm6Nb6PoqEin7T3mslZ98ofFSAffBTo52j+f6YOVa4KqtpRJ
   Q==;
X-CSE-ConnectionGUID: ehfSdM/uRpWbZt4ScGPyWg==
X-CSE-MsgGUID: axkT5WUvRM6iuiLarywB9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90151882"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90151882"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:42:00 -0700
X-CSE-ConnectionGUID: lchMWD7GTHefn9ax3cPCjg==
X-CSE-MsgGUID: ddnefMPfRSqY5+LjVd9Qwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="301286089"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 28 Sep 2026 02:41:58 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CBAD999; Mon, 28 Sep 2026 11:41:56 +0200 (CEST)
Date: Mon, 28 Sep 2026 11:41:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bartu Alev <bartualev@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Ignore AC adapter wakeup on ASUS FA507
Message-ID: <20260928094156.GG106095@black.igk.intel.com>
References: <20260927014212.302743-1-bartualev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260927014212.302743-1-bartualev@gmail.com>

Hi,

On Sun, Sep 27, 2026 at 04:42:12AM +0300, Bartu Alev wrote:
> The ASUS TUF Gaming A15 FA507 wakes from s2idle whenever the AC
> adapter is plugged in or unplugged.
> 
> In the CPMGPIO0 SSDT, GPIO pin 23 (0x0017) is declared in the
> \_SB.GPIO._AEI resource template as:
> 
>     GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullNone, 0x0000,
>              "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
>              { 0x0017 }
> 
> and the corresponding \_SB.GPIO._EVT handler issues a device wake
> notification for the AC adapter on pin 23 events:
> 
>     Case (0x17)
>     {
>         Notify (\_SB.ACAD, 0x02) // Device Wake
>         Sleep (0x05)
>         Notify (\_SB.ACAD, 0x80) // Status Change
>     }
> 
> Both AC plug and unplug transitions therefore trigger a spurious
> wakeup from s2idle. Add an ignore_wake quirk for this pin.

I would think this is by design like that.

What is the issue? You unplug the device from AC with lid closed and it
wakes up? Userspace should put it back to sleep in these cases. In Windows
and ChromeOS there is something called "dark resume" that deals with this
but I'm not sure if generic distros have that yet.
