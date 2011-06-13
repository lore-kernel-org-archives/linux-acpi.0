From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 1/2]intel_idle: fix misuse API - resend
Date: Mon, 13 Jun 2011 10:51:43 +0800
Message-ID: <1307933503.15392.104.camel@sli10-conroe>
References: <1307068954.15392.52.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21125 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380Ab1FMCvp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Jun 2011 22:51:45 -0400
In-Reply-To: <1307068954.15392.52.camel@sli10-conroe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2011-06-03 at 10:42 +0800, Shaohua Li wrote:
> smp_call_function() only lets all other CPUs execute specific
> function, while we expect all CPUs do in intel_idle. Without
> the fix, we could have one cpu has auto_demotion enabled or
> has no boradcast timer setup. Usually we don't see impact
> because auto demotion just harms power and the intel_idle init
> is called in CPU 0, where boradcast timer delivers interrupt,
> but this still could be a problem.
has any comments on these? NACK or merge?

