From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: ASUS M2400N / M3700N / S1300N temperature
Date: Thu, 14 Aug 2003 00:46:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030813224646.GA3838@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
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
List-Id: linux-acpi@vger.kernel.org

Hi there,
Could all the people having ASUS Centrino notebooks and problems with
thermal_zone/*/temperature always reporting 60 degrees try the following:

Find the following piece of code in your DSDT:
#v+
    Method (RTMP, 0, NotSerialized)
    {
        Store (RBYT (TSAD, 0x01), Local0)
        If (Not (Local0))
        {
            Store (Local0, LTMP)
        }

        Return (LTMP)
    }
#v-

And change the fourth line to If (Local0)?
Provided that I understand it correctly, and that the original call to EC
is correct, this should fix the temperature readings and the fan control (at
least partially -- it should now properly react to temperature changes). Of
course, it's late, I'm tired and I may be completely wrong.

(this really reminds me that I should subscribe to acpi-support, as
interesting threads appear there)

The reason I'm writing this here, is that *if* I'm right, and the original
piece of code really is completely bogus, then it would seem a really
strange practice and possibly a sad precedent of some weird DSDT crippling.
This code (and some other pieces, like display switching code, which is
surrounded by If (\NATK()), where \NATK() unconditionally evaluates to 0)
clearly can't work, but the fact is, it does under Windows. My question is:
is it possible / a common practice under Windows to override DSDTs? Or is
that another bug in the MSFT ASL compiler?

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
