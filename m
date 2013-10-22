From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [REGRESSION/PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Mon, 21 Oct 2013 21:12:22 -0500
Message-ID: <CAMP44s1rNLVQ2Mh5MS+4jvnY3suE-PNGs12407uW+7GczsG5JA@mail.gmail.com>
References: <1382307388.4030.30.camel@lamella>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:41679 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab3JVCMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Oct 2013 22:12:24 -0400
Received: by mail-lb0-f175.google.com with SMTP id z5so1350091lbh.6
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2013 19:12:22 -0700 (PDT)
In-Reply-To: <1382307388.4030.30.camel@lamella>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vincent Blut <vincent.debian@free.fr>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rafael.j.wysocki@intel.com

On Sun, Oct 20, 2013 at 5:16 PM, Vincent Blut <vincent.debian@free.fr> =
wrote:

> I wonder if this quirk is still needed=E2=80=BD I'm the owner of an A=
sus UX31A and of course,
> I used to set acpi_osi=3D"!Windows 2012" on the kernel command line i=
n order to change
> the backlight level. *However* since Linux 3.11, this kernel paramete=
r is not needed
> anymore to influence it. The following commit seems to be the one tha=
t fixed (or at
> least inhibited) the issue:
>
> commit  efaa14c7e981bdf8d3c8d39d3ed12bdc60faabb8
> ACPI / video: no automatic brightness changes by win8-compatible firm=
ware

You need another commit to make it work correctly:

b3b301c (ACPI / video: improve quirk check in acpi_video_bqc_quirk())

But yeah, it should work in v3.11, but when you set the level to 0,
the backlight is turned off, isn't it? Also, there's a subtle internal
issue that you probably don't see as a user.

Personally to be on the safe side I think it should remain in the list
at least until those two issues are resolved.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
