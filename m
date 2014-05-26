From: Lewis Toohey <lewis@toohey.co.uk>
Subject: Re: Bug Report - [Acer Aspire V5-122P] Unable to adjust screen brightness
Date: Mon, 26 May 2014 20:09:48 +0100
Message-ID: <CADNzsyMEi-e6d=zLET6YAtJxsyPmUdWRs6rEDt9xrf9R63uW0Q@mail.gmail.com>
References: <CADNzsyM9qiWf_KV4uuNDnkcv7JvCSi00qHiNQTWfVN-pZtWqig@mail.gmail.com>
 <537BFF89.9010806@intel.com> <CADNzsyMn5viCQDc7HXqZiH92BYNp9TZAtMNbuQMAkZXy6hj0Dg@mail.gmail.com>
 <537C9DC5.5040408@intel.com> <CADNzsyO7gzhtng0WmKA9DGZAreEGVsbAJ+KGdgJu+9zr_LyR8g@mail.gmail.com>
 <537EA5B7.9050509@intel.com> <CADNzsyORVbpqUMsZmKzBn_=Ma99dbLhKo_bfw3bvOASLwTkLsA@mail.gmail.com>
 <537F4425.70205@redhat.com> <CADNzsyMCnbNu6CbWfV73CM99Qs=Lw22Q8pSQ23O31sopNDpaig@mail.gmail.com>
 <5382D5C6.5080001@intel.com> <CADNzsyNwvGeeLzM54_CkA4tWCYnNVoRyewuqXx0vXH3t4shWHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailscan24.extendcp.co.uk ([176.32.226.70]:49942 "EHLO
	mailscan1.extendcp.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751308AbaEZTKP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 May 2014 15:10:15 -0400
Received: from lb1.hi.local ([10.0.1.197] helo=mailscan2.extendcp.co.uk)
	by mailscan-g66.hi.local with esmtp (Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1Wp0Hk-0002GA-Gw
	for linux-acpi@vger.kernel.org; Mon, 26 May 2014 20:10:12 +0100
Received: from lb1.hi.local ([10.0.1.197] helo=mail44.extendcp.co.uk)
	by mailscan2.extendcp.co.uk with esmtps (UNKNOWN:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1Wp0Hi-0002jo-Vq
	for linux-acpi@vger.kernel.org; Mon, 26 May 2014 20:10:12 +0100
Received: from mail-qg0-f49.google.com ([209.85.192.49])
	by mail44.extendcp.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.80.1)
	id 1Wp0Hh-0007z2-V3
	for linux-acpi@vger.kernel.org; Mon, 26 May 2014 20:10:10 +0100
Received: by mail-qg0-f49.google.com with SMTP id a108so12245888qge.8
        for <linux-acpi@vger.kernel.org>; Mon, 26 May 2014 12:10:08 -0700 (PDT)
In-Reply-To: <CADNzsyNwvGeeLzM54_CkA4tWCYnNVoRyewuqXx0vXH3t4shWHw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

On 26 May 2014 13:18, Lewis Toohey <lewis@toohey.co.uk> wrote:
> On 26 May 2014 06:48, Aaron Lu <aaron.lu@intel.com> wrote:
>> On 05/26/2014 04:42 AM, Lewis Toohey wrote:
>>> On 23 May 2014 13:50, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi Lewis et all,
>>>>
>>>> On 05/23/2014 02:07 PM, Lewis Toohey wrote:
>>>>> On 23 May 2014 02:34, Aaron Lu <aaron.lu@intel.com> wrote:
>>>>>> On 05/21/2014 09:02 PM, Lewis Toohey wrote:
>>>>>>> Hi Aaron
>>>>>>>
>>>>>>> I followed your instructions and can report some limited success. I
>>>>>>> have two interfaces listed in /sys/class/backlight namely:
>>>>>>>   acpi_video0  radeon_bl0
>>>>>>>
>>>>>>> max_brightness for acpi_video0 is 11. Echo-ing new values to
>>>>>>> brightness appears to have no effect.
>>>>>>>
>>>>>>> max_brightness for radeon_bl0 is 255. Echo-ing new values to
>>>>>>> brightness does adjust the screen brightness as you would expect.
>>>>>>>
>>>>>>> Results are the same on both battery and powered.
>>>>>>>
>>>>>>> I hope that is useful.
>>>>>>
>>>>>> I think Hans' patchset should solve your problem, can you please give it
>>>>>> a try? You will need to pass the video.use_native_backlight=1 to kernel
>>>>>> cmdline when testing, thanks.
>>>>>>
>>>>>> [PATCH resend 0/4] Make video.use_native_backlight=1 work properly with nouveau
>>>>>> http://www.spinics.net/lists/dri-devel/msg59941.html
>>>>>>
>>>>>> -Aaron
>>>>>
>>>>> Aaron
>>>>>
>>>>> Thank you for this. Unfortunately I am going to have to ask you for a
>>>>> bit of help here as I am now, officially, "out of my depth". I
>>>>> appreciate this is a pain as you will have to take time explaining it
>>>>> to me and I apologise for that.
>>>>>
>>>>> I have figured out how to pass the kernel command line argument, this
>>>>> is not an issue.
>>>>>
>>>>> I have located the patch you refer to here:
>>>>> https://bugzilla.redhat.com/attachment.cgi?id=894577
>>>>> (which I believe is correct) but I cannot figure out how to apply it.
>>>>
>>>> That is not the right patch, you need a set of 2 patches. I've attached
>>>> them to this mail. Note please ignore the numbering starting at 6, these
>>>> are the 2 patches you need. You will need to build a Linux kernel with
>>>> these 2 patches applied, see your distributions documentation on how
>>>> to build a kernel from source.
>>>>
>>>> I don't know which distro you are using, I've a Fedora kernel with this
>>>> patches included available here:
>>>>
>>>> http://people.fedoraproject.org/~jwrdegoede/rhbz1093171/
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>
>>> Hans
>>>
>>> Unfortunately I am unable to apply these patches against the latest
>>> mainline kernel. I get two fails when applying the second patch file
>>> and then the kernel will not compile. Please see output information
>>> below.
>>
>> I've prepared a git branch for you:
>> https://github.com/aaronlu/linux.git for-lewis
>>
>> It's based on Rafael's linux-next plus Hans' patch 2 and 3.
>>
>> Thanks,
>> Aaron
>>
>>>
>>> Can you advise?
>>>
>>> Many thanks
>>>
>>> ===APPLYING PATCHES TO LATEST MAINLINE KERNEL====
>>>
>>> lewis@HappyFunMeaowMeaow:~/KernelTesting/Kernel/linux$ patch -p1 <
>>> 0006-backlight-Add-backlight-device-un-registration-notif.patch
>>> (Stripping trailing CRs from patch; use --binary to disable.)
>>> patching file drivers/video/backlight/backlight.c
>>> (Stripping trailing CRs from patch; use --binary to disable.)
>>> patching file include/linux/backlight.h
>>> lewis@HappyFunMeaowMeaow:~/KernelTesting/Kernel/linux$ patch -p1 <
>>> 0007-acpi-video-Unregister-the-backlight-device-if-a-raw-.patch
>>> (Stripping trailing CRs from patch; use --binary to disable.)
>>> patching file drivers/acpi/video.c
>>> Hunk #1 FAILED at 151.
>>> Hunk #2 succeeded at 161 (offset -1 lines).
>>> Hunk #3 FAILED at 1837.
>>> Hunk #4 succeeded at 1868 (offset -113 lines).
>>> Hunk #5 succeeded at 1999 (offset -113 lines).
>>> Hunk #6 succeeded at 2023 (offset -113 lines).
>>> 2 out of 6 hunks FAILED -- saving rejects to file drivers/acpi/video.c.rej
>>>
>>>
>>> ==LAST LINES OF BUILD BEFORE FAIL===
>>>
>>>   CC [M]  fs/xfs/xfs_ioctl32.o
>>>   LD [M]  fs/xfs/xfs.o
>>> make[1]: Leaving directory `/home/lewis/KernelTesting/Kernel/linux'
>>> make: *** [debian/stamp/build/kernel] Error 2
>>> lewis@HappyFunMeaowMeaow:~/KernelTesting/Kernel/linux$
>>>
>>>
>>
>
> Aaron
>
> Many thanks for this. I can confirm that booting with this kernel and
> passing the video.use_native_backlight = 1 argument means that the
> backlight works perfectly on my laptop (both using the keyboard hot
> keys and the gnome/unity settings applet).
>
> I'll post to the ubuntu launchpad page later with instructions for
> other people to do this. I assume its presence in the linux-next tree
> means that it will be fixed in an upcoming kernel release? (sorry, I
> don't know quite how the process works).
>
> If I can provide more information or do some more useful testing
> please do not hesitate to let me know.
>
> Thank you both for your help - really appreciated.
>
> --
> Lewis
>

Aaron

Just one final point in case it is relevant / useful - although it
fixes the backlight issue this kernel version breaks the suspend
resume functionality for me (the system will suspend but cannot come
back from it).

Not asking for a fix (appreciate it is a testing base), just thought
it might be useful to know.

Thanks again


-- 
Lewis

Lewis@Toohey.co.uk
0782 588 4158
