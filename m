From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Tue, 25 Nov 2003 18:07:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031125160705.GA4776@luna.mooo.com>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org> <3FC106AE.4040701@pca.it> <20031124124451.GB7374@poupinou.org> <3FC20D2F.30305@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FC20D2F.30305-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 24, 2003 at 02:52:47PM +0100, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> sorry boring you guys with such a lot of questions...
> 
> on 11/24/03 13:44, Ducrot Bruno wrote:
> | AFAIK, laptop-mode is only in 2.4, and I am not aware of a port
> | to 2.6.
> Is there something similar on kernel 2.6? Because ATM I can have
> 'cpufreq' support on kernel 2.6, but AFAIK not yet on 2.4.23-rc3, so
> there're some power management (PM) options available for one specific
> kernel and not the other and viceversa...
> 

There is a cpufreq patch for 2.4. Last time I checked it was aimed at
2.4.22 and required some reject fixing for 2.4.23.
Don't know how stable it is with the 2.4.23 kernels (I had some troubles
in conjuction with swsusp and haven't located the exact source yet).
If you are interested in this I can dig up where to download it and a
patch I wrote to fix the rejects (it was for pre8 but probably won't
need too much work).

> Regards,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQE/wg0uVAp7Xm10JmkRAn3nAJ0bRH4EZ/WIMrXzDaIKtSa0GKSRoACdE+tb
> 696MGbvxsSfL3D4/SdzbPO4=
> =AZ5E
> -----END PGP SIGNATURE-----
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
