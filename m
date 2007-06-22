From: Tim Gardner <tim.gardner@canonical.com>
Subject: Re: ACPI Regression on Dell E1501
Date: Fri, 22 Jun 2007 07:18:55 -0600
Message-ID: <467BCC3F.4080405@canonical.com>
References: <467AE7E1.4050805@canonical.com>  <467AF204.3060805@redhat.com> <1182462902.3316.105.camel@chaos> <467BC9F8.5000403@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756979AbXFVNSj@vger.kernel.org>
In-Reply-To: <467BC9F8.5000403@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Chuck Ebbert <cebbert@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Tim Gardner wrote:
> Thomas Gleixner wrote:
>> On Thu, 2007-06-21 at 17:47 -0400, Chuck Ebbert wrote:
>>> On 06/21/2007 05:04 PM, Tim Gardner wrote:
>>>> Hi,
>>>>
>>>> Commit e9e2cdb412412326c4827fc78ba27f410d837e6e breaks boot on a Dell
>>>> E1501 unless 'acpi=off' is specified (also tried nolapic and nohpet but
>>>> it made no substantive difference). This laptop is an 'AMD Turion(tm) 64
>>>> X2 Mobile Technology TL-50' CPU, but its booting 32 bit SMP (make
>>>> defconfig). No kernel built after this commit works for this platform.
>>>>
>>>> There is no crash output, it just wedges after 'NET: Registered protocol
>>>> family 2'.
>>>>
>>>> How can I debug this problem?
>>> That'll be fun.
>>>
>>> That's:
>>>
>>> 	[PATCH] clockevents: i386 drivers
>>>
>>> [Author cc: added]
>> I'm going nuts on this. 
>>
>> Tim, 
>>
>> 1.) are you booting a 32bit or a 64 bit kernel ?
>>
>> 2.) Can you please try 2.6.22-rc5 + 
>> http://www.tglx.de/projects/hrtimers/2.6.22-rc5/patch-2.6.22-rc5-hrt1.patch
>> 	whether this makes any difference 
>>
>> Thanks,
>>
>> 	tglx
>>
> 
> Thomas,
> 
> Your patch (large though it is) did not make any outward difference. As
> usual, adding 'acpi=off' allows it to boot.
> 
> rtg

Perhaps I was too hasty. Adding 'acpi=off' did not allow it to boot. The
IDE drive was detected, but I did not see any partitions detected.
Eventually it dropped to the initrd shell when it could not find a root
filesystem. Anyways, this is likely a side issue.

rtg
-- 
Tim Gardner tim.gardner@ubuntu.com
