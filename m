From: Dan <vxltage@gmail.com>
Subject: Re: PROBLEM: Acer D255E Backlight out for 10 seconds with ACPI
Date: Thu, 27 Sep 2012 14:09:38 -0400
Message-ID: <CALKZjMKDb_tJ6wQmF4D7RLN+C_4fPTGecufuXa4LM+JyAp_XUw@mail.gmail.com>
References: <CALKZjMKcCA68XLWADb+EmU+a3VTQuOGr1dqNywGCCMj8DWNsiQ@mail.gmail.com>
	<1348701543.8621.104.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:48960 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2I0SJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Sep 2012 14:09:40 -0400
Received: by lagh6 with SMTP id h6so534982lag.19
        for <linux-acpi@vger.kernel.org>; Thu, 27 Sep 2012 11:09:39 -0700 (PDT)
In-Reply-To: <1348701543.8621.104.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Sep 26, 2012 at 7:19 PM, joeyli <jlee@suse.com> wrote:
> =A9=F3 =A4T=A1A2012-09-26 =A9=F3 16:48 -0400=A1ADan =B4=A3=A8=EC=A1G
>> Hello,
>>
>> Apologies if this was sent to the wrong place.
>>
>> With an Acer AOD255E netbook, the backlight goes out for exactly 10
>> seconds before returning while booting.
>>
>> This is a backlight issue and not KMS, as I can shine a flashlight a=
t
>> the screen and still see boot text scrolling.
>>
>> With "acpi=3Doff" appended to the kernel line, this no longer occurs=
 (Fn
>> key backlight controls still work with this appended). With every
>> other acpi option I have tried, this still occurs though. This
>> includes "acpi_backlight" and "acpi_display_output". With
>> "acpi_backlight=3Dvendor" the entry in /sys/class/backlight changes =
from
>> acpi_video0 to acer_wmi, but backlight still goes out.
>>
>> Otherwise backlight works correctly.
>
> Could you please try this kernel parameter?
> video.use_bios_initial_backlight=3D0
>
>
> Thanks
> Joey Lee
>

Same results with that kernel parameter applied.

Just to make it clear when this is happening:
The BIOS screen and bootloader work fine. This occurs during the boot
process while the systemd text is scrolling (or with the splash screen
in the case of Ubuntu). I have not been able to pin down any event
during the boot process that triggers it. It seems to be based on time
after the kernel loads. I can tell by the difference booting from a
HDD vs a SSD. With a HDD, it will occur earlier in the process (close
to the time init is called) since booting takes longer. With an SSD,
the backlight goes out close to the time the login screen appears.

Once the backlight is out, it will stay out for exactly 10 seconds
before returning no matter what is on the screen.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
