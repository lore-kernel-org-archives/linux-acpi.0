From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: CM vs FF buttons
Date: Tue, 30 Nov 2004 19:53:55 +0300
Message-ID: <6EDC9204B3704C4C8522539D5C1185E56C0A9F@mssmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Justin Georgeson <justin.georgeson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Could you please look at this bug report
http://bugme.osdl.org/show_bug.cgi?id=3D1920
to see if it helps you?

Regards,
	Alex
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Justin Georgeson
>Sent: Tuesday, November 30, 2004 7:13 PM
>To: acpi-devel
>Subject: [ACPI] Re: CM vs FF buttons
>
>anybody have any input on this? It'd be really nice to get the sleep
>button working
>
>
>On Sat, 27 Nov 2004 00:13:28 -0600, Justin Georgeson
><justin.georgeson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> I have an Inspiron 2600 laptop and the sleep button (Fn+Esc) doesn't
>> seem to trigger an ACPI event. It works in Windows, so I tried
>> recompiling my DSDT. But that didn't help. Checking out my dmesg
>> output, I see this. I read some mention of FF vs CM on the gentoo
>> forums post about fixing your DSDT. They mention a kernel patch to
>> ignore FF buttons so they might be redetected as CM, but my sleep
>> button is already CM. Is there a way to see it as FF?
>>
>> ACPI: Power Button (FF) [PWRF]
>> ACPI: Sleep Button (CM) [SLPB]
>>
>> --
>> ; Justin Georgeson
>> ; "Free the mallocs, delete the news"
>> ; http://www.openoffice.org
>> ; http://www.boycott-riaa.com
>>
>
>
>--
>; Justin Georgeson
>; "Free the mallocs, delete the news"
>; http://www.openoffice.org
>; http://www.boycott-riaa.com
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real
users.
>Discover which products truly live up to the hype. Start reading now.
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
