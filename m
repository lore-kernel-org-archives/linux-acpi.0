From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: DockApps (Was: Smart Battery System driver)
Date: Fri, 21 Jan 2005 13:30:55 +0000
Message-ID: <41F1040F.5020409@arrakis.dhis.org>
References: <16880.8771.253591.739342@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16880.8771.253591.739342-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
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
| [Quoting Rich Townsend, on January 19 2005, 08:31, in "Re: Smart Batter=
y Sy"]
|
|>However, I'm surprised that the GB applet doesn't get the AC state from
|>polling /proc/acpi/adapter/AC0/state. I use wmacpi, and that shows up
|>the AC state fine...
|
|
| Speaking of wmacpi: what is your favorite (acpi-related) docapp for
| your laptop?

I use the kde thingy, klaptopdaemon, I think... works very well. reports =
AC
adapter presence and battery charge in percentage. not sure if it reports=
 time
to empty...

regards,
pedro venda.

| Most of them have some form of libacpi that does a varying job. It is
| clear that using the SBS info would be much easier, and better.

hacking the lib would be the best way to use enhanced SBS information, al=
though
I guess the driver state is not very matured to get people writing librar=
ies to
access it. Also, having info/state entries in /proc is being "deprecated"=
. /sys
was built for that and gradually all kernel drivers will be using it for
userspace interaction...

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8QQPeRy7HWZxjWERAr2ZAKCmoe3RITPablOLXkLfn3U3lOLZegCgy73d
gM0hwGZUxxBsoKDLk15nUEc=3D
=3DWT8Y
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
