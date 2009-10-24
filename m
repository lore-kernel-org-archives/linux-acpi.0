From: =?ISO-8859-1?Q?andreas_p=E5lsson?= <andreas.palsson+acpi@gmail.com>
Subject: Re: ACPI events for laptop special buttons
Date: Sun, 25 Oct 2009 01:06:06 +0200
Message-ID: <477df590910241606gbd4e38t5e90734ec742639@mail.gmail.com>
References: <477df590910241512v3ecc3b0dj7d0d115cdaea7f7e@mail.gmail.com>
	 <4AE37CE2.9040304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:29150 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZJXXGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Oct 2009 19:06:03 -0400
Received: by ey-out-2122.google.com with SMTP id 9so2170760eyd.19
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2009 16:06:06 -0700 (PDT)
In-Reply-To: <4AE37CE2.9040304@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

That is absolutely wonderful!
I was digging around in drivers/acpi/* but had trouble to make sense
of things, but eeepc-laptop.c seems to be right on the spot of what I
was thinking of doing. :)

Now I just need to figure out how to talk to it from user-mode, and I
should be all set.
I suppose this is not the list to ask questions related to it?


Thanks!


On Sun, Oct 25, 2009 at 00:17, Alexey Starikovskiy <aystarik@gmail.com>=
 wrote:
> Hi,
> There is driver to handle events from eeePC hardware
> drivers/platform/x86/eeepc-laptop.c
> You should probably start from making sure you have this one loaded.
>
> Regards,
> Alex.
>
> andreas p=C3=A5lsson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> Hello.
>>
>> I recently bought a cute little Eee PC and of course I decided to ru=
n
>> Linux on it.
>> But some special buttons/keys doesn't work, like the "special FN key=
 +
>> F3" which disables touchpad.
>>
>> I did some research and if I understand it correctly, pressing those
>> buttons generate "ACPI events" which could (until it was recently
>> deprecated) be read from "/proc/acpi/events".
>>
>>
>> So now to my question, how do I catch those events?
>>
>> Is it possible to read them from user-mode (like to have a nice grap=
h
>> showing if touchpad/wifi is online or offline)?
>>
>>
>> I've not been digging around in the kernel before so I don't have ye=
t
>> much understanding how things work, but one has to start somewhere a=
nd
>> a simple task like "is button pressed?" seems like the right thing. =
:)
>>
>> Thank you.
>>
>> PS. Apologies if this is the wrong list for questions like this.
>>
>
>



--=20
andreas p=C3=A5lsson
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
