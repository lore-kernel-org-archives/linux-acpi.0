From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: RE: preparing toshiba_acpi driver release
Date: Tue, 27 Jan 2004 09:54:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040127085433.GA30693@message-id.gmane0305.slipkontur.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A54@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A54-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
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

On Mon, Jan 26, 2004 at 02:29:02PM -0500, Brown, Len wrote:

> probably brightness control has some power savings benefits too -- maybe
> somebody on the list has numbers for screen power consumption?

my Asus L2400D with cpufrequency down to 500 MHz, machine is idle (but
connected to USB keyboard/mouse and network).

max. brightness (level 15):
charging state:          discharging
present rate:            677 mA

min. brightness (level 1, there is also 0 but then i can't read anything :-)
charging state:          discharging
present rate:            557 mA

medium brightness (level 7, this is actually useable)
charging state:          discharging
present rate:            597 mA

and just for the record: maximum brightness and cpufreq to 1200 MHz:
charging state:          discharging
present rate:            1437 mA

This is no scientific measurement since the machine is not really idle (i'm
writing this mail now :-) and the battery is a blatant liar (if the machine
would draw as little current as /proc/acpi/.../state tells me, it would have
to last twice as long, but it doesnt. So either it lies about capacity or
about current), but it is something to compare.
And yes, when i'm on the road, i always turn down the display as much as
possible to save battery.

I also made the test with an IBM T23 or something like that about a year ago
with Win2k which gave me even bigger savings from the display backlight
(IIRC about 1400 mA with full brightness and 900 mA with minimal).

-- 
Stefan Seyfried



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
