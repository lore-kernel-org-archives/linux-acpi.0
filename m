From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: preparing toshiba_acpi driver release
Date: Mon, 26 Jan 2004 11:32:57 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40154139.40009@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Len,

I'm preparing a new release of the toshiba_acpi driver.  Below is the
tentative changelog.  I haven't been following the check-in policy of
the kernel or acpi subsystem lately, so I'm wondering if I can give this
to you as a single patch or do you need it in several parts.


~  * Fix remote chance of invalid buffer access in write_video.

~  * Support alternate HCI method path (recent "Phoenix BIOS" Toshiba's).

~  * Report more proc-write errors.

~  * On proc-reads, report errors via printk instead of proc output.

~  * Add level to all printk's.

~  * Add missing __init and __exit function attributes.


Regards,
- -John Belmonte


- --
http:// if  ile.org/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAFUE35Nfg6kxAQQoRAjQaAKCsdt8QoBH6w2TbtyPSzfpEy1ywMACguflq
cc6Z79zaEhCmj4C9USs5TBE=
=oq55
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
