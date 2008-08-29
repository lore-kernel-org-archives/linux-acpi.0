From: "Eduard Huguet" <eduardhc@gmail.com>
Subject: Re: Suspend to RAM in an Asus P1-AH2
Date: Fri, 29 Aug 2008 12:21:44 +0200
Message-ID: <617be8890808290321s6a9ec689r5a71c78f1fea86cb@mail.gmail.com>
References: <617be8890808270739gdba5c46q6cae8c33668d6bba@mail.gmail.com>
	 <617be8890808270740l4d64c977n17156cf2f7a6dcad@mail.gmail.com>
	 <200808272215.15035.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:4081 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYH2KVp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Aug 2008 06:21:45 -0400
Received: by yx-out-2324.google.com with SMTP id 8so430623yxm.1
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2008 03:21:44 -0700 (PDT)
In-Reply-To: <200808272215.15035.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

Hi,
    I've tested the current git-sources-2.6.27-rc4 on Gentoo with the
suggested ACPI setting at kernel boot. Although the results are not
exactly satisfactory, at least they are different: now, when using
hibernate-ram the machine seems to effectively hibernate (entering S3
state), as I can hear how the hard disk is parked and the CPU fan
stops (which was not happening before...). Brief, the machine would
look simply "powered off" if weren't by the power led, that keeps
blinking at 1 Hz. I guess this is how S3 state should look like in
this machine, shouldn't it...?

However, pressing again the power button doesn't seem to resume from
RAM, instead the machine simply boots up normally (using previous
kernels, pushing power button did nothing, as the machine was dead - I
had to power it off manually and boot).

Am I missing something...?


Best regards,
  Eduard





2008/8/27 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday, 27 of August 2008, you wrote:
>> Hi,
>
> Hi,
>
>>     I know this is and old topic, but I'd really like to know what's
>> the state of the suspend-to-ram feature on this machine. Just to get
>> things refreshed, this issue has to deal with the ACPI execution
>> ordering, something related to how the different suspend phases are
>> ordered differently between ACPI 1.0 and ACPI 2.0.
>>
>> Googling around I've seen that there was 2 new kernel parameters,
>> acpi_new_pts_ordering and acpi_old_pts_ordering, but I don't know if
>> they have been really commited to main kernel trunk. At least, in
>> current Gentoo 2.6.25 kernel they are not defined anywhere...
>>
>> Anyway, these are the symptoms I'm experiencing whenever I attempt to
>> use S3 hibernation: the machine seems to enter a kind of strange
>> "frozen" state, in which the CPU fan keeps turning and the power LED
>> starts blinking at aproximately 1 Hz. However, the machine is really a
>> dead-stone yet, and the only way to get it back is powering it off by
>> holding down power button for 4s and then restarting.
>>
>> This happens both when using 'hibernate-ram' script or new 's2ram' program.
>
> Please try the latest kernel (2.6.27-rc4-git) with 'acpi_sleep=old_ordering' in
> the command line.
>
> Thanks,
> Rafael
>
