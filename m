From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] Adding_write_support_to_trip_points
Date: Tue, 26 Oct 2010 10:52:17 +0100
Message-ID: <20101026105217.41eebda5@linux.intel.com>
References: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16889 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab0JZKqz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Oct 2010 06:46:55 -0400
In-Reply-To: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: durgadoss.r@intel.com
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, ramesh.agarwal@intel.com, len.brown@intel.com

On Wed, 27 Oct 2010 01:16:50 +0530
durgadoss.r@intel.com wrote:

> From: R.Durgadoss <durgadoss.r@intel.com>
> 
> This patch makes the thermal trip points 'write'able.
> Thus, enabling the trip points to be configured at runtime.
> Please review and apply.

Is the expectation that these would be set once at platform initialize
or that the trip points would be dynamically managed to generate
interrupts at different points for power management ?

Alan
