From: Ralph Blach <chipper-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: problems with acpi_tb_validate_rsdt
Date: Fri, 10 Jun 2005 14:41:03 -0400
Message-ID: <42A9DEBF.5040404@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Guys,

I have a problem.  I have a bios ACPI 2.0 level Bios that has RSDT table 
  but NO xsdt table.  This is allowed in the spec,

If you have no XSDT table, then you are to use the RSDT table.

If you have both, then it is required that you use the XSDT table, not 
make a copy of the XSDT from the RSDT table.


Look on page 98 of   ACPIspec-2-0c where  it says that


"5.2.7 Extended System Description Table (XSDT)

The XSDT provides identical functionality to the RSDT but accommodates 
physical addresses of
DESCRIPTION HEADERs that are larger than 32-bits. Notice that both the 
XSDT and the RSDT can be
pointed to by the RSDP structure. An ACPI 2.0-compatible OS must use the 
XSDT if present."

as it is now, with no XSDT table, the search for the RSDT simple walks 
memory and fails

Also, if the XSDT table is present, it appears to be deleted and NOT 
used.  This is incorrect.  It MUST be used over the RSDT.

Any comments on how to fix?

Good, bad, am I wrong? I am open to comments,


Chip
-- 
Ralph "Chip" Blach
chipper-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
IBM Linux Technology Center
Raleigh, North Carolina
919 543 1207


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
