From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 2/2] update mutex usage in aggregator driver
Date: Thu, 17 Dec 2009 08:54:33 +0800
Message-ID: <20091217005433.GA12894@sli10-desk.sh.intel.com>
References: <1260754949-11239-1-git-send-email-gong.chen@linux.intel.com>
 <1260754949-11239-2-git-send-email-gong.chen@linux.intel.com>
 <1260754949-11239-3-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23302 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798AbZLQAyf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Dec 2009 19:54:35 -0500
Content-Disposition: inline
In-Reply-To: <1260754949-11239-3-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Mon, Dec 14, 2009 at 09:42:29AM +0800, Chen Gong wrote:
> I have 2 issues.
>  1. I consider thread creation and RR thread execution don't share the
> global data, so the serialization execution is not necessary. It is
> enough to use another different mutex to lock thread exectuion itself
> when these threads running concurrently.
>  2. part of sysfs interfaces doesn't need to own mutex with thread createion.
> Though some data maybe are not identical, it is not a big deal.
ACK the first patch.
NACK this one. I don't see any reason we need two locks here. This isn't hot
code path, fine-grained lock just makes thing complex.

Thanks,
Shaohua 
