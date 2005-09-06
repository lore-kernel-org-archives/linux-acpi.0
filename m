From: Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Tue, 6 Sep 2005 10:41:21 +0200
Message-ID: <200509061041.21722.o.jansen@orb-net.de>
References: <41E81C2C.8010809@bartol.udel.edu> <200509060819.13292.o.jansen@orb-net.de> <200509061448.12234.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509061448.12234.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

Hi Luming, 


> Please try if  this works too
> http://bugzilla.kernel.org/show_bug.cgi?id=3851#c73

with this patch ( i applied it to a fresh 2.6.13 vanilla kernel ) a older 
problem reoccured on my machine. When i type (fast) sometimes keystrokes are 
missed. But the time for reading the battery state is OK. Can i give you more 
information or help in debugging? 

With ec_burst=1 it seems to be slightly better but i'm afraid some keys are 
lost then too.

Thanks a lot
	Olaf


BTW.: if this is only a problem on my (rotten) ACER. The patch from Rich 
Townsend works here really sufficient for me. But I am really willing to help 
you - if you want me to do so


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
