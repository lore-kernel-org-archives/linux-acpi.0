From: "Marcos D. Marado Torres" <marado-oe7qfRrRQfcmha6Ds7sm0l6hYfS7NtTn@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.6.10
Date: Fri, 3 Dec 2004 18:46:41 +0000 (WET)
Message-ID: <Pine.LNX.4.61.0412031840340.19044@student.dei.uc.pt>
References: <1101945436.8026.392.camel@d845pe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1101945436.8026.392.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 1 Dec 2004, Len Brown wrote:

> Hi Linus, please do a
>
> 	bk pull bk://linux-acpi.bkbits.net/26-latest-release

If this release is equivalent with -mm's bk-acpi.patch from 2.6.10-rc2-mm1 to
2.6.10-rc2-mm4, notice that this kernels' bk-acpi patches have the bug
described in http://lkml.org/lkml/2004/11/16/263 , so I wouldn't really like to
see this pull done to 2.6.10 until the problem is solved...

If you want, I can try this patch to see if it acts like bk-acpi.patch, but I
guess it does...

Best Regards,
Marcos Marado

> thanks,
> -Len
>
> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/26-latest-release/acpi-20041105-26-latest-release.diff.gz

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado-oe7qfRrRQfcmha6Ds7sm0l6hYfS7NtTn@public.gmane.org
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFBsLSTmNlq8m+oD34RAsmNAJ9CZ8nYf5vAUCWgcw+8goIfCPzgMwCeJbX7
K6IwrmiNyhm3a4bYbSrXNv8=
=RMUe
-----END PGP SIGNATURE-----



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
