From: Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
Subject: Re: New Smart Battery release (incl. updated embedded controller patches)
Date: Tue, 15 Nov 2005 08:02:00 +0100
Message-ID: <200511150802.00439.o.jansen@orb-net.de>
References: <4376BD90.5080603@bartol.udel.edu> <43791753.2030004@rrz.uni-koeln.de> <437951CE.7060708@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <437951CE.7060708-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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

Hello Rich, hello Berthold, 

>
> You don't mention whether you've applied the acpi-ec-nospinlock patch. This
> patch is designed to remove lost interrupts completely. I know that Olaf
> has used this patch -- perhaps that is what you are missing.

I've used the spinlock Patch for a long time together with kernel 2.6.11 
(gentoo) on my ACER extensa 3002 WLMi. After that i've switched to 2.6.12 
where I've tried the ec_burst patches from Luming. With the kernel parameter 
ec_burst=1 i was able to use the system without problems. Later the patch 
from Luming found the way into the kernel and i thought fine for me no 
patching related to the interrupt issue needed any more. But on Bertholds 
machine it seems to be different from the situation here. For example he is 
able to suspend his machine (when he has success typing the needed 
commands :-) On my machine it is no problem typing the commands but in most 
cases (>90%) this is the last thing I do. We have tried to compare our 
machines and in fact we only found two differences Berthold has 1G and BIOS 
3A10 while on my machine there are ony 512Mb with BIOS revision 3A08.

Now I've tested the new sbs-cm spinlock patch with kernel 2.6.13 (gentoo) and 
my machine continued to work without missing keys. 

Regards
	Olaf


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
