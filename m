From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 02/13] ACPI/IPMI: Fix atomic context requirement of ipmi_msg_handler()
Date: Thu, 12 Sep 2013 13:09:53 -0400
Message-ID: <5231F561.3090401@redhat.com>
References: <5231D332.2080602@redhat.com> <2922434.Qm5pumexNE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906Ab3ILREo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 13:04:44 -0400
In-Reply-To: <2922434.Qm5pumexNE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, lv.zheng@intel.com, Don Zickus <dzickus@redhat.com>

On 09/12/2013 11:12 AM, Rafael J. Wysocki wrote:
> On Thursday, September 12, 2013 10:44:02 AM Tony Camuso wrote:
>> Hi, Len.
>>
>> On Jul 23, Lv Zheng submitted this patch (02/13)
>> https://lkml.org/lkml/2013/7/23/96
>>
>> .. and early this month, not having seen Lv's patch, I
>> submitted a virtual identical one, here. 
>> https://lkml.org/lkml/2013/9/2/305
>>
>> We've been seeing lockdep splats that are fixed by this
>> patch, so I'm wondering if Lv's patch will be included
>> in kernel v3.12.
> 
> I actually have a plan to apply your patch, because it doesn't depend on the
> additional changes made by Lv that don't belong in 3.12.
> 
> Thanks,
> Rafael
> 

Yes, that would be great.

Regards,
Tony

