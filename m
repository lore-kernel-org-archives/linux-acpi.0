From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: 2.6.18-rc5 -rc5-mm1: kacpid continuously generating 4% CPU load
 on HPC nx6325 w/ SUSE 10.1
Date: Tue, 05 Sep 2006 20:19:43 +0400
Message-ID: <44FDA39F.3060302@linux.intel.com>
References: <200609031123.02237.rjw@sisk.pl> <200609051447.24820.luming.yu@intel.com> <200609051313.24716.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:50848 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932167AbWIEQWZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Sep 2006 12:22:25 -0400
In-Reply-To: <200609051313.24716.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yu Luming <luming.yu@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Stefan Seyfried <seife@suse.de>

Please try a patch from #5534 bug report, it seems you have the same deadlock as all other HP users.

Rafael J. Wysocki wrote:
> On Tuesday, 5 September 2006 08:47, Yu Luming wrote:
>> On Sunday 03 September 2006 17:23, Rafael J. Wysocki wrote:
>>> Hi,
>>>
>>>  I'm having a strange issue with the 2.6.18-rc5 and -rc5-mm1 kernels and
>>>  SUSE 10.1 on HPC nx6325 that kacpid is generating 4% of CPU load (on one
>>> core) in a continuous manner.
>> Please try to unload thermal module.
> 
> albercik:~ # rmmod thermal
> 
> [hanging? On another console:]
> albercik:~ # ps ax
> ...
> 4864 pts/0    D+     0:00 rmmod thermal
> ...
> 
>>>  It sometimes helps if powersaved is restarted, but only for a short time.
>>>  However, after restarting powersaved the kacpid-generated load sometimes
>>> jumps to 100% (on one core) and stays on this level.
>>>
>>>  At the same time the battery is never reported to be 100% full (it stops
>>> at ~98% full and loading) and when I tried to unload the battery module,
>>> rmmod ended up in the D state.
>> what do you mean by "in the D state"?
> 
> TASK_UNINTERRUPTIBLE (like above).
> 
> Greetings,
> Rafael
> 
> 
