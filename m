From: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
Subject: Re: [PATCH][BUG] fix bug in ACPI based CPU hotplug
Date: Wed, 08 Mar 2006 17:10:42 +0900
Message-ID: <440E9182.4010301@soft.fujitsu.com>
References: <440E8723.7030008@soft.fujitsu.com> <20060307233507.6ad0858f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56795 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932454AbWCHIMU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Mar 2006 03:12:20 -0500
In-Reply-To: <20060307233507.6ad0858f.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

Andrew Morton wrote:
> Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com> wrote:
> 
>>This patch fixes a serious bug in ACPI based CPU hotplug code. Because
>> of this bug, ACPI based CPU hotplug will always fail if NR_CPUS is
>> equal to or more than 255.
> 
> 
> Looks rather similar to
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/broken-out/acpi-signedness-fix-2.patch
> ;)
> 
> I think they're functionally equivalent - the only difference is the ==-1
> versus <0 comparisons.
> 
> 

Oh, I didn't noticed it.
Sorry for the noise.

Thanks,
Kenji Kaneshige


