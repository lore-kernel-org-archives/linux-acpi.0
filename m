From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Kernel Bug Tracker Bug 9823 - battery info sometimes not
	available
Date: Fri, 26 Dec 2008 09:13:18 +0800
Message-ID: <1230253998.4091.55.camel@yakui_zhao.sh.intel.com>
References: <1c5deb10c6ae1b45f3ddc44869f34619@hunix.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58515 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbYLZBDa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Dec 2008 20:03:30 -0500
In-Reply-To: <1c5deb10c6ae1b45f3ddc44869f34619@hunix.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frank Klaassen <frank@hunix.nl>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Fri, 2008-12-26 at 03:22 +0800, Frank Klaassen wrote:
> Hello ykzao,
> 
> I'm having some problems with my battery on my GX700. 
> In this bug (http://bugzilla.kernel.org/show_bug.cgi?id=9823) you submitted
> several patches which should fix it, and apparently does.
> 
> Now, this patch should be in 2.6.27 right? I checked out the source but I
> couldn't find your lines of code.
> Maybe know whats the deal with that.
Thanks for caring this problem.
    The issue on the box of bug9823 is fixed by the following commit:
    >commit 9d699ed92a459cb408e2577e8bbeabc8ec3989e1
    >Author: Zhao Yakui <yakui.zhao@intel.com>
    >Date:   Mon Aug 11 10:33:31 2008 +0800
       >ACPI: Avoid bogus EC timeout when EC is in Polling mode
   
   This is shipped in 2.6.27.1/2/3/4 stable kernel. But then it is
replaced by other patches.

Will you please try the latest kernel and see whether the issue still
exists?
   If exists, please file a bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI and attach the
output of acpidump, dmesg, /proc/acpi/battery/*/*
    Now the issue related with EC is handled by Alexey.
   Thanks.


> 
> I hope to hear from you soon.
> 
> Kind Regards,
> 
> Frank Klaassen
> Hogeschool Utrecht Linux Kennisgroep

