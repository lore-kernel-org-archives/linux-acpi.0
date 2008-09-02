From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 12:36:40 +0400
Message-ID: <48BCFB18.60706@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <48BB9E86.7070503@suse.de> <1220320791.4039.128.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:40221 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751383AbYIBIge (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2008 04:36:34 -0400
In-Reply-To: <1220320791.4039.128.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> Maybe I don't understand what you said fully. The following is my
> understanding about the patches of bug 11428 and bug 10724.
> 
> a. In the patch of bug 11428 the EC GPE won't be disabled when timeout
> happens, which means that it is still possible to switch EC working mode
> again from polling mode to interrupt mode. i.e. EC can still be switched
> to interrupt mode again. In the current upstream kernel when timeout
> happens, EC will be switched to polling mode and can't be switched to
> interrupt mode again(EC GPE is disabled). Right?
Wrong. EC GPE will stay enabled, driver will just not use it during wait for completion.

>     In fact when EC timeout happens in interrupt mode, it indicates that
> EC controller can't return response in time.
Wrong. Some EC controllers are "optimized" to not send interrupts for each confirmation.
See history of EC patches for these optimization workarounds.

>    In the above source code maybe there exists the following phenomenon:
>      When the EC GPE interrupt is triggered, the waiting process will be
>      waked up in the GPE interrupt service routine. But as the process
>      can't be scheduled immediately, maybe the wait_event_timeout will
>      also return 0, which means that timeout happens and EC will be
>      switched from interrupt mode to polling mode.
We are speaking about 500msec timeout here. it needs at least 50+ ready to run tasks of same
kernel priority to not let queue thread run. Please tell me, how could this happen?

