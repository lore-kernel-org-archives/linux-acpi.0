From: ultrakorne <ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Subject: can't read battery, dsdt bugged?
Date: Tue, 23 Nov 2004 16:53:10 +0100
Message-ID: <41A35CE6.90803@paranoici.org>
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

Hi, i have a acer laptop (travelmate 4501LCi) and i have installed 
ubuntu warty 4.10 (kernel 2.6.8.1)
the battery applet didnt works... this because /proc/acpi/battery/ is empty!
ps -e | grep acpi
     5 ?        00:00:00 kacpid
  3977 ?        00:00:00 acpid

so i disassembled my dsdt to see if i get compiling errors.. i only get 
3 warnings. here comes the first question, i got only warning no 
errors.. so my dsdt is ok or the cause i cant read my battery is those 3 
warnings?

i tryed to fix this out, i fix the first, but not the last 2.

first warning:
dsdt.dsl   245:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value (_WAK)

i fix this adding this line at the end of the involved method
Return(Package(0x02){0x00, 0x00})
just before the last }

the others to warning are on the same line:
dsdt.dsl  4508:                         Method (_STA, 0, NotSerialized)
Warning  2019 -                                    ^ Not all control 
paths return a value (_STA)

dsdt.dsl  4508:                         Method (_STA, 0, NotSerialized)
Warning  2026 -                                    ^ Reserved method 
must return a value (_STA)

this is a big if statment with an else Return (0x08)

i just remove the last else return and i left only the return...

now compiling error are 0. are those fixes correct?
and the most important thing, could those warnings be my problem... if 
not what should i check?



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
