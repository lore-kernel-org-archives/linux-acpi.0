From: "Eduard Huguet" <eduardhc@gmail.com>
Subject: Re: Suspend to RAM in an Asus P1-AH2
Date: Wed, 27 Aug 2008 23:28:00 +0200
Message-ID: <617be8890808271428q5e05ea5dse366161b020d36de@mail.gmail.com>
References: <617be8890808270739gdba5c46q6cae8c33668d6bba@mail.gmail.com>
	 <617be8890808270740l4d64c977n17156cf2f7a6dcad@mail.gmail.com>
	 <200808272215.15035.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:36842 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYH0V2D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 17:28:03 -0400
Received: by gxk9 with SMTP id 9so4432495gxk.13
        for <linux-acpi@vger.kernel.org>; Wed, 27 Aug 2008 14:28:00 -0700 (PDT)
In-Reply-To: <200808272215.15035.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

Ok, I'll try it out.
Thanks for the tip.

Regards,
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
