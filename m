From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] ACPI: Defer enabling of level GPE until all pending
	notifiesdone
Date: Thu, 15 Nov 2007 13:44:42 +0800
Message-ID: <1195105482.31378.1.camel@sli10-conroe.sh.intel.com>
References: <1194828146.32662.3.camel@sli10-conroe.sh.intel.com>
	 <20071113100545.13159.20465.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3364 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbXKOFva (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 00:51:30 -0500
In-Reply-To: <20071113100545.13159.20465.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Tue, 2007-11-13 at 18:05 +0800, Alexey Starikovskiy wrote:
> Level GPE should not be enabled until all work caused by it is done,
> e.g. all Notify() methods are completed.
> This could be accomplished by appending enable_gpe function to the end
> of notify queue.
Patch looks good, but the method is a little tricky, I'd suggest adding
some comments in the code to explain it.

Thanks,
Shaohua
