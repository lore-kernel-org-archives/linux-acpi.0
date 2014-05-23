From: Lewis Toohey <lewis@toohey.co.uk>
Subject: Re: Bug Report - [Acer Aspire V5-122P] Unable to adjust screen brightness
Date: Fri, 23 May 2014 13:07:33 +0100
Message-ID: <CADNzsyORVbpqUMsZmKzBn_=Ma99dbLhKo_bfw3bvOASLwTkLsA@mail.gmail.com>
References: <CADNzsyM9qiWf_KV4uuNDnkcv7JvCSi00qHiNQTWfVN-pZtWqig@mail.gmail.com>
 <537BFF89.9010806@intel.com> <CADNzsyMn5viCQDc7HXqZiH92BYNp9TZAtMNbuQMAkZXy6hj0Dg@mail.gmail.com>
 <537C9DC5.5040408@intel.com> <CADNzsyO7gzhtng0WmKA9DGZAreEGVsbAJ+KGdgJu+9zr_LyR8g@mail.gmail.com>
 <537EA5B7.9050509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailscan9.extendcp.co.uk ([79.170.43.96]:54628 "EHLO
	mailscan1.extendcp.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751427AbaEWMka (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 May 2014 08:40:30 -0400
Received: from lb1.hi.local ([10.0.1.197] helo=mailscan2.extendcp.co.uk)
	by mailscan-g64.hi.local with esmtp (Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1WnoGT-00083Y-3Q
	for linux-acpi@vger.kernel.org; Fri, 23 May 2014 13:07:57 +0100
Received: from lb1.hi.local ([10.0.1.197] helo=mail44.extendcp.co.uk)
	by mailscan2.extendcp.co.uk with esmtps (UNKNOWN:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1WnoGS-0004Yt-Ca
	for linux-acpi@vger.kernel.org; Fri, 23 May 2014 13:07:56 +0100
Received: from mail-qg0-f47.google.com ([209.85.192.47])
	by mail44.extendcp.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.80.1)
	id 1WnoGR-0004DX-Ge
	for linux-acpi@vger.kernel.org; Fri, 23 May 2014 13:07:55 +0100
Received: by mail-qg0-f47.google.com with SMTP id j107so7815229qga.6
        for <linux-acpi@vger.kernel.org>; Fri, 23 May 2014 05:07:53 -0700 (PDT)
In-Reply-To: <537EA5B7.9050509@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On 23 May 2014 02:34, Aaron Lu <aaron.lu@intel.com> wrote:
> On 05/21/2014 09:02 PM, Lewis Toohey wrote:
>> Hi Aaron
>>
>> I followed your instructions and can report some limited success. I
>> have two interfaces listed in /sys/class/backlight namely:
>>   acpi_video0  radeon_bl0
>>
>> max_brightness for acpi_video0 is 11. Echo-ing new values to
>> brightness appears to have no effect.
>>
>> max_brightness for radeon_bl0 is 255. Echo-ing new values to
>> brightness does adjust the screen brightness as you would expect.
>>
>> Results are the same on both battery and powered.
>>
>> I hope that is useful.
>
> I think Hans' patchset should solve your problem, can you please give it
> a try? You will need to pass the video.use_native_backlight=1 to kernel
> cmdline when testing, thanks.
>
> [PATCH resend 0/4] Make video.use_native_backlight=1 work properly with nouveau
> http://www.spinics.net/lists/dri-devel/msg59941.html
>
> -Aaron

Aaron

Thank you for this. Unfortunately I am going to have to ask you for a
bit of help here as I am now, officially, "out of my depth". I
appreciate this is a pain as you will have to take time explaining it
to me and I apologise for that.

I have figured out how to pass the kernel command line argument, this
is not an issue.

I have located the patch you refer to here:
https://bugzilla.redhat.com/attachment.cgi?id=894577
(which I believe is correct) but I cannot figure out how to apply it.

I copied and pasted that text into a file in my home directory and
called it "backlight.diff". When I ran "patch < backlight.diff" it
complains that it cannot find the file to patch. I am not familiar
with the syntax of a patch file so I can't work out what's going
wrong.

I thought that the diff file might need to be placed relative to the
path referred to within it but "locate nouveau_backlight.c" returns no
results so I don't know where to put it.

Can you advise?

Very grateful for your continued help and patience




-- 
Lewis

Lewis@Toohey.co.uk
0782 588 4158
