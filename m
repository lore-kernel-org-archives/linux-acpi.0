From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: "Unlink after no-IRQ?" problem: unable to use USB printer
Date: Sun, 30 Jan 2005 15:14:48 +0000
Message-ID: <41FCF9E8.7090000@arrakis.dhis.org>
References: <41F932A5.7000306@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41F932A5.7000306-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pedro Venda wrote:
| hi everyone,
|
| I'm trying to share an USB printer for my home network. The main and
| only server
| is an old dual pIII with an ASUS CUR-DLS, which fortunately features US=
B
| ports
| but which unfortunately don't seem to work.
|
| modprobing usblp hangs forever without crashing the machine. the error
| message
| suggests fiddling with ACPI but the same happens if I disable ACPI
| completely,
| so I supposed this could be an USB problem. Nevertheless, this goes als=
o
| to the
| acpi-devel mailing list.
|
| kernel is 2.6.10-grsec.
|
| is my hardware broken? I know it's old, but it's supposed to support th=
e
| ohci
| driver, so... it can't be THAT old as far as USB is concerned...

fixed.

While I don't know what kind of effect that had, I changed the MPS suppor=
t
version from 1.4 to 1.2 (remember this is an SMP system).

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/PnoeRy7HWZxjWERAjgQAJ9kg3CPp2QFYWF/bV8N3esOu5/C/wCg147M
ukBIrncQ8hcaniMcohkIA+U=3D
=3DqB0n
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
