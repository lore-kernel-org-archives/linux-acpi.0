From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Eternal S3 and \_WAK method
Date: Mon, 17 Mar 2003 22:38:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317213843.GA28129@hell.org.pl>
References: <20030317184143.GA31878@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030317184143.GA31878-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Charl P. Botha:
> Dear list (and ACPI gurus),
> 
> Could it be that the fact that my \_WAK method returns no value is
> preventing my system waking up from S3?  I can get it into S3, but I can
> never get it out... no amount of button pushing, mouse moving or shouting
> seems to help: that durn suspend-led just continues flashing.

If that's of any interest, my _WAK does not return any value, yet I'm able
to suspend and resume. Here is how it looks:
#v+
    Method (\_WAK, 1, NotSerialized)
    {
        ISMI (0x3C)
        ISMI (0x3F)
        SSLP (0x00)
        Store (\PMES, \_GPE.PMEW)
        If (LLess (Arg0, 0x04))
        {
            \_SB.PCI0.PX40.SLMT ()
        }

        Store (0xFF, DBG1)
        If (LEqual (Arg0, 0x03))
        {
            If (LEqual (OSFG, OS98))
            {
                \_SB.PCI0.USB0.RSTA ()
                \_SB.PCI0.USB1.RSTA ()
            }
        }

        Notify (\_SB.PCI0.USB0, 0x00)
        Notify (\_SB.PCI0.USB1, 0x00)
        If (LNot (LEqual (\RTCS, 0x01)))
        {
            Notify (\_SB.SLPB, 0x02)
            Store (0x00, \RTCS)
        }

        If (LLess (Arg0, 0x04))
        {
            Notify (\_TZ.THRM, 0x80)
        }

        If (LEqual (\OSFG, \OSXP))
        {
            If (LLess (Arg0, 0x04))
            {
                Notify (\_SB.BAT0, 0x80)
                Notify (\_SB.BAT0, 0x81)
                Notify (\_SB.ACAD, 0x80)
            }
        }
    }
#v-

What is interesting, is that it seems that my system notifies the _SB.ACAD
when resuming (AFAIR it had something to do with the display), when the OS
string is equal to "Microsoft Windows XP". I'll have to try to change mine,
and see what happens.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
