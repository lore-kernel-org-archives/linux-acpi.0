From: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Battery status wrong from 2.6.7 when running on batteries
Date: Sat, 6 Nov 2004 23:01:10 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0411062253560.5414@frog.athome>
References: <16768.60745.952949.338093@aber.ac.uk> <16769.6764.210990.366655@aber.ac.uk>
 <Pine.LNX.4.60.0410282005580.4042@frog.athome> <16769.64228.751344.828301@aber.ac.uk>
 <Pine.LNX.4.60.0410291255100.1318@frog.athome> <16770.21398.497934.189008@aber.ac.uk>
 <Pine.LNX.4.60.0410301303050.1003@frog.athome> <16774.14973.261012.528478@aber.ac.uk>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16774.14973.261012.528478-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Fred,
On Mon, 1 Nov 2004, Fred Labrosse wrote:
> liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org writes:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Salut Fred,
> > first I would ask you that we should take this discussion off the list.
> > Maybe we should open a bugzilla-case for that issue: http://bugme.osdl.org
>
> I just did: #3678
>
> >
> > To get on with our search, you might want to send the .config you used
> > (i.e. mine, which you changed by two items???), and I would try to
> > reproduce you problems. You talked about a different NIC. I thought, that
> > it is all the time a RTL-8139 chip CONFIG_8139 which is built into TM 63x
> > notebooks, but maybe it is just the modus (module vs. buil-in)?
>
> Sorry, you have the same NIC (CONFIG_8139TOO).  I was just looking for a
> module and your's was in the kernel.  The only two changes I made were
> CONFIG_DEVFS_MOUNT set and CONFIG_DEVPTS_FS_XATTR unset).  However, a diff
> on yoyr file and the .config after the "make menuconfig" shows more.
> Attached is my .config based on your config file.
I am verry sorry that I have to tell you, that I spoke of Linux 2.6.9, 
when I was running 2.6.8. So with 2.6.9 and 2.6.10-rc1 the poweroff-problem
also happens with my TM634. On the other hand, I never had the temprature 
and AC-status thing.
There is a bad workaround for our laptops: If you close the lid, it will 
not restart. That is a protective rule in the BIOS that should prevent the 
laptop to start while in it's covered in its bag (I suppose).

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBjUmv9bBoTzOf1pMRAu7XAKDj3wHMDxx9koB4dJPo+X8zfGaqggCff+mg
t3MNVgjTnFthaxJym0d9S2I=
=lvmZ
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
