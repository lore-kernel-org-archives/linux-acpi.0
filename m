From: Gunter Ohrner <G.Ohrner-6V9naDJErT6662+jY7v6MhvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: DSDT in initrd
Date: Wed, 21 May 2003 10:07:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305211007.45786@mail.CustomCDROM.de>
References: <A5974D8E5F98D511BB910002A50A6647054FC40A@hdsmsx103.hd.intel.com> <Pine.LNX.4.53.0305202002180.22586@tweety.gaugusch.at> <baf9df$ro3$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <baf9df$ro3$1@main.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Mittwoch, 21. Mai 2003 09:23 schrieb Nathan Gray:
> > Because I'm scanning raw initrd data? Can anybody give me hints or a
> > better solution? I'm willing to improve it, but I don't think that it is
> > easy to do.
> I continue to think that the proper solution is a separate kernel paramet=
er
> acpi_tables=3D/boot/tables.??? (with credit to the person who generalized
> this idea from the dsdt to all tables).  I know you're concerned about fs
> drivers not being around, but if the kernel can find the initrd on the di=
sk
> it should be able to find other files somehow.

I cannot. It needs help from the boot loader.

> guess my next question would be, is there a filesystem in the initrd, and
> if so can you implement your patch in a way that respects the filesystem
> abstraction rather than scanning the raw bytes.  I'm not much of a kernel

There is, but at the time the DSDT is needed the filesystem drivers probabl=
y=20
are not yet initialized so you cannot use them to access the DSDT.

Greetings,

  Gunter

=2D --=20
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                   PGP-verschl=FCsselte Mails bevorzugt!                 +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
Lady Ramkin's bosom rose and fell like an empire.        -- (Terry=20
Pratchett, Guards! Guards!)
+-+-+-+-+-+-+-+-+-+-+-+-+ http://www.lspace.org +-+-+-+-+-+-+-+-+-+-+-+-+
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+yzPQ0ORHvREo8l8RAneNAJ97y4L7ni+1gMmLIlh+NMrkxHkY7gCeN4oc
+SAL4tHxCxs6v+Bqn/7rdE0=3D
=3DFHC6
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
