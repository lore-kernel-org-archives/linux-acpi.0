From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: Incomplete list of pnp entries/resources with pnpacpi
Date: Mon, 24 Jan 2005 21:25:29 +0200
Message-ID: <20050124192529.GA9740@sci.fi>
References: <200501241704.46239.challet@maths.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200501241704.46239.challet-dK2jV70R1GDQzY9nttDBhA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Damien Challet <challet-dK2jV70R1GDQzY9nttDBhA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 24, 2005 at 05:04:45PM +0000, Damien Challet wrote:
> 3) The resources allocated to each entry are not complete:=20
>=20
> for instance, pnpbios gives
>=20
> 0e CSC0100 multimedia controller: audio
>         io 0x0530-0x0537
>         io 0x0388-0x038b
>         io 0x0220-0x0233
>         irq 5
>         dma 0
>         dma 1
>=20
> and pnpacpi
>=20
> 00:06  state =3D active
> io 0x530-0x537

Have you tried this patch?
http://thread.gmane.org/gmane.linux.kernel/257312

For some reason it hasn't it been included in the kernel. Is the patch=20
wrong or did it simply fall through the cracks?

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
