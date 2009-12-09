From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [Resend] [PATCH] asus-laptop: add Lenovo SL LenovoCare LED
	support
Date: Wed, 9 Dec 2009 08:47:41 +0100
Message-ID: <71cd59b00912082347m34dc023ds6004ca68e0bb184d@mail.gmail.com>
References: <1260257829-7343-1-git-send-email-ike.pan@canonical.com>
	 <20091208154154.GA26435@srcf.ucam.org>
	 <71cd59b00912080932nf334ba7uf65c70178fec41a5@mail.gmail.com>
	 <4B1F4963.3070405@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:52391 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbZLIHrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 02:47:35 -0500
In-Reply-To: <4B1F4963.3070405@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Alexandre Rostovtsev <tetromino@gmail.com>

On Wed, Dec 9, 2009 at 7:53 AM, Ike Panhc <ike.pan@canonical.com> wrote=
:
> Corentin Chary wrote:
>> On Tue, Dec 8, 2009 at 4:41 PM, Matthew Garrett <mjg59@srcf.ucam.org=
> wrote:
>>> On Tue, Dec 08, 2009 at 03:37:09PM +0800, Ike Panhc wrote:
>>>
>>>> =A0ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED"); =A0 =A0 =A0/* W=
1JC */
>>>> =A0ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED"); =A0 =A0 =A0/* A=
7J */
>>>> =A0ASUS_HANDLE(gled_set, ASUS_HOTK_PREFIX "GLED"); =A0 =A0 =A0/* G=
1, G2 (probably) */
>>> The driver is controlling the ATKD device, which has a HID of ATK01=
01.
>>> These devices are all underneath it...
>>>
>>>> +ASUS_HANDLE(lled_set, "\\_SB_.PCI0.SBRG.EC0_.HKEY.TVLS"); /* Leno=
voCare */
>>> And this one isn't, which is a bit jarring. Looking closer, it's un=
der
>>> the LEN0014 device, which means that you're trying to touch a metho=
d
>>> that belongs to a device other than the one this driver is bound to=
=2E
>>> That's wrong. You want a separate ACPI driver for the LEN0014 devic=
e,
>>> and this should be called for there. Looking at it, you seem to get
>>> rfkill as well (the GWAN/SWAN, GBDC/SBDF and GUWB/SUWB methods) and
>>> maybe some other stuff.
>>>
>>> So this shouldn't go in asus-laptop. You'll need to add another sep=
arate
>>> driver for the SL-specific functionality.
>>
>> That means asus-laptop and sl-laptop will be both needed for a SL
>> laptop, but I don't think this is a problem.
>>
> I think your suggestion is that one acpi driver for one acpi device.
> It makes sense to me. I will build a new driver.
>
>

You should take a look at the new eeepc-laptop driver in
http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dsummary
Alan Jenkins cleaned it a lot so it can be an example for new drivers :=
)

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
