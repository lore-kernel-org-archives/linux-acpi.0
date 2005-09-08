From: Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Thu, 8 Sep 2005 11:04:35 +0200
Message-ID: <200509081104.36163.o.jansen@orb-net.de>
References: <41E81C2C.8010809@bartol.udel.edu> <200509061041.21722.o.jansen@orb-net.de> <200509061734.11182.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509061734.11182.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello Luming, 

> Thanks for testing.  Without ec_burst=1,  the driver still use spin lock.
> If ec_burst=1 doesn't work for you, I will be a little supprised.

now i've got everything up and running with kernel 2.6.13-git6. 
And yes you are right. With your patch my machine is lucky again :-) Readout 
of battery is fast and with ec_burst=1 there seems to be no problem with 
missing keys.


Thanks again
	Olaf

P.S.: If i should do some special testing or you please let me know.

System:
Acer Extensa 3002 WLMI
gentoo linux with kernel-2.6.13-git6
ipw2200-1.0.6 (WPA with wpa_supplicant)
ATI fglrx 8.14.13


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
