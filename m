From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: DSDT > 128k support
Date: Wed, 17 Nov 2004 12:23:12 -0700
Message-ID: <200411171223.12417.bjorn.helgaas@hp.com>
References: <20041117.230831.74752627.t-kochi@bq.jp.nec.com> <1100713897.993.8.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1100713897.993.8.camel@d845pe>
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
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 17 November 2004 10:51 am, Len Brown wrote:
> I think the code in the kernel to supply /proc/acpi/dsdt
> and /proc/acpi/fadt should be deleted.  This capability
> and more can be had entirely from a user-space /dev/mem reader
> such as acpidmp in the pmtools package:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Except that acpidmp still gropes through 0x000e0000-0x00100000
looking for something that looks like an RSDP.  I don't think
that works on ia64.  (We do provide /sys/firmware/efi/systab,
which contains the address you need, so acpidmp could probably
use that when it's available.)


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
