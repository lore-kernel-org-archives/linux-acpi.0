From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 09/19] eeepc-laptop: support for super hybrid engine (SHE)
Date: Sun, 24 May 2009 22:24:55 +0200
Message-ID: <71cd59b00905241324k7b75e3fai4a24e00d4934fde3@mail.gmail.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
	 <1242453736-20763-1-git-send-email-lenb@kernel.org>
	 <158ca1d75dd0d6223f3b1dd741d30777da62ab80.1242453625.git.len.brown@intel.com>
	 <9b2b86520905240228y5cf7111dsa6d5d34e03360bd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:63579 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZEXUYz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 May 2009 16:24:55 -0400
Received: by bwz22 with SMTP id 22so2696270bwz.37
        for <linux-acpi@vger.kernel.org>; Sun, 24 May 2009 13:24:56 -0700 (PDT)
In-Reply-To: <9b2b86520905240228y5cf7111dsa6d5d34e03360bd9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: alan-jenkins@tuffmail.co.uk
Cc: Grigori Goronzy <greg@chown.ath.cx>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sun, May 24, 2009 at 11:28 AM, Alan Jenkins
<sourcejedi.lkml@googlemail.com> wrote:
> On 5/16/09, Len Brown <lenb@kernel.org> wrote:
>> From: Grigori Goronzy <greg@chown.ath.cx>
>>
>> The older eeepc-acpi driver allowed to control the SHE performance
>> preset through a ACPI function for just this purpose. SHE underclock=
s
>> and undervolts the FSB and undervolts the CPU (at preset 2,
>> "powersave"), or slightly overclocks the CPU (at preset 0,
>> "performance"). Preset 1 is the default setting with default clocks =
and
>> voltage.
>>
>> The new eeepc-laptop driver doesn't support it anymore.
>> The attached patch adds support for it to eeepc-laptop. It's very
>> straight-forward and almost trivial.
>>
>> Signed-off-by: Grigori Goronzy <greg@chown.ath.cx>
>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>> Signed-off-by: Len Brown <len.brown@intel.com>
>> ---
>
> Hi, out of curiosity I tried this on my EeePC 701. =A0I upgraded the
> BIOS to the latest version available a few months ago.
>
> I find that the file is present and can successfully be read from.
> The file returns the value "513". =A0If I write "1" to it, nothing
> happens. =A0If I write "0" to it, the speakers start hissing and the
> file then returns the value "512". =A0Writing "1" again gets it back =
to
> normal. =A0There is no apparent effect on performance.

After checking multiple dsdt :
x >> 8 =3D configurations possibles
x & 0xFF =3D current config

512 : 2 configurations possible, configuration 0
513: 2 configurations possible, configuration 1

=46or me it's a bug in the BIOS.
Anyway the output of the cpufv file is not very clear.
I'll fix that and I'll test what it does on my 701 with an old bios.

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
