From: Mihai RUSU <dizzy-xalhOkOe1IBeoWH0uzbU5w@public.gmane.org>
Subject: Re: [RFC] enhanced psxface.c error handling
Date: Thu, 4 Dec 2003 18:14:06 +0200 (EET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.56L0.0312041813010.8695@ahriman.bucharest.roedu.net>
References: <1070553752.14488.4.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1070553752.14488.4.camel-W4YXS4xboDgEw8Tza038mh62k8T7mm+c@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Felipe Alfaro Solana <felipe_alfaro-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailinglist <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

I think you missed the order on this one

@@ -142,14 +143,15 @@
        walk_state = acpi_ds_create_walk_state (obj_desc->method.owning_id,
                           NULL, NULL, NULL);
        if (!walk_state) {
- -               return_ACPI_STATUS (AE_NO_MEMORY);
+               goto acpi_psx_parse_unref;
+               status = AE_NO_MEMORY;
        }

:)

On Thu, 4 Dec 2003, Felipe Alfaro Solana wrote:

> Hi!
> 
> This patch tries to fix the situation where an error could cause
> acpi_psx_execute() to exit without releasing held references to the
> elements of param[].
> 
> Thanks!
> 

- -- 
Mihai RUSU                                    Email: dizzy-xalhOkOe1IBeoWH0uzbU5w@public.gmane.org
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z11QPZzOzrZY/1QRAriPAJ9tJ9A+l1VVCkvxVp5xKcl29+vnBwCguemq
B4+AFaGmaYPah7YgNObfbk4=
=6Nay
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
