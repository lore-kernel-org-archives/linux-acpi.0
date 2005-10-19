From: Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
Subject: Re: Toshiba Satellite L10-101 Smart Battery System works with patched DSDT
Date: Wed, 19 Oct 2005 20:21:50 +0200
Message-ID: <200510192021.51029.o.jansen@orb-net.de>
References: <43567DFF.3080700@suse.de> <20051019173121.GD27321@sleipnir.th0r.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051019173121.GD27321-rz8jLxre1qwP9awr7APIu/PDFXDs3Ay+@public.gmane.org>
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

Hi Fred, 

> That would be really interesting. The problem is that the ec-nospinlock
> patch in that project just works for kernels 2.6.10/11/12 but not for
> the current 2.6.13 kernel. I already tried to adapt it but i need a lot
> more knowledge of acpi/kernel hacking to achieve this.

have you tried to boot you machine with the kernel parameter ec_burst=1. This 
works on my machine. Up to kernel 2.6.11 I've used Rich Townsends spinlock 
patch. But afterwards i found a posting from Luming Yu in which he asked to 
try his patche which should solve this interrupt issue. And fortunately his 
patches found the way to the kernel-sources :-)
Perhaps you should have a look at /drivers/acpi/ec.c. If there is something 
like setup("ec_burst= ...  you may give this a try.

regards and good luck
	Olaf




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
