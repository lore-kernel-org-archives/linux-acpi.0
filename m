From: Johannes Schanda <johannes.schanda-1R9WWMedIqeELgA04lAiVw@public.gmane.org>
Subject: Fwd: Acer Extensa 3001 battery problem (smart battery)
Date: Mon, 13 Sep 2004 00:26:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409130026.10855.johannes.schanda@schanda.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi everyone,

Ok, previous message was too big, I've changed the attachments to urls. If the 
other message comes through later, sorry about the double post.

I have a problem with my Acer Extensa 3001 laptop. The battery and ac adaptor
are not detected, i.e. the /proc/acpi/battery and /proc/acpi/ac_adaptor
directories are empty. I've already tried fixing my dsdt (it contained 3
warnings), applying the ecdt fix from bugzilla.kernel.org and setting
acpi_os_name boot paramter.

After investigating my dsdt I'm pretty sure that I actually have a smart
battery, I even tracked down the dsdt code for it:

Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x1D)
                    Name (OSEJ, 0x00)
                    Device (SMBC)
                    {
                        Name (_HID, "ACPI0001")
                        Name (_EC, 0x1820)
                        Device (SBS0)
                        {
                            Name (_HID, "ACPI0002")
                            Name (_SBS, 0x02)
                        }
                    }

This section looks nearly identical to the smart battery example from the
acpi 2.0 spec. Now my question is this: Is there anything left I can try, or
does acpi4linux not support smart batteries yet? As far as I understand the
spec, there should be a sbdt table as well to describe the smart battery,
but my log makes no mention of it. Here are url's for my dmesg | grep ACPI 
output (http://www.schanda.de/jo/log), my dmidecode output 
(http://www.schanda.de/jo/dmidecode), my acpidump output 
(http://www.schanda.de/jo/dump) and my decoded dsdt 
(http://www.schanda.de/jo/dsdt-old.dsl). Any help would be appreciated!

Johannes


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
