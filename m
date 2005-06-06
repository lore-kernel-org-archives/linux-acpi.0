From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Kernel oops with asus_acpi module
Date: Mon, 6 Jun 2005 23:32:48 +0200
Message-ID: <20050606213248.GA22238@hell.org.pl>
References: <200506052340.41074.mail@hboeck.de> <200506061929.24663.mail@hboeck.de> <20050606114531.763eec37.rdunlap@xenotime.net> <200506062050.42632.mail@hboeck.de> <20050606135459.7ad699ae.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050606135459.7ad699ae.rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Cc: randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote randy_dunlap:
> OK, I see that part.
> 
> I'm including a patch for you to try.  Can you apply and test it
> and report back on it, please?

May I see the DSDT? The Samsung P30 INIT method referenced in
asus_hotk_get_info() is not supposed to return anything, not even an empty
string. I believe the new ACPICA implicit return might be interfering. 
Here's the relevant part of what I based the code on:

Method (INIT, 1, NotSerialized)
{
    Store (One, ATKP)
    If (LNot (LLess (PCBV, 0x02)))
    {
        If (And (WBTF, 0x1F))
        {
            Or (WBTF, 0x20, WBTF)
        }

        And (WBTF, 0xE0, WBTF)
    }

    If (And (WBTF, 0x40))
    {
        If (And (WBTF, 0xBF))
        {
            WLED (0x81)
        }
        Else
        {
            WLED (0x80)
        }
    }
    Else
    {
        WLED (0x80)
    }
}

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
