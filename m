From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: HP Pavilion zt3240ea and thermal zone
Date: Tue, 12 Oct 2004 14:43:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <416BDF74.8070605@mega.ist.utl.pt>
References: <416BAB60.7050809@estg.ipleiria.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <416BAB60.7050809-3+EeCmRbAIqyvGiigdSjEg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: =?ISO-8859-1?Q?Lu=EDs_Neves?= <lneves-3+EeCmRbAIqyvGiigdSjEg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello luis,

| Is it normal that this kind of machine (a 1.6GHz centrino) do not have a
| thermal zone? I don't find thermal information under XP also but in my
| ignorance I thought this should exist.
|
| My first attempt was to dissassemble, correct and override the DSDT but
| the single bug found and corrected (a common ByteAccess type) didn't
| change anything.

the hardware/software acpi implementation on your laptop is independent
of the platform, whether it is centrino or other.

after inspection of your dsdt i didn't find references to any thermal zones.

for example, page 287 of the acpi specificatoin 2.0c states that every
thermal zone MUST have a _TMP object. there is no _TMP object on your
dsdt, so i deduct one of two things:
1. your acpi code is not compliant with the standard
or
2. you really don't have thermal zones.

since there are no _CRT, _HOT, _ALx, _PSL, _PSV, _SCP, _TMP, _TZD, _TZP
and unless there is/are other place/places where thermal zones are
defined, i conclude that you don't have thermal zones defined.

maybe someone else could confirm this...

is that odd? i don't know... i am just learning ACPI now, so i don't
have the experience.

cumprimentos,
pedro venda.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBa990eRy7HWZxjWERAgRhAKDZrBvLhGiHsdlNtlFWnCe6EWxZCACdH2Un
Av0ShkaLEGUBcSdoh5Yk2U8=
=Ctpb
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
