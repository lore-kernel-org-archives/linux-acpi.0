From: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: dmidecode - Apple MacPro
Date: Sat, 19 Jan 2008 11:16:19 +0100
Message-ID: <F6DBF27A-F208-42A1-BE69-F6CD86AE29EE@exactcode.de>
References: <200708291349.46987.rene@exactcode.de> <200801182236.40494.lenb@kernel.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx02.qsc.de ([213.148.130.14]:55864 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbYASKrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 05:47:07 -0500
In-Reply-To: <200801182236.40494.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len,

now that was some time between the mails :-)

Unfortunately the 8-core box is sort of running in production
and I can not randomly boot kernels.

Passing acpi_os=3Dwhatever did not really changed anything
back in the days when I tried that. Actually the box is running
quite fine (normal server load, no suspend or so) though currently
an older 2.6.18+openvz kernel as that was the only openvz patch-
set that was stable, all the other openvz patchsets locked up sooner
than later ...

If you are still interested in the acpidump I can hunting for it.

Yours,

On 19.01.2008, at 04:36, Len Brown wrote:

> On Wednesday 29 August 2007 07:49, Ren=E9 Rebe wrote:
>> Hi all,
>>
>> I just post because my dmesg says so:
>>
>> ACPI: System BIOS is requesting _OSI(Linux)
>> ACPI: Please test with "acpi_osi=3D!Linux"
>> Please send dmidecode to linux-acpi@vger.kernel.org
>>
>> Handle 0x003A, DMI type 0, 24 bytes
>> BIOS Information
>>        Vendor: Apple Computer, Inc.
>>        Version:     MP21.88Z.007F.B02.0703191612
>>        Release Date: 03/19/07
>>
>> Handle 0x003B, DMI type 1, 27 bytes
>> System Information
>>        Manufacturer: Apple Computer, Inc.
>>        Product Name: MacPro2,1
>>        Version: 1.0
>>
>> ...
>>
>> If you need more let me know. I mostly looked thru the dmesg
>> because the box shuts down sometimes, randomly. Maybe too hot?
>> But I still investigate.
>>
>> However, the box (2 Quad-Core CPUs) even awakes from echo mem >
>> /sys/power/state (without graphic though, maybe s2ram posting would =
=20
>> fix
>> that - but I do not really care about the graphic as it is indended =
=20
>> to be used
>> as server anyway).
>
> Thanks for the dmidecode output.
>
> Do you notice any functional difference when booting with
>
> "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> vs.
> "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
>
> Also, please send me the output from acpidump.
>
> thanks,
> -Len
>
> ps
> If you don't have acpidump, you can get it from pmtools here:
> http://www.lesswatts.org/projects/acpi/utilities.php

--=20
   Ren=E9 Rebe - ExactCODE GmbH - Europe, Germany, Berlin
   Gesch=E4ftsf=FChrer: Susanne Klaus, Ren=E9 Rebe
   Sitz: Berlin, Amtsgericht Charlottenburg HRB 105 123 B
   USt-IdNr.: DE251602478
   http://exactcode.de | http://t2-project.org | http://rene.rebe.name

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
