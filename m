From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Wed, 21 Sep 2005 15:39:53 +0200
Message-ID: <1127309993.26683.15.camel@f100.suse.de>
References: <20050618004506.GE3690@orest.greek0.net>
	 <42C2BA01.2060806@gmx.net> <20050629155015.GB14659@hell.org.pl>
	 <200508191749.18016.mail@hboeck.de> <1124634977.4952.9.camel@nouse.net>
	 <20050921090810.GS22403@orest.greek0.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050921090810.GS22403-eJYrgmUciHpxYM3rXe3Iuw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Hanno =?ISO-8859-1?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Wed, 2005-09-21 at 11:08 +0200, Christian Aichinger wrote:

> OK, it's getting a little frustrating that this still isn't fixed.
> I've now written a patch that tests for ACPI_TYPE_INTEGER, and it
> tests for possible return values from P35's INIT.
> 
> Since the relevant part hasn't changed between P30 -> P35's DSDT, I
> assume that there has been some change in the Linux ACPI code, that
> causes integer returns now instead of no returns. This means we
> could get rid of the P30 code in the (!buffer.pointer) path. I don't
> have a P30 around to test this though :-/
> 
> I got the -1/0x58/0x38 values from my DSDT:
> INIT there calls WLED, which calls \_SB.PCI0.LPCB.EC0.STC5, last
> call with arg 0x58 or 0x38. That function then returns with either
> Ones (which I gathered is ~0, i.e. -1) or with Arg0. That's the last
> return that happens within the INIT call, so I thought that might be
> the result of the call as a whole.
> 
> That fits nicely, since 0x58 is really returned on my laptop.
> 
> If this fix still breaks other laptops I'd really be puzzled, since
> currently the value is dereferenced later when doing the string
> comparisons. So the patch at least shouldn't break it more than it
> already is ;)

I can confirm that your patch works fine for the W5A which previously
needed the mentioned workaround.  But this single case of success should
not be taken as proof.  More testing would be reasonable.

[...]

See you,

   Timo



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
