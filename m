From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.6.10 and acpi_get_possible_resources? *solved*
Date: Mon, 17 Jan 2005 11:30:20 -0800
Message-ID: <20050117113020.A19913@unix-os.sc.intel.com>
References: <1105713621.10664.8.camel@paragon.slim> <1105833637.27841.4.camel@paragon.slim>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1105833637.27841.4.camel-AynNu1t4G8oLie942ae2tA@public.gmane.org>; from gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org on Sun, Jan 16, 2005 at 01:00:37AM +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jurgen Kramer <gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 16, 2005 at 01:00:37AM +0100, Jurgen Kramer wrote:
> On Fri, 2005-01-14 at 15:40 +0100, Jurgen Kramer wrote:
> > I am trying to get the WACOM ACPI patches working on 2.6.10 but it bails
> > out on a missing function "acpi_get_possible_resources". On 2.6.9 the
> > needed symbol is exported by acpi_ksyms.c but this file no longer exists
> > in 2.6.10. 
> > 
> > What is the best way to get the acpi_get_possible_resources function
> > exported properly? It is defined in <acpi/acpxf.h> but adding this to
> > the wacom source files did not help.
> > 
> > The 2.6.9 version of the wacom patches are from:
> > 
> > http://www.theory.bham.ac.uk/staff/schofield/linux/tc1100/linux-2.6.9-
> > wacom_acpi.patch
> 
> Problem solved. The functions from <acpi/acpixf.h> needed a #define
> ACPI_FUTURE_USAGE 1 to work again.
> 
> My wacom tablet is working again with 2.6.10.
> 
A better fix, though, would be to move the specific export you
need out of the FUTURE_USAGE define. This ifdef was introduced
to eliminate bloat due to unused exports, and including it all
back in defeats the purpose.

Rajesh


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
