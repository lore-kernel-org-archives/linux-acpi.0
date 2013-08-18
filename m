From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: kernels 3.9.5 to 3.10.6 fail to boot on battery, vaio vgn-c2m/w
Date: Sun, 18 Aug 2013 13:54:03 +0800
Message-ID: <CAOLK0pxpsRWR+oiQjLSpbPWefptZeEx76P+okTSLeYW1qGZ4Vw@mail.gmail.com>
References: <CAL3-7MrW0p-YuJBpiguoG7f0j7vgyJALhdSnh81uRM_5TR50Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:34648 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab3HRFyF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Aug 2013 01:54:05 -0400
Received: by mail-qe0-f42.google.com with SMTP id w7so156654qeb.29
        for <linux-acpi@vger.kernel.org>; Sat, 17 Aug 2013 22:54:04 -0700 (PDT)
In-Reply-To: <CAL3-7MrW0p-YuJBpiguoG7f0j7vgyJALhdSnh81uRM_5TR50Xg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian Malone <ibmalone@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2013/8/18 Ian Malone <ibmalone@gmail.com>:
> Hi,
>
> Posted in Fedora bugzilla, but has failed to get any love there,
> https://bugzilla.redhat.com/show_bug.cgi?id=991708
>
> My laptop (Sony vgn-c2m/w
> http://www.sony.co.uk/support/en/product/VGN-C2M_W/specifications
> Intel Core 2 Duo T5500,  Intel 945GM, GMA950 graphics), fails to boot
> on the most recent Fedora 19 kernels (latest is 3.10.6) when running
> on battery. Running on PSU boots okay, and disconnecting power after
> boot is okay. Using acpi=off boots successfully on battery (which is
> why I thought it might be relevant here), but can't then read battery
> level or adjust screen brightness.
>
> lspci output and dmesg reports included in the Fedora bugzilla entry above.
>
> Anything I can try here?

Hi:
       Could you apply a bug on the kernel bugzilla with the output of acpidump
and the log of boot failure if possible?
       http://bugzilla.kernel.org/

>
> Thanks for your time.
>
> --
> imalone
> http://ibmalone.blogspot.co.uk
>
>
> --
> imalone
> http://ibmalone.blogspot.co.uk
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
