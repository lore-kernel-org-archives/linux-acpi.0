From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 10 Jan 2005 15:43:46 +0000
Message-ID: <41E2A2B2.4010204@arrakis.dhis.org>
References: <41D56002.5060008@mega.ist.utl.pt>	<41DAB539.2020605@arrakis.dhis.org>	<m2oefyzplr.fsf@phoenix.squirrel.nl>	<200501101524.58077.sanskryt@op.pl> <m28y71fi1s.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m28y71fi1s.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johan Vromans wrote:
| "Zdzis=B3aw A. Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org> writes:
|
|
|>Dnia niedziela 09 stycznia 2005 14:41, Johan Vromans napisa=B3:
|>Second: I can't execute battstat program.
|
|
|>70 - "my $res =3D `smartbattery2 $smbus 2>&1`;"

true. I had the same problem.

thanks for the program and fix. I'll have a different version of smartbat=
tery
~ done soon now. It'll have a more friendly output and more information o=
n
demand. Also I'll be implementing an ascii charge bar like:
~   [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|       ]
0%             65%        100%

or something simillar. If you want, I can write some code to output infor=
mation
in a desired way for your frontend.

This is being developed for fun only (!!) and not for wide usage. It will=
 not in
any way replace any of the current used battery interfaces that use
/proc/acpi/battery, because that'd be just a waste of time. I hope bruno =
will
finish the driver soon so we could use all that software and not mine.

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4qKyeRy7HWZxjWERAuquAJ4sl6j7SJ+C7CY0KLAROFyHWYdYUQCgmFlz
5tyN/IpsjuwYNkYsrnb/F4Q=3D
=3DvNKR
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
