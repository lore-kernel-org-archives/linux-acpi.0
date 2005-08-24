From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: RE: acpidump replaces acpidmp
Date: Wed, 24 Aug 2005 01:44:12 -0400
Message-ID: <1124862252.28987.5.camel@firebird.lenb.worldpath.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B300456A26A@hdsmsx401.amr.corp.intel.com>
	 <200508161532.34578.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508161532.34578.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Voluspa <voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-08-16 at 17:32 -0400, Bjorn Helgaas wrote:
> On Tuesday 16 August 2005 12:23 pm, Brown, Len wrote:
> > Mats,
> > Does the latest acpidump work for you now?
> > can we obsolete /proc/acpi/fadt,dsdt?
> 
> pmtools-20050804 doesn't work at all on ia64, because
> the RSDP doesn't live where you expect it.  We export
> /sys/firmware/efi/systab with the addresses you want.
> 
> The attached patch adds this, fixes a bunch of
> documentation errors, and fixes some broken if/else
> blocking.  There are still a number of warnings when
> building on ia64; I didn't bother to fix those, sorry.

Thanks Bjorn.
Alexey included your patch in pmtools-20050823,
and has now tested the latest on IA64 systems with
and without /sys/firmware/efi.

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20050823.tar.gz

cheers,
-Len




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
