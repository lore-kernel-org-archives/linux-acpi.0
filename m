From: "Matthew Brett" <matthew.brett@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Thu, 28 Dec 2006 23:36:52 +0000
Message-ID: <1e2af89e0612281536y769323a7l62c9df334d1e8a06@mail.gmail.com>
References: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com>
	 <45943118.3030500@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:39146 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbWL1Xgy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Dec 2006 18:36:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4272480uga
        for <linux-acpi@vger.kernel.org>; Thu, 28 Dec 2006 15:36:52 -0800 (PST)
In-Reply-To: <45943118.3030500@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

Hi,

> Please look at bugzilla.kernel.org #7570, it could be same issue.
...
> > CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later

Thanks for the feedback - but it may be a different problem.  First it
occurs in a fully booted machine on insmod fan.ko (rather than on
resume), and second, the patch for that bug does not fix it
(2.6.20-rc2 tree).

Best,

Matthew
