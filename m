From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: smartbattery support
Date: Mon, 11 Oct 2004 19:36:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <416AD2B3.9050403@mega.ist.utl.pt>
References: <16A54BF5D6E14E4D916CE26C9AD30575457124@pdsmsx402.ccr.corp.intel.com> <4166EC29.8070006@mega.ist.utl.pt> <20041011094935.GA23992@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041011094935.GA23992-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>>my acer travelmate 4001WLmi looks like this:
>>
>>Device (SMBC)
>>                    {
>>                        Name (_HID, "ACPI0001")
>>                        Name (_EC, 0x1820)
>>                        Device (SBS0)
>>                        {
>>                            Name (_HID, "ACPI0002")
>>                            Name (_SBS, 0x02)
>>                        }
>>                    }
>>
> 
> 
> This mean that you have a SMB-HC with adress 0x18 and query 0x20.
> You may try i2c-acpi-ec, but you have to change:
> #define SMBUS_ADDRESS_TO_HAVE 0x60
> to 
> #define SMBUS_ADDRESS_TO_HAVE 0x18
> Also, you need to get at least i2c-core in your kernel for this to work.
> 
> Note that this code have 2 years... and if there is more than one EC in
> your system, this may not work.  In that case, could you please send me
> a dump of the acpi tables?
> btw, there is two batteries, because 'Name (_SBS, 0x02)'.

hello bruno,

i have been reading the acpi specification, but that information you 
gave me has worth many hours of searching.

i have successfully insmod'ed and i have some results:

archon i2c-acpi-ec # i2cdetect
Error: No i2c-bus specified!
Syntax: i2cdetect [-f] [-q|-r] I2CBUS [FIRST LAST]
   I2CBUS is an integer
   With -f, scans all addresses (NOT RECOMMENDED)
   With -q, uses only quick write commands for probing (NOT RECOMMENDED)
   With -r, uses only read byte commands for probing (NOT RECOMMENDED)
   If provided, FIRST and LAST limit the probing range.
   i2cdetect -l lists installed busses only
   Installed I2C busses:
     i2c-4       unknown         ACPI EC SMBus 2.0 adapter at 0018 
  Algorithm unavailable
     i2c-3       unknown         crt2 
  Algorithm unavailable
     i2c-2       unknown         vga 
  Algorithm unavailable
     i2c-1       unknown         dvi 
  Algorithm unavailable
     i2c-0       unknown         monid 
  Algorithm unavailable
archon i2c-acpi-ec # i2cdetect 4
   WARNING! This program can confuse your I2C bus, cause data loss and 
worse!
   I will probe file /dev/i2c-4.
   I will probe address range 0x03-0x77.
   You have five seconds to reconsider and press CTRL-C!

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX 4c XX XX XX
50: 50 51 52 53 XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
archon i2c-acpi-ec #

so some devices were detected at the bus address 0x18.

i'll dig in the code/documentation to try and auto-detect the smbus 
address first, while learning a bit more acpi.

thanks for the useful information.

why did you stop developing the module?

regards,
pedro venda.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
