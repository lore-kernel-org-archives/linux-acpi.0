From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI events for laptop special buttons
Date: Sun, 25 Oct 2009 02:17:06 +0400
Message-ID: <4AE37CE2.9040304@gmail.com>
References: <477df590910241512v3ecc3b0dj7d0d115cdaea7f7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:33691 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbZJXWRH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Oct 2009 18:17:07 -0400
Received: by fg-out-1718.google.com with SMTP id 16so4454376fgg.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2009 15:17:10 -0700 (PDT)
In-Reply-To: <477df590910241512v3ecc3b0dj7d0d115cdaea7f7e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?YW5kcmVhcyBww6Vsc3Nvbg==?= <andreas.palsson+acpi@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,
There is driver to handle events from eeePC hardware
drivers/platform/x86/eeepc-laptop.c
You should probably start from making sure you have this one loaded.

Regards,
Alex.

andreas p=C3=A5lsson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hello.
>
> I recently bought a cute little Eee PC and of course I decided to run
> Linux on it.
> But some special buttons/keys doesn't work, like the "special FN key =
+
> F3" which disables touchpad.
>
> I did some research and if I understand it correctly, pressing those
> buttons generate "ACPI events" which could (until it was recently
> deprecated) be read from "/proc/acpi/events".
>
>
> So now to my question, how do I catch those events?
>
> Is it possible to read them from user-mode (like to have a nice graph
> showing if touchpad/wifi is online or offline)?
>
>
> I've not been digging around in the kernel before so I don't have yet
> much understanding how things work, but one has to start somewhere an=
d
> a simple task like "is button pressed?" seems like the right thing. :=
)
>
> Thank you.
>
> PS. Apologies if this is the wrong list for questions like this.
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
