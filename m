From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Strange interpreter behaviour
Date: Tue, 17 Jan 2006 11:30:43 +0100
Message-ID: <20060117103043.GA2154@poupinou.org>
References: <43BFF7DE.1000909@tzi.de> <20060116171932.GF25115@poupinou.org> <43CC0FC0.9090806@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43CC0FC0.9090806-cGBD8117FJM@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 16, 2006 at 10:27:28PM +0100, Janosch Machowinski wrote:
> >Sound like \_SB.INV7 is a bit into a GPIO.
> >More, the associated OR is defined like that:
> >	OperationRegion (GPIO, SystemIO, IO2B, 0x40) 
> >
> >Note that IO2B is given here:
> >    OperationRegion (BIOS, SystemMemory, 0x1FF50064, 0xFF)
> >    Field (BIOS, ByteAcc, NoLock, Preserve)
> >    {
> >        SS1,    1,
> >        SS2,    1,
> >        SS3,    1,
> >        SS4,    1,
> >        Offset (0x01),
> >        IOST,   16,
> >        SPIO,   16,
> >        PMBS,   16,
> >        PMLN,   8,
> >        SMBS,   16,
> >        SMLN,   8,
> >        IO1B,   16,
> >        IO1L,   8,
> >        IO2B,   16,
> >        IO2L,   8,
> >        TOPM,   32,
> >        ROMS,   32,
> >
> >Therefore one think to check is that IO2B is set correctly to point to
> >the GPIO's, then look if the GPIO is configured as a GPO (not as a GPI).
> >
> >For checking if IO2B is correct:
> >sudo dd if=/dev/mem bs=1c skip=536150130 count=2 | hexdump
> >
> Here it get's strange :
> scotchmobil scotch # dd if=/dev/mem bs=1c skip=536150130 count=2
> dd: reading `/dev/mem': Bad address
> 0+0 records in
> 0+0 records out

There is physical 512Mo RAM, isn't there? Or the DSDT have been
overriden?
How about a 'cat /proc/iomem'?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
