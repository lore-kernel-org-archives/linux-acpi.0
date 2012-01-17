From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 1/3] intel_idle: fix API misuse
Date: Tue, 17 Jan 2012 11:37:58 +0100
Message-ID: <201201171137.58857.trenn@suse.de>
References: <20120110234819.7F484100270@wpzn3.hot.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45902 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab2AQKiB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 05:38:01 -0500
In-Reply-To: <20120110234819.7F484100270@wpzn3.hot.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, shaohua.li@intel.com

On Wednesday, January 11, 2012 12:48:19 AM akpm@linux-foundation.org wrote:
> From: Shaohua Li <shaohua.li@intel.com>
> Subject: intel_idle: fix API misuse

This one looks worth adding:
CC: stable@vger.kernel.org

 
> smp_call_function() only lets all other CPUs execute a specific function,
> while we expect all CPUs do in intel_idle.  Without the fix, we could have
> one cpu which has auto_demotion enabled or has no boradcast timer setup. 
> Usually we don't see impact because auto demotion just harms power and the
> intel_idle init is called in CPU 0, where boradcast timer delivers
> interrupt, but this still could be a problem.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
CC: stable@vger.kernel.org

   Thomas
