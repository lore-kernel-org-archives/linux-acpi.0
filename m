From: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Subject: Re: Dell DSDT corrected
Date: Wed, 29 Jan 2003 19:04:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030129180444.GB10601@homerelay.wiesner-net.de>
References: <200301281120.15917.jan.slezak@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200301281120.15917.jan.slezak-aRb0bU7PRFPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Slezak <jan.slezak-aRb0bU7PRFPrBKCeMvbIDA@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Jan Slezak schrieb:
> I modified my Dell Latitude C640 DSDT table and values in /proc/acpi what were 
> previously constantly zero (or something equivalent) where brought to life. 
> This is:
> 
> - temperature in thermal zone
> - processor frequency in performance in processor (processor consumption is 
> still zero, but I belive it is not exposed to ACPI)
> - all information in battery (except presence/absence what was already working 
> before)
> 
> The DSDT patch and original DSDT are enclosed I hope it helps someone.

Yes, it does! The patch works without modification for my Inspiron 8200,
too. Great work!

Thanks,
Markus Wiesner
-- 
Never trust a man who can count to 1023 on his fingers.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
