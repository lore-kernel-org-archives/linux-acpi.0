From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [Acpi4asus-user] ACPI with Kernel 2.6.0-test9 on Asus M2N
Date: Mon, 27 Oct 2003 18:03:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031027170359.GB11206@hell.org.pl>
References: <1067270730.4265.45.camel@RTop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1067270730.4265.45.camel-RU1JJA7J9tM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: rmuehlhoff <rmuehlhoff-52dn/g0OV9M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote rmuehlhoff:
> I just updated from 2.4 to 2.6 kernel. I'm using the original sources wthout any patches. 
> When compiling the kernel with ACPI support, it hangs on startup when initialising ACPI 
> (hmm difficult to describe because I cant't give you a log for this happens so early, logging is not yt active). 
> 
> You know, when ACPI get initialised in the early startup phase, there are various moments where long lines of dots 
> appear on the screen... In the third instance, the system hangs after a few dots. 

A blind guess: try to reverse the patch [1] and recompile your kernel.
[1]
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.4.22/20031017152411-acpi_ec_gpe_query.patch

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
