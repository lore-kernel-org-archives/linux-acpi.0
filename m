From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH] Adding_write_support_to_trip_points
Date: Tue, 26 Oct 2010 14:52:37 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF04654105BED7972A@bgsmsx502.gar.corp.intel.com>
References: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
 <alpine.LFD.2.00.1010260457100.11036@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7450 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab0JZJXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2010 05:23:34 -0400
In-Reply-To: <alpine.LFD.2.00.1010260457100.11036@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Agarwal, Ramesh" <ramesh.agarwal@intel.com>, "Brown, Len" <len.brown@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>

> The reason is that the FIRMWARE is responsible for deciding when
> to notify Linux if when a trip point actually trips -- and if the
> firmware doesn't know that your trip point has moved, then
> its notifications effectively become random, and the user
> has been fooled into thinking that the trip point they moved
> actually does something, when it may do nothing.

I am trying to add this support for the platform DTS, for which
the thresholds need to be configured at run time.

In this case, the firmware is not involved. Also, the new
thresholds are written into the h/w registers. So, everybody
down the stack, will know that the trip points have moved. And
notifications will be w.r.t the newly written thresholds only.


Thanks,
Durgadoss
