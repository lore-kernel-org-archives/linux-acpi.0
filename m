From: Alex Shi <alex.shi@intel.com>
Subject: Re: [LKP] Commit ac3ebafa81a makes NHM EX/EP machines hung out since
 3.9-rc1
Date: Wed, 27 Mar 2013 21:28:18 +0800
Message-ID: <5152F3F2.3080900@intel.com>
References: <20130313022759.GA120840@bee> <5152781B.6060603@intel.com> <5152EFEB.7030107@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40439 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab3C0N21 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Mar 2013 09:28:27 -0400
In-Reply-To: <5152EFEB.7030107@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Changlong Xie <changlongx.xie@intel.com>, linux-acpi@vger.kernel.org, lkp@linux.intel.com

On 03/27/2013 09:11 PM, Daniel Lezcano wrote:
> Hi Alex,
> 
> could you elaborate a bit the explanation. I don't see where is the
> analysis of the bug. Why do we have this stack trace ?

I also don't know much details of the mwait setting for cpu idle, and
can not reproduce the ops on my box. Most of time the nhm box is just hang.

Maybe BIOS setting have bugs and your change is just expose them.

but it is clear inappropriate to change percpu cstate to a unified
unique value, while left lots of percpu struct service for this. A
example of x86, you can look into arch/x86/kernel/acpi/cstate.c and
other acpi head files.

-- 
Thanks
    Alex
