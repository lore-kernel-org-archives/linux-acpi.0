From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: New DSDT patches for Smart Batteries (and new mailing
 list...)
Date: Fri, 18 Feb 2005 22:34:57 -0500
Message-ID: <4216B3E1.70903@bartol.udel.edu>
References: <420C4622.7000809@bartol.udel.edu> <4216A47E.8090604@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4216A47E.8090604-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Pedro --

Have you tried the latest (December 2004 or more recent) Intel compiler?=20
Older versions seem to produce problems with fans.

cheers,

Rich

Pedro Venda wrote:
> Rich Townsend wrote:
> | Hi all --
> |
> | A quick message to announce:
> |
> | 1) That I've just uploaded a new release of the DSDT patches to the
> | Smart Battery project page on SourceForge,
> |
> | and
> |
> | 2) That I've created a new SourceForge mailing list, sbs-linux-announ=
ce,
> | as a way to send out announcements like this in the future.
>=20
> hello Rich,
>=20
> Finally, I got some time to try out your dsdt patches and I've got one=20
> problem.
>=20
> I've dissassembled, patched and re-assembled my dsdt, set it up as=20
> initrd, since
> I'm not currently using one and fired up the patched kernel.
>=20
> The battery/ac information was ok, but some internal fan kept blowing=20
> air at
> full speed. It's one of those internal fans that I've never seen workin=
g=20
> under
> normal conditions, only when the DSDT gets messed up in some way.
>=20
> The laptop is a travelmate 4001WLMi bought in September/2004.
>=20
> Have you got any information regarding this subject?
>=20
> Thanks for your contributions. They're allways welcome!
>=20
> regards,
> pedro venda.
> --
>=20
> Pedro Jo=E3o Lopes Venda
> email: pjvenda < at > arrakis.dhis.org
> http://arrakis.dhis.org

-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=CCk
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
