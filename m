From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Acpi slows down my new Asus portable quite a lot
Date: Wed, 16 Jul 2003 00:10:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030715221027.GA9900@hell.org.pl>
References: <20030715142915.GB4920@casa.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030715142915.GB4920-Ap7NVfYj2GpM1YnL2Vgg6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Carlo E. Prelz" <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Carlo E. Prelz:
> It is a Centrino-based N3700N. Using a kernel with only APM, the audio

Though I can't unfortunately help much, I must say...

Wow, there's some really interesting stuff in your DSDT. It seems that the
nice people from ASUS decided to make their users' (and my) life easier, by
implementing frequency control methods for their driver. Since I'm leaving
in a couple of days, this won't probably be implemented for some time yet
(unless Julien gets to work on it), but look forward to getting basic
support for your laptop in the tomorrow's acpi4asus CVS.

BTW: Have you tried recompiling your DSDT? The MXN DSDT's oddly contain
some trivial-to-fix errors (like the If(SSn) statements in your case),
there's even an updated DSDT at http://acpi.sf.net.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
