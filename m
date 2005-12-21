From: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Subject: Toshiba Satellite P10
Date: Wed, 21 Dec 2005 08:43:25 +0200
Message-ID: <43A8F98D.3000704@csstirisano.co.za>
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

Hello all,

I'm having some trouble with suspend/resume on my Toshiba Satellite P10 
and was wondering whether anybody would be able to assist.

The omnibook module makes some functionality (like the multimedia keys, 
temperature readings, LCD and FAN adjustments) available.  It however 
does not help with suspend/resume at all.

It seems like the notebook only supports standby and suspend to ram.  It 
seems to come out of standby almost immediately and never come out of 
suspend to ram.  Running hibernate-ram -n works fine, but when running 
it without -n it actually suspends to RAM, hdd spins down, network goes 
down, CPU fans stop and the power led turns red (instead of the normal 
blue - this is in accordance with what I've seen with Windows).

When it's time again to resume however, it just does nothing and I need 
to power-cycle the machine to get it usable again.

I've proceeded to make a copy of /proc/acpi/dsdt into ~/dsdt.dat and 
decompiled that using iasl.  Upon recompiling (without making 
modifications) this rendered 17 errors and 3 warnings.  One of the 
warnings being about _WAK not returning a value - which I've changed to 
always return a packet containing two zeroes (not a fix but rather a 
workaround).  There were also some access errors where changing AnyAcc 
to ByteAcc solved 3 of the errors.

I unfortunately have no idea how to solve the other errors, most of 
which are 'Error 1094 - Missing ResourceSource string (required)'.  I've 
read somewhere that these strings are in fact optional.  Is this a bug 
in the iasl compiler?  An example of such a block:

DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, 
NonCacheable, ReadWrite,
     0x00000000, // Address Space Granularity
     0x000A0000, // Address Range Minimum
     0x000BFFFF, // Address Range Maximum
     0x00000000, // Address Translation Offset
     0x00020000, 0x00,,
     , AddressRangeMemory, TypeStatic)

This is inside a block '
Name (RSRC, ResourceTemplate ()
{
... many of the above blocks here
})

I suspect this is resource specifications, in this particular case, the 
VGA BIOS video memory used by vesa if I'm not mistaken.

The other error that I receive is 'Error 1013 - Method local variable is 
not initialized (Local1)'.  In this case I guess I can just initialize 
it to 0 and get it over with?

There are also two warnings 'Warning 2019 - Not all control paths return 
a value' for methods SLLB and PBGU.  Looking at these methods they 
indeed look dodgy.  The SLLB function looks like:

Method (SLLB, 1, NotSerialized)
{
     Store (Arg0, Local0)
     And (Local0, 0xFF, Local0)
     If (LLess (Arg0, 0x0100))
     {
         Return (Z00B)
     }
     Else
     {
         Store (Local0, Z00B)
     }
}

This means that when SLLB gets called with an argument less that 0x0100 
then a value will be returned, but if not we store the value passed in 
the argument anded with 0xFF.  For optimization - shouldn't this 
calculation be moved into the Else part, also, should both cases return 
Z00B, in which case the If can be rewritten to a > 0xFF and both Stores 
and the And inside that with the Return after the If.

The second case is less clear:

Method (PBGU, 1, NotSerialized)
{
     If (LEqual (Arg0, 0x00))
     {
         Return (BGU1)
     }

     If (LEqual (Arg0, 0x01))
     {
         Return (Z00C)
     }

     If (LEqual (Arg0, 0x02))
     {
         Store (0x00, ZOOC)
         Return (Z00C)
     }
}

This case is less clear.  If we can assume that values will always be in 
the range [0-2] then it's possible to simply remove the last If 
statement and just put it's contents there.

Any and all advice appreciated.  I could not locate these methods in the 
ACPI spec so I'm suspecting that they are being used internally and does 
not form part of the ACPI spec.

Thank,

-- 
Jaco Kroon
Support Engineer
CSS TIRISANO
Computer Systems (Pty) Ltd
Tel:   +27 12 621 3171
Fax:   +27 12 661 4984
Cell:  +27 84 515 8255

Notice: This message and any attachments are confidential and intended 
solely for the addressee. If you have received this message in error, 
please notify the sender by email or by phone to the listed number. Any 
unauthorised use, alteration or dissemination is prohibited. CSS 
Tirisano (Pty) Ltd accepts no liability for any direct, indirect or 
consequential loss or damages, arising from the contents of this message.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
