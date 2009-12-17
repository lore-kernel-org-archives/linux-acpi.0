From: "Youquan,Song" <youquan.song@linux.intel.com>
Subject: Re: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Thu, 17 Dec 2009 06:19:26 -0500
Message-ID: <20091217111926.GA11466@youquan-linux.bj.intel.com>
References: <20091212181442.GA22832@youquan-linux.bj.intel.com> <alpine.LFD.2.00.0912160419400.30935@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:38782 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758333AbZLQDoC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 22:44:02 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912160419400.30935@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Youquan,Song" <youquan.song@linux.intel.com>, venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

> I believe that powertop is bugged in how it reverse-engineers
> the C-state names and displays hardware names.  I think that
> we should put the hardware names in /sysfs and it should
> simply use them -- but more on that later.

Hi Len Brown,

I got it. Thanks for your explanation.

So, Can I consider that you have agreed with the patch [Resend PATCH]
acpi c-states: Fix multiply C-states name disturbance?

BTW:I also have interest to make powertop keep compatible with this change
if it is needed.
 
Thanks.

-Youquan

