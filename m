From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC]  [PATCH] ACPI :Remove the EC space handler explicitly	when
 failing in _REG object
Date: Thu, 27 Nov 2008 12:42:08 +0300
Message-ID: <492E6B70.9010006@suse.de>
References: <1227689447.4053.5.camel@yakui_zhao.sh.intel.com>	 <492DAB8B.30409@gmail.com> <1227749343.4053.32.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:36165 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752624AbYK0JmL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 04:42:11 -0500
In-Reply-To: <1227749343.4053.32.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

Zhao Yakui wrote:
> On Thu, 2008-11-27 at 04:03 +0800, Alexey Starikovskiy wrote:
>> This is hardly a "fix", you just disable EC on this machine... Famous 
> Yes. This can't fix the issue on the box of bug11884. 
> But in theory if the incorrect status is returned by
> acpi_install_address_space_handler, the EC space handler should be
> removed explicitly. Right? In such case the EC device will be disabled
> on this box. 
Wrong. If any function is allowed to fail, you should not call counter function
to recover -- you don't call free() on failed malloc(), you don't call close() on
failed open().
>     But if the EC space handler is not removed and EC flag in AML code
> still indicates that EC operation region is already accessible, the EC
> internal register will be accessed in AML code. At the same time the
> memory region pointed by acpi_ec is already freed. This is the fourth
> argument of ec_space_handler.
I already told you and here is second time -- your fixes come in wrong place.
You should fix acpi_install_address_space_handler(), not all the callers of it.
>     In such case if the EC space handler is still accessed, OS will try
> to access the memory region already freed. Maybe the kernel panic will
> be reported and the system can't be booted.
>     In fact we have a similar bug 10237. And on that box of bug10237 OS
> fails in evaluating _REG object and then kernel panic is reported. 
>     The workaround patch is that OS ignores the error and continue to
> initialize EC device if AE_NOT_FOUND is returned by the _REG object.
> In such case the system can be booted very normally.
Yes, and this workaround should not be in EC driver too.
>> "how windows runs on this machine?" is not answered...
> Windows can work well on such boxes while Linux can't work well.This is
> the gap between Linux and windows. It is our target to narrow the gap.
> Maybe on windows the incorrect status returned by EC _REG object is
> ignored by EC driver. In such case the EC device can be initialized
> correctly.
So, why you disable EC driver instead of ignoring error from _REG completely?
By doing this, you are _widening_ the gap, not narrowing it.
Please consider moving 20edd74fcf9ad02c19efba0c13670a7b6b045099 out of the ec.c and
widen it to ignore failure from _REG method completely.
>> Regards,
>> Alex.

