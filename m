From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Z600 screen restore
Date: Tue, 28 Sep 2004 09:28:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB6002F91CB6@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4A578.26FCFD92"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ivor Hewitt <ivor-rtBon1mkn18@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4A578.26FCFD92
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
>-----Original Message-----
>From: Ivor Hewitt [mailto:ivor-rtBon1mkn18@public.gmane.org]=20
>Sent: Tuesday, September 28, 2004 12:17 AM
>To: Pallipadi, Venkatesh
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Z600 screen restore
>
>On Monday 27 Sep 2004 20:35, Pallipadi, Venkatesh wrote:
>> >-----Original Message-----
>> >From: Ivor Hewitt [mailto:ivor-rtBon1mkn18@public.gmane.org]
>> >
>> >No no acpid running.
>> >
>> >Also.. the machine isn't shutting down... it's running just
>> >fine. I can type
>> >commands... it's just that the screen isn't powered up... and
>> >commenting
>> >those lines out 'fixes' the problem.
>>
>> OK. Sorry, I didn't read your original mail carefully enough,
>> before responding.
>>
>> Actually, commenting those lines is equivalent to passing
>> "acpi_sleep=3Ds3_bios acpi_sleep=3Ds3_mode". So, even that
>> should work for you.
>>
>Indeed that does work. Thanks.
>
>So for the benefit of searchers anyone using a Vaio Z600/Z505=20
>who has a=20
>problem where there LCD doesn't power up after S3 suspend. Try=20
>adding the=20
>parameters "acpi_sleep=3Ds3_bios acpi_sleep=3Ds3_mode.
>

I guess it calls for a documentation patch. Pavel?

Thanks,
Venki

------_=_NextPart_001_01C4A578.26FCFD92
Content-Type: application/octet-stream;
	name="video_doc.patch"
Content-Transfer-Encoding: base64
Content-Description: video_doc.patch
Content-Disposition: attachment;
	filename="video_doc.patch"

LS0tIGxpbnV4LTIuNi45LXJjMi8vRG9jdW1lbnRhdGlvbi9wb3dlci92aWRlby50eHQub3JnCTIw
MDQtMDktMjggMTE6MTc6MDcuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuOS1yYzIvL0Rv
Y3VtZW50YXRpb24vcG93ZXIvdmlkZW8udHh0CTIwMDQtMDktMjggMTE6MjA6NTQuMDAwMDAwMDAw
IC0wNzAwCkBAIC0zMCw2ICszMCwxMCBAQCBUaGVyZSBhcmUgdGhyZWUgdHlwZXMgb2Ygc3lzdGVt
cyB3aGVyZSB2CiAgIHBhdGNoZWQgWCwgYW5kIHBsYWluIHRleHQgY29uc29sZSAobm8gdmVzYWZi
IG9yIHJhZGVvbmZiKSwgc2VlCiAgIGh0dHA6Ly93d3cuZG9lc2kuZ214aG9tZS5kZS9saW51eC90
bTgwMHMzL3MzLmh0bWwuIChBY2VyIFRNIDgwMCkKIAorKiBzeXN0ZW1zIHdoZXJlIGl0IGlzIHBv
c3NpYmxlIHRvIGNhbGwgdmlkZW8gYmlvcyBkdXJpbmcgUzMKKyAgcmVzdW1lLCBmb2xsb3dlZCBi
eSBpbml0aWFsaXphdGlvbiBvZiB2aWRlbyBjYXJkIGludG8gdmdhIHRleHQgbW9kZS4KKyAgYWNw
aV9zbGVlcD1zM19iaW9zIGFjcGlfc2xlZXA9czNfbW9kZSAgKFNvbnkgVkFJTyBaNjAwL1o1MDUp
CisKIE5vdywgaWYgeW91IHBhc3MgYWNwaV9zbGVlcD1zb21ldGhpbmcsIGFuZCBpdCBkb2VzIG5v
dCB3b3JrIHdpdGggeW91cgogYmlvcywgeW91J2xsIGdldCBoYXJkIGNyYXNoIGR1cmluZyByZXN1
bWUuIEJlIGNhcmVmdWxsLgogCg==

------_=_NextPart_001_01C4A578.26FCFD92--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
