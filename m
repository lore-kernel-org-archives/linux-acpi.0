From: Nuno Tavares <nunotavares-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re: ACPI and USB problems (usbnet)
Date: Sat, 31 Jul 2004 04:21:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.07.31.03.21.11.31852@hotmail.com>
References: <pan.2004.07.27.01.49.20.567519@hotmail.com> <1090969238.19046.26.camel@neuromancer.home.net> <pan.2004.07.28.15.49.34.346706@hotmail.com> <1091057294.10188.39.camel@neuromancer.home.net>
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

Em Wed, 28 Jul 2004 16:28:14 -0700, Ow Mun Heng escreveu:

>> > Didn't try with ACPI off though

Did you try it?

> Actually I think it's a kernel issue. 

In which subsytem?

> When on RH9 and and running 2.6.3,
> no problems. 

I'll test 2.6.3. 

Can you answer those questions? 
Plus this one: do you have any other USB devices plugged in (I don't)?

>> Perhaps we can establish a pattern...
>> What's your motherboard (output 'dmidecode')? 
>> What's your USB Host Controller (UHCI/OHCI/EHCI)?

It seems to be UHCI, right (I'm assuming you are talking about Dell D600),
and it seems to be EHCI also. Did you try to plug the mouse on the EHCI
(usb2) virtual hub?

>> Does 'lsusb -vvv | grep unknown' gives you any 'unknown interface class
>> descriptor' messages? This is known to be errors in the
>> manufacturer's USB code (CIIW), which seem to be related.

-- 
Nuno Tavares
http://nthq.cjb.net/




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
