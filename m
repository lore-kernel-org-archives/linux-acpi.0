From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Mon, 20 Dec 2004 19:12:21 +0100
Message-ID: <41C71605.1040807@gmx.net>
References: <41BFC3AD.5030001@gmx.net> <200412162157.02741.stefandoesinger@gmx.at> <41C22792.2000205@gmx.net> <200412171649.08125.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412171649.08125.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>, =?ISO-8859-1?Q?Stefan_?= =?ISO-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan Dösinger schrieb:
>>That patch has been merged into the 6.8.x tree at X.Org three minutes ago,
>>so it will be in the 6.8.2 release.
>>
>>Did I understand correctly that with this patch should make POSTing the
>>card with boot-radeon unnecessary? Current 6_8_BRANCH X.Org is building
>>here at the moment, will report back when it is installed.

(I built X.Org CVS HEAD, but it has the same patch.)


> Yes, that's correct.
> 
> It was AFAIK the first way to wake up the radeon card. boot-radeon was written 
> based on the X11 patch.

Unfortunately, that fails on my Samsung P35. (Well, at least the display
backlight comes back and the machine doesn't crash.)

Messages by the X server after resume:

(WW) RADEON(0): zero MEMSIZE, probably at D3cold. Re-POSTing via int10.
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(EE) RADEON(0): unknown reason for exception
(II) RADEON(0): EAX=0x00004e08, EBX=0x00000106, ECX=0x00000000, EDX=0x000030fa
(II) RADEON(0): ESP=0x00000fb2, EBP=0x00000fba, ESI=0x00003d17, EDI=0x00000000
(II) RADEON(0): CS=0x5110, SS=0x0100, DS=0x0040, ES=0x0000, FS=0x0000, GS=0x0000
(II) RADEON(0): EIP=0x0000ffff, EFLAGS=0x00033206
(II) stack at 0x00001fb2:
 aa 3d 00 f0 52 3d 18 f9 00 c0 00 00 00 00 f9 01
 00 00 ce 0f 06 01 fa 30 00 00 08 4e f9 95 00 c0
 46 32 ad 08 56 08 00 00 00 00 00 00 00 00 00 00
 00 00 f8 0f 00 00 00 00 00 00 00 00 00 00 00 00
 00 00 00 01 00 00 00 00 40 00 00 06 00 00
(II) RADEON(0): code at 0x000610ff:
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
(EE) RADEON(0): cannot continue
(II) RADEON(0): BIOS HotKeys Disabled
(II) Mouse[1]: ps2EnableDataReporting: succeeded

Especially CS:EIP looks suspicious.

So what step would be next? IIRC on the P35 needed a crashing VESA server
in addition to boot-radeon. Can that step be added somehow to the Radeon
X server?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
