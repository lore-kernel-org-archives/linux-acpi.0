From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch 1/1] thinkpad fn+fx key driver
Date: Thu, 23 Sep 2004 01:16:57 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300179B935@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org
Cc: erik-aH8aFkyL5XJBDgjK7y7TUQ@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=20
>On Wed, Sep 22, 2004 at 01:28:49PM -0700, akpm-3NddpPZAyC0@public.gmane.org wrote:
>>=20
>> From: Erik Rigtorp <erik-aH8aFkyL5XJBDgjK7y7TUQ@public.gmane.org>
>>=20
>> Changes since last version:
>>  - use the acpi handle provided by acpi_bus_register_driver,=20
>this way it
>>    should work on more models.
>>  - correct handling of return value from acpi_bus_register_driver
>>=20
>> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
>
>Very nice. Even nicer because I have a thinkpad and I was considering
>writing an extra keys driver that'd poll the CMOS, which would be quite
>a hack.
>
>I have a question, though:
>	Wouldn't it be better to have the keys pass through the input
>	event layer instead of the ACPI event layer?
>
>That way the keys would work the same as on regular machines/keyboards,
>simplifying the userspace handling ... we could also take the opposite
>approach and add handlers to the keymap to send ACPI events for regular
>wake/sleep/power keys on keyboards.
>
>The same would apply to Toshiba and ASUS as well.

This is an emerging area, yes -- consider nothing final;-)

Others too have suggested using the input layer
for hot keys.  I must plead ignorance of the input layer
and how adaptable it is.

My PS/2 keyboard has sleep/wakeup/power buttons
that work on Windows, at least the sleep one works.
What is necessary for them to work on Linux?
That will probably be an easier problem to solve,
and the more exotic buttons on laptops which do
things like switch the display and dim the screen
via ACPI methods may be harder.

thanks,
-Len





-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
