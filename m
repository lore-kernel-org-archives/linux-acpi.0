From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: [Fwd: Re: Dell Inspiron 510m sleep states S3/S4 not working]
Date: Sat, 05 Mar 2005 23:31:51 -0800
Message-ID: <422AB1E7.4050304@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I have reports that Linux works for S3 on these machines but FreeBSD=20
does not.  The Dell Inspiron 510M at least has a problem where the write=20
to PM1A in hwsleep.c resets the system instead of entering S3.  I heard=20
that Linux had similar problems in the past but now works.  Can someone=20
let me know what was going on?

Thanks much,
Nate

-------- Original Message --------
Subject: Re: Dell Inspiron 510m sleep states S3/S4 not working
Date: Sat, 05 Mar 2005 20:02:44 -0500
From: Igor Partola <ipartola-27MbaEWyEdNeoWH0uzbU5w@public.gmane.org>
To: freebsd-acpi-h+KGxgPPiopAfugRpC6u6w@public.gmane.org

Ulrich Sp=F6rlein wrote:

>On Thu, 03.03.2005 at 17:10:25 -0800, Nate Lawson wrote:
> =20
>
>>Easiest way to test for resets is to stick this loop in the C code,=20
>>pushing it farther down until you identify the line of code that resets=
=20
>>instead of hanging.
>>
>>hang: goto hang;
>>
>>Try this in AcpiEnterSleepState().
>>   =20
>
>Been there, done that. See
>http://lists.freebsd.org/mailman/htdig/freebsd-acpi/2004-December/000949=
.html
>
>Ulrich Spoerlein

I just did some testing just to make sure that my system resets on the
same line. Sadly that is the problem, writing PM1A resets the machine.

I also compared the code with hwsleep.c from linux 2.6.10. They almost
exactly the same, except for at one point but that should only affect
S5. Everything else is the same.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
