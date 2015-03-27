From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 0/7] minor cleanups for ACPI processor driver
Date: Fri, 27 Mar 2015 22:37:28 +0800
Message-ID: <55156B28.9030802@linaro.org>
References: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org> <20150327140336.GG1562@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33235 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbbC0Ohr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2015 10:37:47 -0400
Received: by pdnc3 with SMTP id c3so98498225pdn.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2015 07:37:47 -0700 (PDT)
In-Reply-To: <20150327140336.GG1562@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

Hi Will,

On 2015=E5=B9=B403=E6=9C=8827=E6=97=A5 22:03, Will Deacon wrote:
> Hanjun,
>
> On Fri, Mar 27, 2015 at 01:55:04PM +0000, Hanjun Guo wrote:
>> This patch set are some minor cleanups for ACPI processor driver
>> to address the comments which raised by Rafael in ARM64 ACPI core
>> patches, so this patch set is on top of ARM64 ACPI core patches
>> the git tree is
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>> branch for-next/acpi.
>>
>> Rafael, I assume this patchset will be taken with your tree if
>> it makes sense, any rebase work needed please let me know.
>>
>> the last patch - ACPI / processor: Introduce invalid_phys_cpuid()
>> will cut u64 mpidr to int, but I think it is ok for error values,
>> correct me if I'm wrong.
>
> I appreciate that you probably have a bunch of code building on top o=
f
> the series that's in linux-next, but sending it out at the moment is
> hugely confusing -- particularly when this is targetting an independe=
nt
> tree. If you have patches for 4.2, please can you wait until after th=
e
> merge window before posting for review?

OK, thanks for the reminding, I didn't mean any confusion but actually
I did, sorry for that.

>
> Right now most maintainers are probably trying to stabilise their cur=
rent
> queues, so the most helpful thing you can do is test linux-next and s=
end
> fixes for any issues you find there.

Sure, I will test linux-next on ARM64 platforms and x86 too.

>
> It doesn't help that the series you posted seems to include two patch
> series (n/7 and n/2).

oh, side effects of staying up all night for the firmware mini-summit,
please take those two patches for ARM64 ACPI if it is OK to you.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
