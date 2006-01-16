From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Strange interpreter behaviour
Date: Mon, 16 Jan 2006 18:19:32 +0100
Message-ID: <20060116171932.GF25115@poupinou.org>
References: <43BFF7DE.1000909@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43BFF7DE.1000909-cGBD8117FJM@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 07, 2006 at 06:18:22PM +0100, Janosch Machowinski wrote:
> Hey,
> I got an ASUS M6, which contains some strange _CST related ASL code.
> In the _CST method there is a check, if \_SB.INV7 is set :
>                 If (\_SB.INV7)
>                 {
>                     Return (NOC3)
>                 }
> This seems to always return true. There is also the method \_GPE:_L17 
> which just inverts \_SB.INV7 and sends a signal to refetch the CST Object :
>           Method (_L17, 0, NotSerialized)
>         {
>             If (\_SB.INV7)
>             {
>                 Store (0x00, \_SB.INV7)
>             }
>             Else
>             {
>                 Store (0x01, \_SB.INV7)
>             }
> 
>             Notify (\_PR.CPU1, 0x81)
>         }
> 
> Now I called the _L17 method manually :
> echo "0:\\_GPE:_L17:\\_GPE:_L17:10001:1" > /proc/acpi/hotkey/poll_config
> echo "10001:0:1:0" > /proc/acpi/hotkey/action
> 
> What I noticed is that every time I call the action, my C-State usage 
> counter gets reset to zero. From that behaviour I would follow, that the 
> L17 method was executed and the CST Object was refetched. So there seems 
> to be an error in setting the \_SB.INV7 bit/register/whatever. (I assume 
> 0 is false an 1 is true in ASL if-clauses ?)

Sound like \_SB.INV7 is a bit into a GPIO.
More, the associated OR is defined like that:
	OperationRegion (GPIO, SystemIO, IO2B, 0x40) 

Note that IO2B is given here:
    OperationRegion (BIOS, SystemMemory, 0x1FF50064, 0xFF)
    Field (BIOS, ByteAcc, NoLock, Preserve)
    {
        SS1,    1,
        SS2,    1,
        SS3,    1,
        SS4,    1,
        Offset (0x01),
        IOST,   16,
        SPIO,   16,
        PMBS,   16,
        PMLN,   8,
        SMBS,   16,
        SMLN,   8,
        IO1B,   16,
        IO1L,   8,
        IO2B,   16,
        IO2L,   8,
        TOPM,   32,
        ROMS,   32,

Therefore one think to check is that IO2B is set correctly to point to
the GPIO's, then look if the GPIO is configured as a GPO (not as a GPI).

For checking if IO2B is correct:
sudo dd if=/dev/mem bs=1c skip=536150130 count=2 | hexdump

./acpixtract FACP < acpidump.out | ./acpitbl

where acpidump.txt is the output from ./acpidump.  I assume you know
what I'm talking about reading the bugzilla report, or else do something
like that:

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20050926.tar.bz2
tar xjvfp pmtools-20050926.tar.bz2
cd pmtools
make
cd acpidump
sudo ./acpidmp > acpidmp.out

I think the value given by the 'sudo dd' above should correspond to the
GPE0_BLK: field from the ./acpitbl above.

For checking if the register where the INV7 is defined is configured as
a GPO, well I have to know the ouput from 'lspci -v -xxx -s"the southbridge"'

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
