From: Jonas Petersson <zap-7RBX4Gk6oWI@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Tue, 03 Feb 2004 10:42:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401F6CED.60703@xms.se>
References: <3ACA40606221794F80A5670F0AF15F8401CBB678@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB678-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, luca-wlebWZzHoyE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Yu, Luming wrote:
>>I also seem to have occasional PCMCIA+fan collisions on my 
>>ASUS L5800C,
>>(mentioned earlier on this list) but I don't really thing that is
>>related, but some things certainly more or less woo-doo... ;-)
> 
> Could you please redescribe that issue. Maybe bugzilla.kernel.org
> is a good place for bug-report.

I have included the description below. I'll be happy to file it on
bugzilla, but I was a bit reluctant as I have to admit that I am no
longer bleading edge (this is my "real work" system and I sorely need
swsusp2 working under 2.6.x before I upgrade). I *WILL* experiment if
anyone has any specific ideas on how to get this to work, but I don't
really expect to NEED the GSM card until late spring - and I expect to
go 2.6.x before then.

[ Original description follows: ]

I've encountered a problem which I *THINK* i ACPI related, but I've not
enough ACPI experience to understand how to get around it. Any hint
appreciated.

I'll file it as a proper kernel bug if you think it more appropriate.
Here is a quick rundown of what I've found out:

* My base installation is described pretty detailed here:
http://www.xms.se/~zap/linux/asusl5800c.html
As you can see it has worked pretty well for quite some time and hence
my kernel etc is not quite bleading edge anymore (though I follow Debian
testing for everyting else).

* $ cat /proc/acpi/info
version:                 20030813
states:                  S0 S1 S3 S4 (swsusp) S5

The problem I've encountered lately is related to using a Nokia
CardPhone in my PCMCIA slot. Several other cards have work OKish - at
worst, an ethernet card wouldn't work at all (forgot the name, but it
was multifunction and was iffy anyway) and in one case a wavelan card
(orinoco) would only work in the upper slot. This is significantly worse:

Initially I just plugged it in without a SIM card and got some "Resource
unavailable" problems - fiddling with the /etc/pcmcia/config-2.4 file
appeared to help, though it was somewhat odd that specifying low IRQs
(say 4,5,6) still reported 10 or 11 in dmesg, but at least it appeared
to work.

I now also tried with a SIM card in place and noticed that the FAN would
stop a short while after inserting the card (I can hear the GSM
negotiations as noises in the speakers) when some IRQs where used
and then I had messages such as these in dmesg:


ttyS17 at port 0x0100 (irq = 11) is a 16550A
Trying to free nonexistent resource <00000100-00000107>
Trying to free nonexistent resource <00000100-00000107>
   ACPI-1121: *** Error: Method execution failed [\_TZ_.FAN0._INI]
(Node dffe9520), AE_AML_PACKAGE_LIMIT
   ACPI-1121: *** Error: Method execution failed [\_GPE._L16] (Node
dffe28a0),
AE_AML_PACKAGE_LIMIT
   ACPI-0297: *** Error: AE_AML_PACKAGE_LIMIT while evaluating method
[_L16] for GPE[ 0]
   ACPI-1121: *** Error: Method execution failed [\_TZ_.FAN0._INI]
(Node dffe9520), AE_AML_PACKAGE_LIMIT
   ACPI-1121: *** Error: Method execution failed [\_GPE._L16] (Node
dffe28a0),
AE_AML_PACKAGE_LIMIT
   ACPI-0297: *** Error: AE_AML_PACKAGE_LIMIT while evaluating method
[_L16] for GPE[ 0]
ttyS17 unloaded

Unplugging the card before the temperature gets too high seems to help
as the fan restarts typically after less than a minute.

I then tried acpidump and alltough I don't really understand all of it,
it sure hinted that an _INI method for FAN0 which may be called from
_L16 within the _GPE scope, but I can't really see how this should
suddenly stop working when I plug that particular card in.

Still, some combos of IRQs and port selections appeared to work at the
time and I would be able dial up using minicom and/or kppp.

At this stage I realized that debian demends that I'm part of the dip
group and for sanity reasons I decided to logout and reboot to make
sure everything was in a sane state - apparently it wasn't:

kppp will now sort of seem to work and the fan will run OK, but after a
minute or so the system will suddenly go wild:

- In one case, X died and I could only type (but got no response) in the
old X vt.
- In another case, X again died and a few messages flashed past too
quickly to read and then it was powered off.
- In a third case, a lot of info flashed past in an Oops dump (sorry,
wan't able to catch it).

To me it seems to be some kind of ACPI/PCMICA clash, but I have no clue
how to solve it. I had intended to wait for a couple of more weeks
before going 2.6.x as swsusp is somewhat critical to my daily work and
it seems not quite stable for 2.6 yet (considering even Nigel himself
runs 2.4 for development...)

Here's a bit more info:

$ cat /proc/interrupts
           CPU0
  0:     146428          XT-PIC  timer
  1:       3762          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:         76          XT-PIC  acpi
 10:      42212          XT-PIC  SiS 7012, ehci_hcd, usb-ohci, usb-ohci,
PCI device 1524:1421 (ENE Technology Inc), bcmwl5driverloader
 11:      85553          XT-PIC  usb-ohci, PCI device 1524:1421 (ENE
Technology Inc), radeon-D5X1nVylZaA@public.gmane.org:1:0:0
 12:     129940          XT-PIC  PS/2 Mouse
 14:          0          XT-PIC  ide0
 15:      17397          XT-PIC  ide1
NMI:          0
LOC:     146116
ERR:          1
MIS:          0

I've not attached the dmi and acpi dumps as I suspect there is a size
limit to this list, but I'll gladly mail that (and any other
information) to anyone who is interested.

		Any hint appreciated / Jonas

-- 
Jonas Petersson  |  XMS Penvision  |  mailto:Jonas.Petersson-7RBX4Gk6oWI@public.gmane.org
Box 3294, Västgötegatan 13, S-600 03 Norrköping | http://www.xms.se/
Tel: +46 11 400 13 00 | Dir: +46 11 400 13 05 | Fax: +46 11 10 30 50



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
