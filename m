From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: hard drive errors on acpi s3 resume
Date: Tue, 8 Nov 2005 16:06:09 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E035A7B57@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yep on all.
Bob

> +       acpi_handle handle, parent_handle;

I don't like multiple declarations in one statement.

Bob

> -----Original Message-----
> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]
> Sent: Tuesday, November 08, 2005 1:12 AM
> To: Moore, Robert
> Cc: ACPI mailing list
> Subject: Re: [ACPI] hard drive errors on acpi s3 resume
>=20
> Hi!
>=20
> Please don't top post.
>=20
> > Just out of curiosity, what issues do you find with the coding
> > style?
>=20
> I hope that means you want to clean it up and apply it ;-).
>=20
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +#define DBG(x...) printk(x)
>=20
> Include in the middle of file? Renaming of printk to confuse reader?
>=20
> +       int i, tmp;
> +       acpi_integer addr;
> ...
> +       addr =3D i;
>=20
> ...oops, something is very wrong in acpi land.
>=20
> +#define GTM_LEN (sizeof(u32) * 5)
> ...
> +       u32     gtm[GTM_LEN/sizeof(u32)]; /* info from _GTM */
>=20
> Eh? Better names would be nice, too.
>=20
> +       for (i =3D 0; i < MAX_DEVICES; i ++)
>=20
> Please no space between i and ++.
>=20
> +static struct acpi_ide_stat *ide_get_acpi_state(acpi_handle handle)
>=20
> The function is strange, btw. Linear search, and it basically returns
> pointer to zeros. I'd expect zeroing to be in caller or something like
> that.
>=20
> +int acpi_ide_suspend(struct device *dev)
> +{
> +       acpi_handle handle, parent_handle;
> +       struct acpi_ide_stat *stat;
> +       acpi_status     status;
>=20
> At least alignment should be consistent locally.
>=20
> +static int acpi_ide_gtf(acpi_handle handle, ide_drive_t *drive)
> +{
> +       struct acpi_buffer      output =3D {ACPI_ALLOCATE_BUFFER, =
NULL};
> +       ide_task_t      args;
> +       int index =3D 0;
> +       unsigned char *data;
> +       union acpi_object       *package =3D NULL;
> +       acpi_status status;
>=20
> ...even more horible example of above.
>=20
> +               /* submit command request */
> +//             printk("return value %d\n", ide_raw_taskfile(drive,
&args,
> NULL));
> +               index +=3D 7;
>=20
> Someone should learn to use delete key and version control...
>=20
> +       if (stat->channel_handled =3D=3D 0) {
> +               stat->handle =3D NULL;
> +               goto gtf;
> +       }
> +DBG("Start STM\n");
> +       if (acpi_ide_stm(stat))
> +               return -ENODEV;
> +       stat->channel_handled =3D 0;
> +gtf:
> +       return acpi_ide_gtf(handle, drive);
> +}
>=20
> What about "else" instead of ugly goto. And that DBG should really go
> away.
>=20
> -
> +#ifdef CONFIG_ACPI
> +       acpi_ide_suspend(dev);
> +#endif
>=20
> -
> +#ifdef CONFIG_ACPI
> +       acpi_ide_resume(dev);
> +#endif
>         memset(&rq, 0, sizeof(rq));
>         memset(&rqpm, 0, sizeof(rqpm));
>         memset(&args, 0, sizeof(args));
>=20
> We normally allways provide acpi_ide_resume, but make them nop in
> !ACPI case. That means #ifdefs are avoided in callers.
>=20
> ...should be enough...
> 							Pavel
> --
> Thanks, Sharp!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
