From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: DSDT in initrd?
Date: 06 May 2003 10:06:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <871xzcts6v.fsf@lapper.ihatent.com>
References: <Pine.LNX.4.53.0304282017540.1928@phoenix.kerstin.at>
	<20030504215051.GA488@elf.ucw.cz>
	<Pine.LNX.4.53.0305050829420.25721@dynast.gaugusch.at>
	<200305060007.49847.bob@diamond.demon.co.uk>
	<Pine.LNX.4.53.0305060743450.2529@tweety.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.53.0305060743450.2529-qopfHk9/S+VQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org> writes:

> On May 6, Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org> wrote:
> > Why use initrd?  Why not allow a file name to be passed to the kernel at
> > boot a la acpi=off, acpi=mydst.hex or whatever?  Put the file in the
> > /boot directory?
> I think that this is not possible. The filesystem would have to be
> accessible which is not the case at the early stage where ACPI loads
> (there could even be the case, that no interrupts are assigned yet, to use
> the scsi controller where the partition with the file is stored). Not to
> mention, that harddisk and scsi drivers are loaded much later anyway.
> The initrd is the only sane way to do this. I could also change my patch
> to accept a plain DSDT file, without my 'magic' signature, if no other
> initrd data is present.
> 

Or make the acpi=file.hex boot argument refer to a file within the
initrd image. Then its just a case of getting mkinitrd patched to look
for /boot/dsdt.hex by default, and letting the user specificy an
alternate DSDT by parameter and generating initrd's would be a simple.

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+t20FCQ1pa+gRoggRAqGvAKCZ1Vj+UcYKaRc/mvjwPkO7SKNqgACfSc7H
O0FXhxPs9k0paJ0i2jUSZgA=
=c/nm
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
