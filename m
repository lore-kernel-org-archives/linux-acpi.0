From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: CONFIG_ACPI_DEBUG cost
Date: Tue, 2 Nov 2004 09:46:46 -0700
Message-ID: <200411020946.46877.bjorn.helgaas@hp.com>
References: <1099029802.143.226.camel@d845pe> <20041031184823.GA5578@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041031184823.GA5578-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 31 October 2004 11:48 am, Pavel Machek wrote:
> Its worse than that, it looks very ugly in the sources. See for
> example return_VALUE() macro...

I'm fairly used to the look of the source now.  I only get bitten
occasionally by the weird semantics of ACPI_FUNCTION_TRACE (it
looks like a function call, but actually declares variables, or
something) :-)

> I think acpi debugging crap^H^H^H^Hstuff should be simply removed in
> favor of people running kgdb or something like that. ["If you want to
> print all names of functions being entered, you should probably be
> using debugger in the first place"]

I wouldn't be opposed to removing it, since I never figured out
how to use it.  But I'm not opposed to leaving it in, either, if
it is useful to other people.  If it is left in, it would be
nice to have a writeup of how to use it in Documentation/*.  I'm
sure there's cool stuff it can do, and I feel kinda left out
since I can't figure out how to make it dance.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
