From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 13:42:33 +0000
Message-ID: <41F106C9.5020404@arrakis.dhis.org>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com>	<m2fz13x8mw.fsf@phoenix.squirrel.nl>	<41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu>	<41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu>	<m2wtu74yzq.fsf@phoenix.squirrel.nl>	<41F01923.1000503@bartol.udel.edu> <m2sm4v4wk7.fsf@phoenix.squirrel.nl> <41F10180.60008@arrakis.dhis.org> <41F1031E.60507@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41F1031E.60507-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rich Townsend wrote:
| Pedro Venda wrote:
|
|> Johan Vromans wrote:
|> | Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:
|> |
|> |
|> |>I do this because everything in /lib/modules/XXX/kernel/* gets
|> |>clobbered when you do a make modules_install from the kernel source
|> |>tree;
|> |
|> |
|> | I see.
|> |
|> |
|> |>I have recently realized that the whole SBS functionality can be
|> |>implemented in terms of control methods in the DSDT, without the
|> |>need for any kernel drivers.
|> |
|> |
|> | Nice. This would require a kernel recompile/reboot  for each DSDT
|> | modification...
|>
|> not nice, I guess. 99.9% of the interested (me included) wouldn't be
|> able to
|> patch their DSDT and with generated ASL (is it ASL or AML or... ACPI
|> language)
|> code for their specific case.
|
|
| What if you just had to run a perl script, and then add an "initrd=3D"
| line to your kernel boot parameters? Because the code would be *so* muc=
h
| cleaner if a lot of the tasks were moved to the DSDT; in particular, we
| could get rid of i2c_acpi_sbs, and thus remove the dependency of ACPI o=
n
| I2C.

I'd agree that the i2c-acpi dependency is not pretty.

on the other hand... I'm still not liking the CM (dump, limited) interfac=
e to
control SBS (smart, sophisticated) batteries. yes, CM gets the informatio=
n from
the SBS hardware but I can't stop feeling loosing capabilities.

any way, I'm willing to cooperate with you on either decision, although I
seriously dislike the DSDT thing.

regards,
pedro venda.

|
| cheers,
|
| Rich
|
|
| -------------------------------------------------------
| This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
| Tool for open source databases. Create drag-&-drop reports. Save time
| by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
| Download a FREE copy at http://www.intelliview.com/go/osdn_nl
| _______________________________________________
| Acpi-devel mailing list
| Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
| https://lists.sourceforge.net/lists/listinfo/acpi-devel


- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8QbJeRy7HWZxjWERAtVTAKDE8wO1QtEOSXAt+blvQka7KDGC0ACgtTLO
ANWFnIdDuWs8CRQv1hkpTe8=3D
=3DcSaT
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
