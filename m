From: Tobias Oed <tobias.oed@octant-fr.com>
Subject: Re: 2.6.25-rc6 compile error in drivers/acpi/osl.c
Date: Sat, 22 Mar 2008 16:04:12 +0100
Message-ID: <47E51FEC.8010501@octant-fr.com>
References: <47E508B3.8070801@octant-fr.com> <47E51864.5000107@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755408AbYCVPEt@vger.kernel.org>
In-Reply-To: <47E51864.5000107@tremplin-utc.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx, Randy Dunlap <randy.dunlap@oracle.com>, tobias.oed@octant-fr.com
List-Id: linux-acpi@vger.kernel.org

Eric Piel wrote:
> (added Randy as CC just in case it ends up being a problem with=20
> 7ce9573e093891f5807e6e50f3bd2012f1e5d0fe)
> Tobias Oed wrote:
>> Hello,
>> compiling 2.6.25-rc6 on my up to date fedora 8 system ends with
>>
>>   CC      drivers/acpi/osl.o
>> drivers/acpi/osl.c:60:38: error: n: No such file or directory
>> drivers/acpi/osl.c: In function =E2=80=98acpi_os_table_override=E2=80=
=99:
>> drivers/acpi/osl.c:334: error: =E2=80=98AmlCode=E2=80=99 undeclared =
(first use in this=20
>> function)
>> drivers/acpi/osl.c:334: error: (Each undeclared identifier is report=
ed=20
>> only once
>> drivers/acpi/osl.c:334: error: for each function it appears in.)
>> make[2]: *** [drivers/acpi/osl.o] Error 1
>> make[1]: *** [drivers/acpi] Error 2
>> make: *** [drivers] Error 2
>>
>> Config attached
> Hi Tobias,
> First, you haven't sent the correct .config file (this one is dated "=
=46ri=20
> Mar 14 21:06:35 2008").

Oups, I took it from the wrong dir.

> To fix your problem you just need to "make menuconfig" and change=20
> ACPI_CUSTOM_DSDT_FILE from "n" to "".
>=20
> Now the question is: how did you end up with this error? Is it just y=
ou=20
> who mistook while answering the questions of "make oldconfig" or did=20
> this "n" appeared automatically because was not ACPI_CUSTOM_DSDT is s=
et.=20
> In which case this is a bug in the kernel.
>=20
> Eric

I ran make oldconfig on my config for 2.6.25-rc5, and I answered n to=20
the question

   Custom DSDT Table file to include (ACPI_CUSTOM_DSDT_FILE) [] (NEW)

Somehow not putting anything didn't seem right at the time. I see my=20
error now.
Thanks for the quick answer and sorry for the noise.
Tobias Oed


--=20
*Tobias Oed* - Octant Informatique <http://www.octant-fr.com>
contact | tobias.oed@octant-fr.com <mailto:tobias.oed@octant-fr.com> -
04 76 50 82 38
image
