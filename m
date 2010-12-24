From: Youquan Song <youquan.song@linux.intel.com>
Subject: Re: [PATCH 0/6] cpufreq: Add sampling window to enhance ondemand
	governor power efficiency
Date: Thu, 23 Dec 2010 22:06:27 -0500
Message-ID: <20101224030627.GA9850__47286.2589209855$1293112665$gmane$org@linux-youquan.bj.intel.com>
References: <1293085424-18212-1-git-send-email-youquan.song@intel.com> <20101223110020.GC18363@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15640 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab0LWN5h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Dec 2010 08:57:37 -0500
Content-Disposition: inline
In-Reply-To: <20101223110020.GC18363@comet.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Youquan Song <youquan.song@intel.com>, davej@redhat.com, cpufreq@vger.kernel.org, venki@google.com, arjan@linux.intel.com, lenb@kernel.

> Interesting approach, but seems to be quite different from what "ondemand"
> does at the moment. And, as David Niemi pointed out, it seems to be more
> Intel-specific. Therefore, what do you think about adding this different
> algorithm as a different governor, and keep the "ondemand" algorithm more or
> less as it is?

Good suggestion! I will write a different governor soon if nobody
oppose.

Thanks
-Youquan
