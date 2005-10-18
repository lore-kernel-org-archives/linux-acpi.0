From: Nils Rimestad <nils-LgQBqAA7lunk1uMJSBkQmQ@public.gmane.org>
Subject: Acer 3222 acpi
Date: Wed, 19 Oct 2005 00:00:40 +0200
Message-ID: <43557088.7010907@rimestad.net>
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

Hello

This is first time i try to work with acpi on a linux box,
now i like a challenge, but this is a bit on the top side of what i can 
handle.
I managed to decompile the dsdt and have gotten following error when 
trying to compile again.

dsdt.dsl  2352:                     If (ECOK)
Error    1065 -                            ^ Object not accessible from 
this scope (ECOK)

ASL Input:  dsdt.dsl - 6794 lines, 241739 bytes, 2957 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 738 Optimizations

the code it is telling me it has a fault in this:
                Method (_EJ0, 1, NotSerialized)
                {
                    Store (0x00, \_SB.PCI0.RP01.Z001)
                    Store (0x00, \_SB.PCI0.LPCB.SIO.SIOS)
                    \_SB.GSMI (0x14)
                    If (ECOK)   ##This is the line where it tells me 
there is an error.
                    {
                        Store (0x01, \_SB.PCI0.LPCB.EC0.OSUD)
                    }
                }

following if located a bit lower in the file, i guess this is the one it 
should call, though im not sure.
                Method (ECOK, 0, NotSerialized)
                {
                    If (LEqual (\_SB.PCI0.LPCB.EC0.OKEC, 0x01))
                    {
                        Return (0x01)
                    }
                    Else
                    {
                        Return (0x00)
                    }
                }


but now i feel kinda stranded, i can't realy figure out what to do next. 
and that is why i ask here.
Is there an easy thing that i can try? or should i post the full file 
and just sit back and let you guys have a look?

Thanks in advance
Nils Rimestad


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
