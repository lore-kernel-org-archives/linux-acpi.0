From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] asus-laptop: add Lenovo SL LenovoCare LED support
Date: Thu, 10 Dec 2009 11:38:00 +0100
Message-ID: <71cd59b00912100238l7fe78abcrd07328c15b65971d@mail.gmail.com>
References: <1260257169-7227-1-git-send-email-ike.pan@canonical.com>
	 <20091210100935.GB2446@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f202.google.com ([209.85.221.202]:56160 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933637AbZLJKhy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 05:37:54 -0500
In-Reply-To: <20091210100935.GB2446@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ike Panhc <ike.pan@canonical.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Alexandre Rostovtsev <tetromino@gmail.com>

On Thu, Dec 10, 2009 at 11:09 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2009-12-08 15:26:09, Ike Panhc wrote:
>> From: Ike Panhc <ikepanhc@canonical.com>
>>
>> This patch is to enable the LenovoCare LED support on Lenovo SL lapt=
op. Based
>> on the found of the control interface by Alexandre Rostovtsev
>>
>> Turn on the LenovoCare LED:
>> =A0(As root privileges) echo 1 > /sys/class/leds/asus\:\:LenovoCare/=
brightness
>> Trun off the LenovoCare LED:
>> =A0(As root privileges) echo 0 > /sys/class/leds/asus\:\:LenovoCare/=
brightness
>>
>> The patch against current checkout of acpi4asus is below.
>
> Is the driver severely misnamed by now? I believe Lenovo and ASUS are
> pretty different firms...
>

Lenovo ship DSDT with similar ATKD interace.
See http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dcommitdiff;h=3D31a3814=
7625c283b58137db45e7507cd1e49aa05


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
