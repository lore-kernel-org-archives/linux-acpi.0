From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: Gateway 200X (again) - No power button events
Date: Tue, 20 Jan 2004 10:57:10 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074614230.2740.10.camel@localhost>
References: <1074533658.11008.18.camel@localhost>
	 <1074541900.2813.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1074541900.2813.5.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

A little more info for the Gateway 200X power button issue. The
acpi_button_notify method is not even called for the power button (nor
is acpi_button_notify_fixed), so whatever is causing the events not to
be raised must be at a lower level than that. I'm still guessing that
it's a DSDT issue, but this at least rules out a bug in the
acpi_button_notify functions.

Greg



On Mon, 2004-01-19 at 14:51, Greg Sarjeant wrote:
> OK, I found the Notify call that I was looking for. It was in the
> EmbeddedControl region, and they don't specify the \_SB. prefix:
> 
>    Method (_Q50, 0, NotSerialized)
>    {
>        Notify (PWRB, 0x80)
>    }
> 
> So, it looks like it is specified in the DSDT. I'm not sure why I don't
> get an event when I press the button. I do get events from the sleep
> button, but the two are declared somewhat differently. Here they are for
> comparison:
> 
>         Device (SLPB)
>         {
>             Name (_HID, EisaId ("PNP0C0E"))
>             Method (_STA, 0, NotSerialized)
>             {
>                 Return (0x0F)
>             }
>         }
> 
>         Device (PWRB)
>         {
>             Name (_HID, EisaId ("PNP0C0C"))
>             Name (_PRW, Package (0x02)
>             {
>                 0x1D, 
>                 0x04
>             })
>         }
> 
> 
> Thanks again,
>   Greg
> 
> 
> On Mon, 2004-01-19 at 12:34, Greg Sarjeant wrote:
> > Hi,
> > 
> >     I have another question about my Gateway 200X. ACPI is working much
> > better now, but I just started playing with the power button, and it
> > turns out that I am not getting any events from it. I looked through the
> > DSDT, and could not find any Notify (\SW.PWRB, 0x80) statements for it,
> > so I imagine that that is the problem. Here (I think) are the relevant
> > DSDT sections:
> > 
> > 
> >     Scope (_GPE)
> >     {
> >         Method (_L05, 0, NotSerialized)
> >         {
> >             Notify (\_SB.PCI0.MODM, 0x02)
> >             Notify (\_SB.PWRB, 0x02)
> >         }
> > 
> >         Method (_L0B, 0, NotSerialized)
> >         {
> >             Notify (\_SB.PCI0.PCIB, 0x02)
> >             Notify (\_SB.PWRB, 0x02)
> >         }
> > 
> >         Method (_L1D, 0, NotSerialized)
> >         {
> >             Store (\_SB.PHS1 (0x8E, Zero), Local0)
> >             If (LEqual (Local0, One))
> >             {
> >                 Notify (\_SB.PWRB, 0x02)
> >             }
> > 
> >             If (LEqual (Local0, 0x02))
> >             {
> >                 Notify (\_SB.PWRB, 0x02)
> >             }
> >         }
> >     }
> > 
> > 
> >     Device (PWRB)
> >     {
> >         Name (_HID, EisaId ("PNP0C0C"))
> >         Name (_PRW, Package (0x02)
> >         {
> >             0x1D, 
> >             0x04
> >         })
> >     }
> > 
> > 
> > Do I have to add this Notify statement in the _GPE block? I'm also a bit
> > confused by the "Notify (\_SB.PWRB, 0x02)" lines. From the spec, I
> > thought that 0x80 and 0x200 were the expected values from Notify for the
> > power button. Am I missing something here?
> > 
> > Also, the BIOS does not supply an ECDT. I am using the patch at bug 1690
> > to get around this, could that be related? 
> > 
> > The power button does shut the macine down in Windows XP. I have tried
> > passing acpi_os_name="Microsoft Windows XP" to the kernel without
> > success. I did that because I noticed lines like this:
> > 
> >        If (LEqual (SizeOf (_OS), 0x14))
> > 
> > In the PCI0 device block after seeing the S3D method emails. I haven't
> > really had the chance to dig into what's going on there yet, so it was a
> > bit of a blind stab.
> > 
> > For reference, the complete DSDT is posted at
> > http://www.morningdave.org/acpi/dsdt.dsl
> > 
> > 
> > Thanks again for any help,
> > Greg
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > The SF.Net email is sponsored by EclipseCon 2004
> > Premiere Conference on Open Tools Development and Integration
> > See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> > http://www.eclipsecon.org/osdn
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > 
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
