From: Gertjan Hofman <gertjan-nuBT7F/NYkeO3qShyYWIeA@public.gmane.org>
Subject: No S3/S4 response on Toshiba A70 (FC3)
Date: Wed, 9 Feb 2005 21:41:08 -0800 (PST)
Message-ID: <Pine.LNX.4.33.0502092114410.8615-100000@koslx1.triumf.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi All,

I fear this message is going to sound like one of those 'my mouse doesnt
work, please help' message, but I lack the expertise on ACPI to
solve this one myself.

In brief: I have a fairly new (Nov'04) Toshiba Satellite A70. Phoenix
Bios.  Getting 'sleep' (or hibernate) to work is for me one the most
crucial aspects of owning a lap top. I have had Linux suspend working on
my old Gateway Solo since RH6.2 (when windoze didnt). But this laptop
refuses to do anything.

Bunch more facts: I run FC3, kernel 2.6.10-1.741_FC3smp. I have also
compiled 2.6.10 kernel by hand, but with the same lack of results. Some
ACPI functions are ok - batery power indication, and 'power-button'
produces a normal shutdown -now. CPU throttling seems to work. Thermal
info doesnt.

commands like:  acpitools -s or (-S) dont seem to do anything. Using KDE
tools (Klaptop) does nothing. cat S3 >/proc/acpi/sleep does nothing. No
log file messages or anything.

Lsmod shows
button                 10577  0
battery                13253  0
ac                      8773  0

dmesg | grep ACPI show promising line like:
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI wakeup devices:
ACPI: (supports S0 S3 S4 S5)

(complete file on web link)


My question is, how do I check why there is no reaction to these sleep
commands. I have included of debug/info files here at the bottom, but they
also available via this link:

dmesg -s40000 is http://koslx1.triumf.ca/gertjan/acpi/dmesg_40000.txt
lspc -vv      is http://koslx1.triumf.ca/gertjan/acpi/lspci.txt
acpidmp       is http://koslx1.triumf.ca/gertjan/acpi/acpidmp.txt
proc/irq      is http://koslx1.triumf.ca/gertjan/acpi/proc_irq.txt
dmesg| grep ACPI http://koslx1.triumf.ca/gertjan/acpi/dmesg_grep_acpi.txt

Any help on how to investigate this further is much appreciated. ACPI
makes all the difference...

Thanks

Gertjan







-- 
//////////////////////////////////////////////////////////////////////////
work    :   604-982-3574
E-mai l :   gertjan-K9O0zq5Arhf3fQ9qLvQP4Q@public.gmane.org
web     :   http://koslx1.triumf.ca/gertjan
//////////////////////////////////////////////////////////////////////////




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
