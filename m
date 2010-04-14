From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Wed, 14 Apr 2010 22:07:02 +0200
Message-ID: <n2r71cd59b01004141307r4adc2703haa922888f0c17d55@mail.gmail.com>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com>
	 <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
	 <20100414164030.GA14758@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20100414164030.GA14758@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, Chris Bagwell <chris@cnpbagwell.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2010 at 6:40 PM, Matthew Garrett <mjg59@srcf.ucam.org> =
wrote:
> On Wed, Apr 14, 2010 at 05:23:22PM +0100, Alan Jenkins wrote:
>
>> I suggest you contact the ACPI video maintainer, Zhang Rui
>> <rui.zhang@intel.com>, and attach the output of "dmidecode". =A0The =
best
>> way would probably be to report the problem on bugzilla.kernel.org (=
on
>> the ACPI video driver).
>>
>> I think it will indeed be possible to blacklist your machine, becaus=
e
>> someone has already anticipated this problem :-).
>
> dmi blacklisting is almost certainly wrong. It's more likely that
> eeepc-laptop shouldn't be registering a backlight if
> acpi_video_backlight_support() is true, but we'll then want to
> investigate whether we also need to send the keyboard events through.
>

Hum, it isn't (or maybe I didn't understand what you mean ?)
> if (!acpi_video_backlight_support())
>                result =3D eeepc_backlight_init(eeepc);



--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe platform-driv=
er-x86" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
