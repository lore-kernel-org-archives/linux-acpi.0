From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH] Adding_write_support_to_trip_points
Date: Tue, 26 Oct 2010 16:19:38 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF04654105BED797D1@bgsmsx502.gar.corp.intel.com>
References: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
 <20101026105217.41eebda5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32336 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759733Ab0JZKu0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2010 06:50:26 -0400
In-Reply-To: <20101026105217.41eebda5@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Agarwal, Ramesh" <ramesh.agarwal@intel.com>, "Brown, Len" <len.brown@intel.com>

> Is the expectation that these would be set once at platform initialize
> or that the trip points would be dynamically managed to generate
> interrupts at different points for power management ?

Yes. The trip points would be dynamically managed to generate
interrupts at various temperatures.

Thanks,
Durgadoss
