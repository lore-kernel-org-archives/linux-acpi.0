From: Mathias Weyland <mweyland-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Subject: Re: first shoot for smartbattery (was Re: Re: i2c-acpi-ec.c)
Date: Sat, 1 Jan 2005 09:26:05 +0100
Message-ID: <20050101082605.GA24896@phys.ethz.ch>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041231181628.GL19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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

On Fri, Dec 31, 2004 at 07:16:28PM +0100, Bruno Ducrot wrote:

Hi

I managed to subscribe to the mailing list; thank you for CC-ing the whole
discussion to me.

> It's not yet really polished as I wanted, but well I don't have
> time to finish this due to, huh, ..., private stuff this night.

Heh.


> You can find this at http://www.poupinou.org/acpi/smartbatt/
> Take one of the smartbatt.tar.{gz,bz2} and follow the README after
> unpacking it, and hopefully a ./smartbatt will give you correct battery
> informations (who knows).

Ok, here's what's happening:

corcovado:/usr/src/smartbatt# ./smartbattery
Error: No i2c-bus specified!
Syntax: smartbatt I2CBUS
  Installed I2C busses:
    i2c-1       unknown         ACPI EC SMBus adapter at 0018
Algorithm unavailable
    i2c-0       unknown         SMBus I801 adapter at 1880
Algorithm unavailable
corcovado:/usr/src/smartbatt# ./smartbattery  1
current:       65535 mA
remain:        65535 mA or mWh
time to empty: 65535 minutes
time to full:  65535 minutes
temperature:   6280.5 C
voltage:       65535 mV

The values are wrong, but I guess you helped me a lot. I'll dive into the
code this afternoon and I'll try to nail down the problem. As for now, what
I can tell you is that the base address has been detected correctly. From my
dsdt.asl:

                    Device (SMBC)
                    {
                        Name (_HID, "ACPI0001")
                        Name (_EC, 0x1820)
                        Device (SBS0)
                        {
                            Name (_HID, "ACPI0002")
                            Name (_SBS, 0x01)
                        }
                    }


Loading the module shows:

i2c_acpi_ec: disagrees about version of symbol struct_module
base: 0x18    alert: 0x20
i2c-acpi-ec.c: ACPI EC SMBus adapter at 0x18

So at least that is working.

But something puzzeled me a bit:

corcovado:/home/lea# i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

At least the output differs from what Pedro (IIRC) got in October.

Regards & thank you very much for the effort!

Mathias


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
