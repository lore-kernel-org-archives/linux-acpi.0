From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: CONFIG_PM, CONFIG_ACPI, CONFIG_ACPI_SLEEP
Date: Wed, 9 Mar 2005 22:36:21 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3002F22F17@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
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
To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=20
>> Why shouldn't CONFIG_ACPI depend on CONFIG_PM
>> Why shouldn't CONFIG_ACPI_SLEEP simply be CONFIG_ACPI
>>=20
>> I can't think of any good reasons not to simplify here, can you?
>
>That sounds confusing to me. I thought that ACPI was much more=20
>than just power management. Doesn't it include IRQ routing, device=20
>enumeration and so on too?

Yes, ACPI does a lot of configuration too -- but there really isn't any
concept of having the config part of ACPI without having the power
management part.

The real question is if CONFIG_PM=3Dn is an interesting configuration on
ACPI-enabled systems.  I'm thinking that a couple of years ago it was,
but today everybody is using CONFIG_PM=3Dy.

thanks,
-Len


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
