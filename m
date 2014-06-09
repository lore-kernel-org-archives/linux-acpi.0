From: Lewis Toohey <lewis@toohey.co.uk>
Subject: Re: Bug Report - [Acer Aspire V5-122P] Unable to adjust screen brightness
Date: Mon, 9 Jun 2014 08:38:35 +0100
Message-ID: <CADNzsyPQFwYwfPkFDX5BtpiGBGJM75KK-AJPE-O6YYWehGxUow@mail.gmail.com>
References: <CADNzsyM9qiWf_KV4uuNDnkcv7JvCSi00qHiNQTWfVN-pZtWqig@mail.gmail.com>
 <537BFF89.9010806@intel.com> <CADNzsyMn5viCQDc7HXqZiH92BYNp9TZAtMNbuQMAkZXy6hj0Dg@mail.gmail.com>
 <537C9DC5.5040408@intel.com> <CADNzsyO7gzhtng0WmKA9DGZAreEGVsbAJ+KGdgJu+9zr_LyR8g@mail.gmail.com>
 <537EA5B7.9050509@intel.com> <CADNzsyORVbpqUMsZmKzBn_=Ma99dbLhKo_bfw3bvOASLwTkLsA@mail.gmail.com>
 <537F4425.70205@redhat.com> <CADNzsyMCnbNu6CbWfV73CM99Qs=Lw22Q8pSQ23O31sopNDpaig@mail.gmail.com>
 <5382D5C6.5080001@intel.com> <CADNzsyNwvGeeLzM54_CkA4tWCYnNVoRyewuqXx0vXH3t4shWHw@mail.gmail.com>
 <CADNzsyMEi-e6d=zLET6YAtJxsyPmUdWRs6rEDt9xrf9R63uW0Q@mail.gmail.com>
 <5383E68C.9030000@intel.com> <CADNzsyMmEtvPeoKgsRyeNrxY2hH8ZJ_xhH5nLmVTtey3ad=jSg@mail.gmail.com>
 <538D2359.4080102@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailscan26.extendcp.co.uk ([176.32.226.72]:35158 "EHLO
	mailscan1.extendcp.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751120AbaFIHjB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2014 03:39:01 -0400
Received: from lb1.hi.local ([10.0.1.197] helo=mailscan4.hi.local)
	by mailscan-g67.hi.local with esmtp (Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1WtuAV-0000jQ-80
	for linux-acpi@vger.kernel.org; Mon, 09 Jun 2014 08:38:59 +0100
Received: from lb1.hi.local ([10.0.1.197] helo=mail44.extendcp.co.uk)
	by mailscan4.hi.local with esmtps (UNKNOWN:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1WtuAU-0004vc-3k
	for linux-acpi@vger.kernel.org; Mon, 09 Jun 2014 08:38:59 +0100
Received: from mail-qa0-f45.google.com ([209.85.216.45])
	by mail44.extendcp.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.80.1)
	id 1WtuAS-0000ld-TJ
	for linux-acpi@vger.kernel.org; Mon, 09 Jun 2014 08:38:56 +0100
Received: by mail-qa0-f45.google.com with SMTP id hw13so7523754qab.32
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jun 2014 00:38:55 -0700 (PDT)
In-Reply-To: <538D2359.4080102@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

On 3 June 2014 02:22, Aaron Lu <aaron.lu@intel.com> wrote:
> On 05/30/2014 09:12 PM, Lewis Toohey wrote:
>> Aaron
>>
>> I am in the process of performing this bisection, however, I need a
>> bit of advice.
>>
>> I have got a mix of results following suspend right through from (i)
>> system reboot; (ii) "low graphics mode" error; (iii) restore but
>> sluggish performance; and (iv) restore but *very* sluggish
>> performance.
>
> Is the sluggish performance experienced with a GUI environment?
>
>>
>> What should qualify as a bad commit? Anything other than a "perfect" restore?
>
> I think ii/iii/iv all qualify as bad, if there is no such problem
> in previous kernels. And yes, a perfect restore is expected, assume
> the system is able to do a perfect restore with old kernels.
>
> Thanks,
> Aaron
>
>>
>> Many thanks
>>

Hi Aaron

Firstly, yes the sluggish performance I was referring to is
experienced in the GUI environment. Jerky graphics and CPU fan appears
to max out and stay there. Old kernels (e.g. the Ubuntu default
kernel) do not do this and just restore perfectly.

I have completed the bisect as requested. Please find the full log
below. I am slightly unconvinced, as building the previous commit in
the log still seems to have the same problem, however, that commit is
a "merge" and I don't really know what this means.

Many thanks

Bisect Log:
git bisect start
# good: [455c6fdbd219161bd09b1165f11699d6d73de11c] Linux 3.14
git bisect good 455c6fdbd219161bd09b1165f11699d6d73de11c
# bad: [c9eaa447e77efe77b7fa4c953bd62de8297fd6c5] Linux 3.15-rc1
git bisect bad c9eaa447e77efe77b7fa4c953bd62de8297fd6c5
# good: [cd6362befe4cc7bf589a5236d2a780af2d47bcc9] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good cd6362befe4cc7bf589a5236d2a780af2d47bcc9
# good: [d2b150d0647e055d7a71b1c33140280550b27dd6] Merge tag 'sh-3.15'
of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good d2b150d0647e055d7a71b1c33140280550b27dd6
# good: [5fb6b953bb7aa86a9c8ea760934982cedc45c52b]
include/linux/syscalls.h: add sys_renameat2() prototype
git bisect good 5fb6b953bb7aa86a9c8ea760934982cedc45c52b
# bad: [ffddc5fd19b219f557fd4a81168ce8784a4faced] fs/ncpfs/dir.c: fix
indenting in ncp_lookup()
git bisect bad ffddc5fd19b219f557fd4a81168ce8784a4faced
# bad: [978c6050165bba52eab7ef3581d447eb215def77] Merge branch
'drm-docs' of ssh://people.freedesktop.org/~danvet/drm into drm-next
git bisect bad 978c6050165bba52eab7ef3581d447eb215def77
# bad: [262de1453184f65e5ccfe45790f93d41f7339d49] drm/i915: Directly
return the vma from bind_to_vm
git bisect bad 262de1453184f65e5ccfe45790f93d41f7339d49
# bad: [031994ee8dedfa69d3a7caa43e93f3c282bc38f9] drm/i915: Implement
WaIncreaseL3CreditsForVLVB0:vlv
git bisect bad 031994ee8dedfa69d3a7caa43e93f3c282bc38f9
# bad: [f72d21eddfa900bfa2674195dcc0203e18d0cc62] drm/i915: Place the
Global GTT VM first in the list of VM
git bisect bad f72d21eddfa900bfa2674195dcc0203e18d0cc62
# bad: [d6660add648d10e7e35085d8c7d2653e0f9f61b7] drm/i915: Generalize
PPGTT init
git bisect bad d6660add648d10e7e35085d8c7d2653e0f9f61b7
# bad: [b731d33d05dd5ce6b387cbadb0d9d24cb3732b40] drm/i915: relax
context alignment
git bisect bad b731d33d05dd5ce6b387cbadb0d9d24cb3732b40
# bad: [a7b910789f77afa40ae0816d22339e9d25723c6e] drm/i915: Add vm to
error BO capture
git bisect bad a7b910789f77afa40ae0816d22339e9d25723c6e
# bad: [6e164c3382314a1f63526fa7a4322a17318d0e32] drm/i915: Allow ggtt
lookups to not WARN
git bisect bad 6e164c3382314a1f63526fa7a4322a17318d0e32
# bad: [6f425321e02a1b6c5e90b70f8fab7c140fcaeefb] drm/i915: Don't
unconditionally try to deref aliasing ppgtt
git bisect bad 6f425321e02a1b6c5e90b70f8fab7c140fcaeefb
# bad: [e178f7057b81c87a7ceaae0ca204487b6f7eedcf] drm/i915: Provide
PDP updates via MMIO
git bisect bad e178f7057b81c87a7ceaae0ca204487b6f7eedcf
# first bad commit: [e178f7057b81c87a7ceaae0ca204487b6f7eedcf]
drm/i915: Provide PDP updates via MMIO
