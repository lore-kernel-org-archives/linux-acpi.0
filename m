From: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Subject: another issue with presario 900 - conflicting FF and CM declarations of power and sleep buttons
Date: Wed, 24 Sep 2003 07:51:55 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309240751.55097.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linuxpresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

here is the other problem with my presario 900 :

if I read ACPI spec correctly, sleep & power buttons may either be 
declared as FF or CM not both, but looks like this is just what is 
happening here: both PWR_BUTTON and SLEEP_BUTTON bits in FADT are 
unset which is supposed to mean that they are to be treated as FF, 
however in dsdt the buttons are declared as well:

    Scope (_SB)
    {
        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Name (_PRW, Package (0x02)
            {
                0x01,
                0x03
            })
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x01,
                0x04
            })
        }

and there is an EC event which is indeed being invoked when sleep 
button is pressed:

		Method (_Q0B, 0, NotSerialized)
                    {
                        Store ("Sleep btn runtime event", Debug)
                        Notify (\_SB.SLPB, 0x80)
                    }

Linux ACPI code looks at FADT bits first and ignores contradicting AML 
afterwards, so both buttons show up as FF.
Power button seems to indeed work correctly (besides the double event 
issue I mentioned before), however it seems that sleep button should 
really be CM and FADT is wrong here. To veryfy that I commnted out 
these lines in drivers/acpi/bus.c in method acpi_bus_scan_fixed:

	if (acpi_fadt.sleep_button == 0)
                result = acpi_bus_add(&device, acpi_root,
                        NULL, ACPI_BUS_TYPE_SLEEP_BUTTON);

to force it to ignore FF sleep button altogather, so now sleep button 
shows up as CM and works correctly - I get the events.

So I am interested in hearing what is the best way to fix this problem 
"correctly" - overriding FADT in a way similar to DSDT or something 
better?

Thanks

Fedor



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
