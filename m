From: Nuno Tavares <nunotavares-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI and USB problems (usbnet)
Date: Wed, 28 Jul 2004 16:49:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.07.28.15.49.34.346706@hotmail.com>
References: <pan.2004.07.27.01.49.20.567519@hotmail.com> <1090969238.19046.26.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Em Tue, 27 Jul 2004 16:00:38 -0700, Ow Mun Heng escreveu:

> On Mon, 2004-07-26 at 18:49, Nuno Tavares wrote:
> USB mouse will lose connectivity needing a plugout-plugin again to bring
> it back up.

That's my case!
 
> Didn't try with ACPI off though

Give it a try, that might solve the issue, if ACPI is not *required*.

Perhaps we can establish a pattern...
What's your motherboard (output 'dmidecode')? 
What's your USB Host Controller (UHCI/OHCI/EHCI)?
Does 'lsusb -vvv | grep unknown' gives you any 'unknown interface class
descriptor' messages? This is known to be errors in the
manufacturer's USB code (CIIW), which seem to be related.


-- 
-
Nuno Tavares
http://nthq.cjb.net/




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
