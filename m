From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: #define ACPI_MAX_TABLES 256
Date: Sun, 5 Dec 2004 21:37:59 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300229FE09@hdsmsx401.amr.corp.intel.com>
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
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Okay to reduce ACPI_MAX_TABLES to 64 from 256 for the forseeable future?

also, looks like acpi_sdt_entry[] can be __init since it is referenced
only by code that is __init.

thanks,
-Len
http://bugme.osdl.org/show_bug.cgi?id=3D1311=20

>-----Original Message-----
>From: Bjorn Helgaas [mailto:bjorn.helgaas-VXdhtT5mjnY@public.gmane.org]=20
>Sent: Monday, October 06, 2003 5:35 PM
>To: Brown, Len; Jesse Barnes; Grover, Andrew; Bjorn Helgaas;=20
>Moore, Robert
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: #define ACPI_MAX_TABLES 256
>
>On Friday 03 October 2003 11:56 am, Brown, Len wrote:
>> Anybody know where the value 256 came from?
>> (looks like we used to define ACPI_MAX_TABLES as=20
>ACPI_TABLE_COUNT about
>> a year ago)
>>=20
>> We use ACPI_MAX_TABLES to limit how many RSDT or XSDT entries we look
>> at, but I didn't see any limit in the spec, so I was=20
>wondering if this
>> came from some practical experience.
>
>256 was just picked out of the blue.  It was previously about 17,
>and we overflowed that with an HP box that was about half the
>size of the current largest box.  So the minimum to support a
>fully configured box would have been around 35.
>
>Bjorn
>g
>
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
