From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch for 0.54
 (version 3)
Date: Wed, 08 Sep 2004 15:02:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <413F02E7.3060005@pca.it>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403> <413EE1EA.2070307@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <413EE1EA.2070307-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ipw2100-devel <ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Herman Sheremetyev <mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello again,

on 09/08/04 12:41, Luca Capello wrote:
> it works perfectly on my ASUS M6N, 2.6.8.1 with no patch and S4: I can
> suspend/resume directly from X (Debian XFree86-4.3.0.dfsg.1-7 & GNOME
> 2.7.92). All is working correctly, not only the ipw2100 driver but all
> the other drivers, too. I mean, actually I loaded a lot of different
> modules (see below), I just did 'echo 4 > /proc/acpi/sleep' different
> times (this is the 3rd in sequence).
<cut>
> There's only one minor problem: sometimes during the suspend process the
> laptop doesn't shut down, the screen remains black and I have to
> manually press 4-sec the power button. Then resuming is always ok. But
> this is a minor issue ;-)
<cut>
> S3 doesn't work neither without the ipw2100: I get a resume suddenly
> after the suspend process is finished and without errors.
same /symptoms/ on 2.6.9-rc1 + ACPI 20040816: same success for
suspend/resume directly from XFree86 (with the included radeon driver)
and with the radeonfb loaded, same little problem with the black screen
in suspending and same problem for S3.

BTW is 'echo 4 > /proc/acpi/sleep' = 'echo disk > /sys/power/state'?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBPwLmVAp7Xm10JmkRAr+FAJ9xkC+dGthAyfcMSa9WbUf9ra5kpQCfSiZA
+fRCZL6m5a0vBp/Lzz7WrOw=
=ISWc
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
