From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-laptop: Work around rfkill firmware bug
Date: Thu, 9 Apr 2009 09:56:55 +0200
Message-ID: <71cd59b00904090056k29311350r834ad8623d5d283a@mail.gmail.com>
References: <49DCA63B.5050802@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:62976 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbZDIH47 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Apr 2009 03:56:59 -0400
Received: by bwz17 with SMTP id 17so454753bwz.37
        for <linux-acpi@vger.kernel.org>; Thu, 09 Apr 2009 00:56:57 -0700 (PDT)
In-Reply-To: <49DCA63B.5050802@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

On Wed, Apr 8, 2009 at 3:27 PM, Alan Jenkins
<alan-jenkins@tuffmail.co.uk> wrote:
> 1) Buggy firmware can change the RFKILL state by itself. This is easi=
ly
> =A0 detected. =A0The RFKILL API states that in such cases, we should =
call
> =A0 rfkill_force_state() to notify the core.
>
> =A0 I have reported the bug to Asus. I believe this is the right thin=
g
> =A0 to do for robustness, even if this particular firmware bug is fix=
ed.
>
> 2) The same bug causes the wireless toggle key to be reported as 0x11
> =A0 instead of 0x10. =A00x11 is otherwise unused, so it should be saf=
e to
> =A0 add this as a new keycode.
>
> The bug is triggered by removing the laptop battery while hibernated.
>
> On resume, the wireless toggle key causes the firmware to toggle the
> wireless state itself. =A0(Also, the key is reported as 0x11 when the
> current wireless state is OFF).
>
> This is very poor behaviour because the OS can't predict whether the
> firmware is controlling the RFKILL state.
>
> Without this workaround, the bug means users have to press the wirele=
ss
> toggle key twice to enable, due to the OS/firmware conflict. =A0(Assu=
ming
> rfkill-input or equivalent is being used). =A0The workaround avoids t=
his.
>
> I believe that acpid scripts which toggle the value of the sysfs stat=
e file
> when the toggle key is pressed will be rendered ineffective by the bu=
g,
> regardless of this workaround. =A0If they simply toggle the state, wh=
en the
> firmware has already toggled it, then you will never see a state chan=
ge.
>
> Tested on "EEEPC 4G" only.
Hi,
Thanks for the patch, applied on acpi4asus tree.
Could someone with EEEPC 900/1000 test this patch ?
Thanks

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
