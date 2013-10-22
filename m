From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/9] ACPI, x86: Extended error log driver for x86 platform
Date: Tue, 22 Oct 2013 15:02:17 +0530
Message-ID: <52664621.8070307@linux.vnet.ibm.com>
References: <52657a78162905670f@agluck-desk.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:33179 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab3JVKvw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Oct 2013 06:51:52 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 22 Oct 2013 16:21:49 +0530
In-Reply-To: <52657a78162905670f@agluck-desk.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, "joe@perches.com" <joe@perches.com>, "m.chehab@samsung.com" <m.chehab@samsung.com>, "arozansk@redhat.com" <arozansk@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 10/22/2013 12:33 AM, Luck, Tony wrote:
>> But yes, this is possible and it would make it all even cleaner
>> and simpler by simply not needing the reg/dereg interfaces for
>> mce_ext_err_print but adding it to the chain.
>
> So this is on top of the 9 patch series (using the V4 that Chen Gong
> posted for part 4/9 and V3 for all the others).  Obviously it should
> be folded back into the series if we go this way.
>
> It's a bit simplistic right now - the registered function just returns
> NOTIFY_DONE in all cases so it will not disturb processing by any other
> registered functions - we can make it smarter later.

Looks good. We obviously need to ensure this gets called before EDAC, if 
at all. The other question is w.r.t conflicts with EDAC, which we can 
re-visit as part of the discussions around a new trace event.

Thanks,
Naveen

