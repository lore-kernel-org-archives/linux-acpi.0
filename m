From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Wed, 28 Jan 2004 20:21:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3n087khfl.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

Hi all,

still having problems with ACPI on ASUS M2N. [1]

With linux-2.6.2-rc2-mm1 with acpi4asus from CVS as of today:


Suspending to disk (S4) suspends just fine. It also finds the file and
reads the data back into active memory, as well. But when it comes to
the message

 "Waiting for DMAs to settle down." 

the machine suddenly crashes (reboot).

I tried to get some debugging output by not having swap mounted when
trying to suspend so it would have to come right back up. Here is the
output


--=-=-=
Content-Disposition: attachment

Suspend Machine: Suspend failed, trying to recover...
Restarting tasks...<3>bad: scheduling while atomic!
Call Trace:
 [<c011b553>] schedule+0x5b3/0x5c0
 [<c011a5d9>] try_to_wake_up+0x109/0x1c0
 [<c011a69d>] wake_up_process+0xd/0x20
 [<c0135514>] thaw_processes+0xa4/0xe0
 [<c013677d>] software_suspend+0x8d/0xc0
 [<c01fe95a>] acpi_system_write_sleep+0xb3/0xce
 [<c01530cc>] vfs_write+0x9c/0x100
 [<c01531ad>] sys_write+0x2d/0x50
 [<c0366de7>] syscall_call+0x7/0xb

 done
bad: scheduling while atomic!
Call Trace:
 [<c011b553>] schedule+0x5b3/0x5c0
 [<c01531ad>] sys_write+0x2d/0x50
 [<c0366e1a>] work_resched+0x5/0x16

--=-=-=
Content-Disposition: inline



Suspend to RAM (S3 via 3bios) seems to suspend the machine just
fine. Only the power button brings it back up, but when it comes back
up it seems to hang -- cannot tell as even though the disk seems to
have come activity the screen remains black and network apparently
doesn't come up.

Hope this helps tracking down the ACPI problems.

Help appreciated, if more input is needed, please let me know.

Regards,
Georg


[1] System info at http://bugzilla.kernel.org/show_bug.cgi?id=1774

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFAGAu+bvivwoZXSsoRAnDfAJ9JtGEFdpbZS4Veoc/FXDsrk2a2XQCfZQdB
S0fV0AC9mEeYGV3xPLRiKIQ=
=ev2Y
-----END PGP MESSAGE-----
--==-=-=--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
