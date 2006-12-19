From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 3/22] Remove deprecated parameters
Date: Tue, 19 Dec 2006 23:18:10 +0100
Message-ID: <200612192318.10845.corentincj@iksaif.net>
References: <200612192218.55855.corentincj@iksaif.net> <20061219134500.a058bb8f.randy.dunlap@oracle.com>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:60283 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932968AbWLSWSN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Dec 2006 17:18:13 -0500
In-Reply-To: <20061219134500.a058bb8f.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

Just look the code ;)
> > -               printk(KERN_WARNING "  asus_uid and asus_gid parame=
ters
> > are " -                      "deprecated, use chown and chmod
> > instead!\n"); -       }

Le mardi 19 d=E9cembre 2006 22:45, vous avez =E9crit=A0:
> On Tue, 19 Dec 2006 22:18:55 +0100 Corentin CHARY wrote:
> > Remove the deprecated asus_uid and asus_gid parameters.
>
> Hi,
> Where are they documented as deprecated?
>
> Thanks.
>
> > Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> > ---
> >  asus_acpi.c |   29 +++++------------------------
> >  1 file changed, 5 insertions(+), 24 deletions(-)
> >
> > --- a/drivers/acpi/asus_acpi.c  2006-12-15 10:36:09.000000000 +0100
> > +++ b/drivers/acpi/asus_acpi.c  2006-12-15 10:37:36.000000000 +0100
> > @@ -76,13 +76,6 @@
> >  MODULE_DESCRIPTION(ACPI_HOTK_NAME);
> >  MODULE_LICENSE("GPL");
> >
> > -static uid_t asus_uid;
> > -static gid_t asus_gid;
> > -module_param(asus_uid, uint, 0);
> > -MODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus.\n"=
);
> > -module_param(asus_gid, uint, 0);
> > -MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n"=
);
> > -
> >  /* For each model, all features implemented,
> >   * those marked with R are relative to HOTK, A for absolute */
> >  struct model_data {
> > @@ -916,8 +909,8 @@
> >         proc->read_proc =3D readfunc;
> >         proc->data =3D acpi_driver_data(device);
> >         proc->owner =3D THIS_MODULE;
> > -       proc->uid =3D asus_uid;
> > -       proc->gid =3D asus_gid;
> > +       proc->uid =3D 0;
> > +       proc->gid =3D 0;
> >         return 0;
> >  }
> >
> > @@ -926,19 +919,7 @@
> >         struct proc_dir_entry *proc;
> >         mode_t mode;
> >
> > -       /*
> > -        * If parameter uid or gid is not changed, keep the default
> > setting for
> > -        * our proc entries (-rw-rw-rw-) else, it means we care abo=
ut
> > security,
> > -        * and then set to -rw-rw----
> > -        */
> > -
> > -       if ((asus_uid =3D=3D 0) && (asus_gid =3D=3D 0)) {
> > -               mode =3D S_IFREG | S_IRUGO | S_IWUGO;
> > -       } else {
> > -               mode =3D S_IFREG | S_IRUSR | S_IRGRP | S_IWUSR | S_=
IWGRP;
> > -               printk(KERN_WARNING "  asus_uid and asus_gid parame=
ters
> > are " -                      "deprecated, use chown and chmod
> > instead!\n"); -       }
> > +       mode =3D S_IFREG | S_IRUGO | S_IWUGO;
> >
> >         acpi_device_dir(device) =3D asus_proc_dir;
> >         if (!acpi_device_dir(device))
> > @@ -949,8 +930,8 @@
> >                 proc->read_proc =3D proc_read_info;
> >                 proc->data =3D acpi_driver_data(device);
> >                 proc->owner =3D THIS_MODULE;
> > -               proc->uid =3D asus_uid;
> > -               proc->gid =3D asus_gid;
> > +               proc->uid =3D 0;
> > +               proc->gid =3D 0;
> >         } else {
> >                 printk(KERN_WARNING "  Unable to create " PROC_INFO
> >                        " fs entry\n");
> >
> >
> > --
>
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
