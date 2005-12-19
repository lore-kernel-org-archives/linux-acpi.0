From: Frittella Laurento <laurento.frittella-GZ182KBqL3dNScdsXb3kHaicDR3qMxSs@public.gmane.org>
Subject: need help with my dell latitude d510 dsdt table
Date: Mon, 19 Dec 2005 17:24:16 +0100
Message-ID: <43A6DEB0.7080206@regione.abruzzo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Hi all,
I'm trying to fix my DSDT table on my DELL Latitude D510, using "Linux 
ACPI Howto" I've fixed some warnings... but how can I fix these?


dsdt.dsl  2330:                 Method (_S0D, 0, NotSerialized)
Warning  2096 -      Unknown reserved name ^  (_S0D)

dsdt.dsl  2396:                 Method (_S0D, 0, NotSerialized)
Warning  2096 -      Unknown reserved name ^  (_S0D)

dsdt.dsl  2461:                 Method (_S0D, 0, NotSerialized)
Warning  2096 -      Unknown reserved name ^  (_S0D)

dsdt.dsl  2526:                 Method (_S0D, 0, NotSerialized)
Warning  2096 -      Unknown reserved name ^  (_S0D)

dsdt.dsl  2591:                 Method (_S0D, 0, NotSerialized)
Warning  2096 -      Unknown reserved name ^  (_S0D)

dsdt.dsl  3807:                     Return (Package (0x00) {})
Remark   3069 -    Effective AML package length is zero ^


For the first 5 warnings the Method is the same:

Method (_S0D, 0, NotSerialized)
{
	Store (SMI (0x85, 0x00), Local0)
	And (Local0, 0x01, Local0)
	If (LEqual (Local0, 0x00))
	{
		Return (0x03)
	}
	Else
	{
		Return (0x00)
	}
}


For the last warning the part of interest is:

Device (VID2)
{
	Name (_ADR, 0x00020001)
	Method (_DOS, 1, NotSerialized)
	{
	}

	Method (_DOD, 0, NotSerialized)
	{
		Return (Package (0x00) {})
	}
}


Thanks in advance,
Frittella Laurento


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
