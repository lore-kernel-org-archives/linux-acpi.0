From: SLIVER` <sliver-qqXEv8jiLWqhPH1hqNUYSQ@public.gmane.org>
Subject: RE: Problem with Compaq Evo N110
Date: Fri, 23 Aug 2002 18:35:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.2.20020823171551.00a25c50@pop.casa.mia>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B707@orsmsx107.jf.inte
 l.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19B707@orsmsx107.jf.inte
 l.com>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

First of all, thanks so much to everyone for your help... but unfortunately 
I have to trouble you again... :/

now ACPI is correctly loaded on (credo ke caricare sia load, specie in 
senso computeristico, non sono sicura se regga l'on) boot, but I can't say 
it is perfectly working... because acpi (client) doesn't find the batteries


dreams@norad:/proc/acpi/battery/BAT1$ acpi -V -s
      Thermal 1: ok, 50.0 degrees C
      AC Adapter 1: on-line
      Battery 1: slot empty <---------------------- ?!

I checked the acpi sorgent (non sicura se si dice sorgent) (acpi.c) and I 
noticed that:


    if (remaining_capacity < 0 || present_rate < 0 || design_capacity < 0 
|| !state) {
       if (show_empty_slots) {
              printf("%12s %d: slot empty\n", BATTERY_DESC, battery_num);
        }

What it happens is that a series of controls are made, basing on the file 
/proc/acpi/battery/BAT1/state
and it fails on one of these (precisely on present rate). so, if we look at 
that file:

dreams@norad:~$ cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            unknown    <-------------------- ?!
remaining capacity:      52428 mWh
present voltage:         11000 mV

I noticed that that value (number, dipende dal senso di valore) is definied 
by /usr/src/linux/drivers/acpibattery.c

         if (bst->present_rate == ACPI_BATTERY_VALUE_UNKNOWN)
                 p += sprintf(p, "present rate:            unknown\n");
         else
                 p += sprintf(p, "present rate:            %d %s\n", (u32) 
bst->present_rate, units);

I rekon it could be some addres problem, but because of my scarce 
programmation knowledges, I could say bullshit...

Grazie a tutti.
Thanks a lot to everybody

Luca Memini





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
