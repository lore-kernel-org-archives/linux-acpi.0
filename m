From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: enable sound card with PNPACPI
Date: Thu, 20 Jan 2005 12:59:31 +0200
Message-ID: <pan.2005.01.20.10.59.29.271939@yahoo.com>
References: <200501200936.43376.dchallet@netcourrier.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

You can also try=20

echo auto > /sys/devices/pnp0/00:03/resources
echo activate > /sys/devices/pnp0/00:03/resources

and check again.

On Thu, 20 Jan 2005 09:36:43 +0000, Damien Challet wrote:

>> I think you should try
>> echo activate > /sys/devices/pnp0/00:03/resources
>  > and check dmesg for feedback
>=20
> That worked to the point that the module can be loaded. However, when I
> try to play a sound,
>=20
> e.g. aplay sound.wav,
>=20
> aplay seems to wait for something (does not start playing).
>=20
> I tried to echo -n 1 to the power/state of everything.
>=20
> Thanks for the help.
>=20
> Damien
>=20
>=20
>=20
>=20
> ------------------------------------------------------- This SF.Net ema=
il
> is sponsored by: IntelliVIEW -- Interactive Reporting Tool for open sou=
rce
> databases. Create drag-&-drop reports. Save time by over 75%! Publish
> reports on the web. Export to DOC, XLS, RTF, etc. Download a FREE copy =
at
> http://www.intelliview.com/go/osdn_nl




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
