From: Lewis Toohey <lewis@toohey.co.uk>
Subject: Re: Bug Report - [Acer Aspire V5-122P] Unable to adjust screen brightness
Date: Sat, 24 May 2014 12:23:25 +0100
Message-ID: <CADNzsyPS-PyTER3RPMyxLi3A8izrxaOJQc1SDoeFgbRpTe9nDQ@mail.gmail.com>
References: <CADNzsyM9qiWf_KV4uuNDnkcv7JvCSi00qHiNQTWfVN-pZtWqig@mail.gmail.com>
 <537BFF89.9010806@intel.com> <CADNzsyMn5viCQDc7HXqZiH92BYNp9TZAtMNbuQMAkZXy6hj0Dg@mail.gmail.com>
 <537C9DC5.5040408@intel.com> <CADNzsyO7gzhtng0WmKA9DGZAreEGVsbAJ+KGdgJu+9zr_LyR8g@mail.gmail.com>
 <537EA5B7.9050509@intel.com> <CADNzsyORVbpqUMsZmKzBn_=Ma99dbLhKo_bfw3bvOASLwTkLsA@mail.gmail.com>
 <537F4425.70205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailscan22.extendcp.co.uk ([176.32.226.68]:33805 "EHLO
	mailscan1.extendcp.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750748AbaEXLXw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 May 2014 07:23:52 -0400
Received: from lb1.hi.local ([10.0.1.197] helo=mailscan2.extendcp.co.uk)
	by mailscan-g64.hi.local with esmtp (Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1WoA3K-0000zg-26
	for linux-acpi@vger.kernel.org; Sat, 24 May 2014 12:23:50 +0100
Received: from lb1.hi.local ([10.0.1.197] helo=mail44.extendcp.co.uk)
	by mailscan2.extendcp.co.uk with esmtps (UNKNOWN:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1WoA3I-0006fw-85
	for linux-acpi@vger.kernel.org; Sat, 24 May 2014 12:23:50 +0100
Received: from mail-qc0-f174.google.com ([209.85.216.174])
	by mail44.extendcp.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.80.1)
	id 1WoA3H-00012s-Dx
	for linux-acpi@vger.kernel.org; Sat, 24 May 2014 12:23:47 +0100
Received: by mail-qc0-f174.google.com with SMTP id c9so1600387qcz.19
        for <linux-acpi@vger.kernel.org>; Sat, 24 May 2014 04:23:45 -0700 (PDT)
In-Reply-To: <537F4425.70205@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

On 23 May 2014 13:50, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Lewis et all,
>
> On 05/23/2014 02:07 PM, Lewis Toohey wrote:
>> On 23 May 2014 02:34, Aaron Lu <aaron.lu@intel.com> wrote:
>>> On 05/21/2014 09:02 PM, Lewis Toohey wrote:
>>>> Hi Aaron
>>>>
>>>> I followed your instructions and can report some limited success. I
>>>> have two interfaces listed in /sys/class/backlight namely:
>>>>   acpi_video0  radeon_bl0
>>>>
>>>> max_brightness for acpi_video0 is 11. Echo-ing new values to
>>>> brightness appears to have no effect.
>>>>
>>>> max_brightness for radeon_bl0 is 255. Echo-ing new values to
>>>> brightness does adjust the screen brightness as you would expect.
>>>>
>>>> Results are the same on both battery and powered.
>>>>
>>>> I hope that is useful.
>>>
>>> I think Hans' patchset should solve your problem, can you please give it
>>> a try? You will need to pass the video.use_native_backlight=1 to kernel
>>> cmdline when testing, thanks.
>>>
>>> [PATCH resend 0/4] Make video.use_native_backlight=1 work properly with nouveau
>>> http://www.spinics.net/lists/dri-devel/msg59941.html
>>>
>>> -Aaron
>>
>> Aaron
>>
>> Thank you for this. Unfortunately I am going to have to ask you for a
>> bit of help here as I am now, officially, "out of my depth". I
>> appreciate this is a pain as you will have to take time explaining it
>> to me and I apologise for that.
>>
>> I have figured out how to pass the kernel command line argument, this
>> is not an issue.
>>
>> I have located the patch you refer to here:
>> https://bugzilla.redhat.com/attachment.cgi?id=894577
>> (which I believe is correct) but I cannot figure out how to apply it.
>
> That is not the right patch, you need a set of 2 patches. I've attached
> them to this mail. Note please ignore the numbering starting at 6, these
> are the 2 patches you need. You will need to build a Linux kernel with
> these 2 patches applied, see your distributions documentation on how
> to build a kernel from source.
>
> I don't know which distro you are using, I've a Fedora kernel with this
> patches included available here:
>
> http://people.fedoraproject.org/~jwrdegoede/rhbz1093171/
>
> Regards,
>
> Hans

Hans / Aaron

Just by way of an update, I am trying to test this but have run into
another gap in my knowledge. Essentially I can compile the standard
ubuntu kernel (3.13) but the patch breaks this (I assume because the
patch was written for a  more recent kernel version). I don't know how
to compile upstream kernels for ubuntu and have asked for help here:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1315834/comments/21

I will let you know when I make some progress.

Thank you again for your efforts here. Much appreciated.

-- 
Lewis

Lewis@Toohey.co.uk
0782 588 4158
