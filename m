From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 1/4] eeepc-laptop: Fix Kconfig
Date: Wed, 25 Feb 2009 08:57:36 +0100
Message-ID: <71cd59b00902242357o33e6c34dud718d470b9080b1e@mail.gmail.com>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
	 <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
	 <20090224144439.63c9b9f7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:45248 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbZBYH5k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 02:57:40 -0500
Received: by bwz5 with SMTP id 5so6507746bwz.13
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2009 23:57:37 -0800 (PST)
In-Reply-To: <20090224144439.63c9b9f7.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

There was a patch collision in -mm
It seems a patch with "depends INPUT" was already merged
I used select because ASUS_LAPTOP and THINKPAD_ACPI are using select
two, but for INPUT it's not realy needed.
Maybe we should do a sed '/select INPUT/depends on INPUT/
drivers/platform/x86/Kconfig

On Tue, Feb 24, 2009 at 11:44 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sun, 15 Feb 2009 19:30:18 +0100
> Corentin Chary <corentincj@iksaif.net> wrote:
>
>> Add a "select INPUT" to Kconfig now that eeepc-laptop
>> is using the input layer.
>>
>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>> ---
>> =A0drivers/platform/x86/Kconfig | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kco=
nfig
>> index 9436311..6f46bc6 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -305,6 +305,7 @@ config EEEPC_LAPTOP
>> =A0 =A0 =A0 select BACKLIGHT_CLASS_DEVICE
>> =A0 =A0 =A0 select HWMON
>> =A0 =A0 =A0 select RFKILL
>> + =A0 =A0 select INPUT
>> =A0 =A0 =A0 ---help---
>> =A0 =A0 =A0 =A0 This driver supports the Fn-Fx keys on Eee PC laptop=
s.
>> =A0 =A0 =A0 =A0 It also adds the ability to switch camera/wlan on/of=
f.
>
> I'm getting
>
> drivers/input/Kconfig:9:error: found recursive dependency: INPUT -> E=
EEPC_LAPTOP -> INPUT
> make[1]: *** [oldconfig] Error 1
>



--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
