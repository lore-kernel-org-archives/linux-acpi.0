From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Mon, 22 Nov 2004 01:08:47 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC0A2@pdsmsx403>
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
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>> 2. Due to the global list of acpi_gbl_gpe_xrupt_list_head,
>> All GPEs will be checked at each GPE interrupt level,
>> This is not the expected behaviour of just checking GPE at GPE's
>> interrupt
>> level.
>
>I think this misunderstanding follows from the above misunderstanding.
>

Yes, you are right. I got conclusion too early. It's my bad. :-(

But, I think there is a race condition on path of acpi_remove_gpe_block.
Say,when acpi_remove_gpe_block finished,  there could have defered task=20
on workqueue of kacpid, which was referencing acpi_gpe_event_info
belongs
to just removed gpe block.

>> 3. Interrupt Source Overrides are necessary to describe variances=20
>> between the IA-PC standard dual 8259 interrupt definition and the=20
>> platform's implementation.
>>=20
>> Please take a look at ACPI SPEC
>> 5.2.11.8   Interrupt Source Overrides
>
>OK, but that doesn't explain why we have two copies of the FADT.  Or,
>for that matter, why we only override SCI INT in one copy of the FADT
>and not the other.

acpi_fadt : a separate copy of the FADT for use by other drivers.
acpi_gbl_FAD:  2.0 FADT from BIOS.

Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
