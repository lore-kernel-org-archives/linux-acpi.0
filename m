From: Andreas Dieling <snow-1pFVYSAoaJAREI5ypv3d1g@public.gmane.org>
Subject: Re: acpi_serialize not working?
Date: Fri, 10 Sep 2004 14:54:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409101454.51943.snow@quantentunnel.de>
References: <37F890616C995246BE76B3E6B2DBE05501F537BE@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05501F537BE-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
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

On Friday 10 September 2004 00:55, Moore, Robert wrote:
> The implementation of the forced serialization is straightforward:
>
>     if (AcpiGbl_AllMethodsSerialized)
>     {
>         ObjDesc->Method.Concurrency = 1;
>         ObjDesc->Method.MethodFlags |= AML_METHOD_SERIALIZED;
>     }
>
> I would be interested in more information on the failure.
>

I put some debug output into the code when "acpi_gbl_all_methods_serialized" 
is altered, an it seems that first the kernel parameters are parsed and 
acpi_gbl_all_methods_serialized is correctly set to TRUE but after that the 
global acpi variables are initialized and acpi_gbl_all_methods_serialized is 
set back to FALSE...

http://www.tzi.de/~adieling/dmesg.out


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
