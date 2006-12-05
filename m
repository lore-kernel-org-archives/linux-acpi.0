From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: Error calling BSTS
Date: Mon, 04 Dec 2006 20:41:59 -0500
Message-ID: <4574CE67.2000302@seclark.us>
References: <4570BECB.5050502@seclark.us> <200612020827.56692.corentincj@iksaif.net> <4571925C.3090204@seclark.us> <200612041856.48871.corentincj@iksaif.net>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpout09-04.prod.mesa1.secureserver.net ([64.202.165.17]:37848
	"HELO smtpout09-04.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S968004AbWLEBmA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2006 20:42:00 -0500
In-Reply-To: <200612041856.48871.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org

Corentin CHARY wrote:

>Le samedi 2 d=E9cembre 2006 15:49, Stephen Clark a =E9crit :
> =20
>
>>Corentin CHARY wrote:
>>   =20
>>
>>>Le samedi 2 d=E9cembre 2006 00:46, Stephen Clark a =E9crit :
>>>     =20
>>>
>>>>Asus Laptop ACPI Extras version 0.30
>>>> Error calling BSTS
>>>> unsupported model Z96F, trying default values
>>>> send /proc/acpi/dsdt to the developers
>>>>       =20
>>>>
>>>Please send /proc/acpi/dsdt, not dmidecode output :)
>>>cat /proc/acpi/dsdt > /tmp/dsdt
>>>     =20
>>>
>>Ok here it is as a DSDT binary blob.
>>
>>Thanks,
>>Steve
>>   =20
>>
>Can you try the current cvs version of asus_acpi ?
>http://acpi4asus.sourceforge.net/
>
> =20
>
Hi Corentin,

Here is the dmesg output now - looks good except for the Error call BST=
S=20
whatever that is.

ACPI: AC Adapter [AC0] (on-line)
Asus Laptop ACPI Extras version 0.31b2
  Error calling BSTS
  Z96F model detected, supported
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)

Thanks,
Steve
--=20

"They that give up essential liberty to obtain temporary safety,=20
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty=20
decreases."  (Thomas Jefferson)



-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
