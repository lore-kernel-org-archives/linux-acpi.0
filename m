From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpid doesn't log all ACPI events
Date: 24 Aug 2004 16:33:46 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093379626.17222.283.camel@dhcppc4>
References: <B774920D825C2D4880A3C1B0D6EF941801CEEA87@ssdmx.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B774920D825C2D4880A3C1B0D6EF941801CEEA87-YbQoUGCEyAW+LrQOllSzDQC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Rockefeller, Harry" <harryr-UjZhlPPWhclBDgjK7y7TUQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-08-20 at 16:22, Rockefeller, Harry wrote:
> I am running acpi and kernel 2.6.8.1 and acpid version 1.0.3.
> 
> I get ACPI debug messages at the system terminal when I change
> my notebook power from AC to battery and vice versa, i.e.,
> 
> [ACPI Debug] String: Length 0x09, "AC Change".
> 
> Also /proc/acpi/ac_adapter/AC0/state reports the power change
> properly.
> 
> However, acpid never records ac_adapter events.
> 
> FWIW acpid does report all three button events:
> button/lid, button/power, and button/sleep.
> These also get logged to /var/log/acpid.
> 
> I don't know if the ac_adapter event ever reaches
> /proc/acpi/event.  If not, I would suspect this to be
> an ACPI bug.  If yes, then perhaps it's an acpid
> bug, i.e., not getting communicated to /var/log/acpid.
> 
> Can anyone explain what is going on?  I'll be happy to
> provide more information if needed.
> 
> Thanks.
> 

you mean your system doesn't do this?:

[root@toshiba root]# /etc/init.d/acpid stop
Stopping acpi daemon: [  OK  ]
[root@toshiba root]# cat /proc/acpi/event
battery BAT1 00000080 00000001
ac_adapter ADP1 00000080 00000000
processor CPU0 00000080 00000000
ac_adapter ADP1 00000080 00000001
processor CPU0 00000080 00000000
battery BAT1 00000080 00000001

root@toshiba root]# /etc/init.d/acpid start
Starting acpi daemon: [  OK  ]
[root@toshiba root]# tail /var/log/acpid
[Tue Aug 24 16:32:21 2004] received event "battery BAT1 00000080
00000001"
[Tue Aug 24 16:32:21 2004] completed event "battery BAT1 00000080
00000001"
[Tue Aug 24 16:32:37 2004] received event "battery BAT1 00000080
00000001"
[Tue Aug 24 16:32:37 2004] completed event "battery BAT1 00000080
00000001"
[Tue Aug 24 16:32:40 2004] received event "ac_adapter ADP1 00000080
00000000"
[Tue Aug 24 16:32:40 2004] completed event "ac_adapter ADP1 00000080
00000000"
[Tue Aug 24 16:32:40 2004] received event "processor CPU0 00000080
00000000"
[Tue Aug 24 16:32:40 2004] completed event "processor CPU0 00000080
00000000"
[Tue Aug 24 16:32:48 2004] received event "ac_adapter ADP1 00000080
00000001"
[Tue Aug 24 16:32:48 2004] completed event "ac_adapter ADP1 00000080
00000001"
[Tue Aug 24 16:32:48 2004] received event "processor CPU0 00000080
00000000"
[Tue Aug 24 16:32:48 2004] completed event "processor CPU0 00000080
00000000"
[Tue Aug 24 16:32:54 2004] received event "battery BAT1 00000080
00000001"
[Tue Aug 24 16:32:54 2004] completed event "battery BAT1 00000080
00000001"





-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
