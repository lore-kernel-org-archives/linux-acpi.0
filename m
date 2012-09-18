From: Youquan Song <youquan.song@linux.intel.com>
Subject: Re: [PATCH V2 1/3] x86,idle: Quickly notice prediction failure for
	repeat mode
Date: Mon, 17 Sep 2012 22:15:15 -0400
Message-ID: <20120918021514.GA6997@linux-youquan.bj.intel.com>
References: <1347933209-25939-1-git-send-email-youquan.song@intel.com> <1347933209-25939-2-git-send-email-youquan.song@intel.com> <50572CD1.700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52411 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205Ab2IQOMb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Sep 2012 10:12:31 -0400
Content-Disposition: inline
In-Reply-To: <50572CD1.700@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: Youquan Song <youquan.song@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, lenb@kernel.org, Youquan Song <youquan.song@linux.intel.com>

> Could I convince you to try out my variation on
> detect_repeating_intervals? :)
>
> http://people.redhat.com/riel/cstate/cstate-stddev-converge.patch
>
> I suspect that small change might help your code adapt to changed
> conditions even faster.

Yes. of course. your patch of cstate-stddev-converge is a good point by
filter some noise first, then calculate further. I will try to integrate
the patch to my patchset, then ask you review tomorrow. 

Thanks
-Youquan

