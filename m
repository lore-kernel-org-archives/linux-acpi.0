From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 13:16:12 +0000
Message-ID: <41F1009C.30201@arrakis.dhis.org>
References: <1105747983.7368.3.camel@tyrosine> <47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu> <41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu> <41EF1F6A.5000807@bartol.udel.edu> <41EFCA59.6040100@arrakis.dhis.org> <41EFD672.2040308@bartol.udel.edu> <20050120211044.GA27543@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050120211044.GA27543-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Seyfried wrote:
| On Thu, Jan 20, 2005 at 11:04:02AM -0500, Rich Townsend wrote:
|
|
|>The best solution would be to perform a run-time check. I'll see if I
|>can add code to dynamically detect if the ac_adapter and battery
|>directories are empy on module insertion, and only add the legacy
|>interfaces if they are.
|
|
| not "empty" but "do not exist". We will probably find machines that hav=
e
| working CM Battery but can also be used with SBS.
| Or maybe it is possible from kernelspace to check if a module is loaded
| to lock each other out =3D> if battery or ac is loaded, sbs will refuse
| to load and the other way round.

I think the only way to do this is to integrate the sbs code into the bat=
tery
and ac_adapter drivers. that way at load time, the kernel code can check =
which
type of driver to use or both if possible/useful. that could be hard, I'm=
 aware
of that.

|
|
|>PS Last night, I got a proof-of-concept for event notifications working=
.
|>I still haven't got battery alarms working, but we should now be able t=
o
|>do event-driven AC and battery present/charging/discharging statuses.
|
|
| It would be pretty cool to throw an event on every change of battery ch=
arge
| level (some HP notebooks do this even with CM battery), so there is no =
need
| to poll for battery charge level.

wasn't there a not-so-recent-but-almost discussion about this issue in th=
e
acpi-devel mailing list? I think people argued that acpi would NOT genera=
te
events! that could mean that the acpi layer wouldn't generate events at a=
ll or
that it wouldn't generate events on behalf of hardware unable to generate=
 events.

care to comment?

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8QCceRy7HWZxjWERArT0AJ9Kxk1il9RjoV1/Ow4+Dl63L0yR4wCgz4+B
cf9OpRuKZaKnKHzZe02Csd8=3D
=3DKSIG
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
