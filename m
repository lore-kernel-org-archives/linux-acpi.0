From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: enable sound card with PNPACPI
Date: Tue, 18 Jan 2005 23:59:25 +0200
Message-ID: <pan.2005.01.18.21.59.23.788438@yahoo.com>
References: <200501181856.01957.dchallet@netcourrier.com>
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

I think you should try
echo activate > /sys/devices/pnp0/00:03/resources

and check dmesg for feedback


On Tue, 18 Jan 2005 18:56:01 +0000, Damien Challet wrote:

> Dear All,
>=20
> I understand that in principle the equivalent of
>=20
> setpnp 0x0e on
>=20
> is (with PNPACPI)
>=20
> echo 1 > /sys/device/pnp0/00:0e/power
>=20
> (from memory)
>=20
> The only problem is that even if I "activate" all the devices, I still
> cannot load the needed module (on a thinkpad 600e, module snd-cs4236).
>=20
> What is needed in addition to that ?
>=20
> Many thanks
>=20
> Damien
>=20
>=20
>=20
> ------------------------------------------------------- The SF.Net emai=
l
> is sponsored by: Beat the post-holiday blues Get a FREE limited edition
> SourceForge.net t-shirt from ThinkGeek. It's fun and FREE -- well,
> almost....http://www.thinkgeek.com/sfshirt




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
