From: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Subject: Re: DSDT in initrd?
Date: Tue, 6 May 2003 00:07:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305060007.49847.bob@diamond.demon.co.uk>
References: <Pine.LNX.4.53.0304282017540.1928@phoenix.kerstin.at> <20030504215051.GA488@elf.ucw.cz> <Pine.LNX.4.53.0305050829420.25721@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.53.0305050829420.25721-sxQ525G0OhRQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Why use initrd?  Why not allow a file name to be passed to the kernel at =
boot=20
a la acpi=3Doff, acpi=3Dmydst.hex or whatever?  Put the file in the /boot=
=20
directory?

Just my two pennies worth

Bob

On Monday 05 May 2003 07:39, Markus Gaugusch wrote:
> > > Has anybody thought about putting the dsdt into the initial ramdisk=
?
> > > This would make changing/updating it much easier.
> >
> > I guess initrd is too late to override it...
>
> If I would mount it, probably yes. But I rather thought about the way t=
hat
> bootsplash uses: Scan the initrd for a magic signature and read it 'raw=
'.
> The dsdt would not be in the filesystem of the initrd, but just appende=
d
> to the compressed initrd. I think that something that is early enough f=
or
> bootsplash should be early enough for the dsdt as well.
>
> Markus

--=20
Bob Lees
Diamond Consulting Services Ltd
Aylesbury, Bucks, HP17 8UG
Phone: +44 (0) 1296 747667
Fax: +44 (0) 1296 747557
email: bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
