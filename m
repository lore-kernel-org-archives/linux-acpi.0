From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] APEI/ERST: Fix error message formatting
Date: Thu, 25 Jul 2013 16:53:20 +0530
Message-ID: <51F10AA8.2050901@linux.vnet.ibm.com>
References: <1374526866-6813-1-git-send-email-bp@alien8.de> <20130724171347.GB29756@naverao1-tp.watson.ibm.com> <1374686598.18818.18.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:48626 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860Ab3GYLXr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2013 07:23:47 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Thu, 25 Jul 2013 16:44:40 +0530
In-Reply-To: <1374686598.18818.18.camel@joe-AO722>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>, Borislav Petkov <bp@alien8.de>, bhelgaas@google.com
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>

On 07/24/2013 10:53 PM, Joe Perches wrote:
> On Wed, 2013-07-24 at 22:43 +0530, Naveen N. Rao wrote:
>> On 2013/07/22 11:01PM, Borislav Petkov wrote:
>>> From: Borislav Petkov <bp@suse.de>
>>>
>>> [    5.525861] ERST: Can not request iomem region <0x        c7eff000-0x        c7f00000> for ERST.
>>>
>>> This needs to have leading zeroes. Make it so.
>
> Why does it need leading zeros?
>
>> While looking at this, I noticed that we seem to be using varying field
>> widths in our APEI code:
>> - einj.c has two instances using %#010llx.
>> - apei-base.c uses widths of 10 (4 bytes) and 6 (2 bytes).
>>
>> Not sure if these are intentional and those fields truly aren't 64-bit
>> (as suggested by the usage of long long int).
>
> I suggest using "0x%llx" everywhere unless there's a
> compelling reason like columnar alignment for them.

I think that might be better. I see that these changes were done in 
commit 46b91e37. Copying Bjorn Helgaas.

On 07/24/2013 11:40 PM, Borislav Petkov wrote:
 > That's an interesting question but I think you're better fitted to
 > answer it - I try to avoid the APEI spec as much as possible.
 >
 > :-)
 >

Oh, I've hardly scratched the surface w.r.t APEI. I think I'll let the 
experts comment on this :)


Thanks,
Naveen

