From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Report Toshiba Satellite300-214
Date: Mon, 3 Mar 2003 20:32:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030303193212.GZ3918@poup.poupinou.org>
References: <microsoft-free.m3k7fg49lq.fsf@grisu.schuckeduster.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <microsoft-free.m3k7fg49lq.fsf-NYHFM3qjxh+4Q6RjEJEvzQmWJwt+BgR4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Kosch <t.kosch-FfjHXTYIe3sI54nVjq4dGti2O/JbrIOy@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 03, 2003 at 06:56:49PM +0100, Thomas Kosch wrote:
> Hi,
> i wuold like to give you an report for my satellite3000-214. I use the
> latest patch with Brunos dsdt, SuSEs TIOCGDEV-patch, packet writing
> patch and SuSEs boot-splash patch.
> 
> First, it works great. Second, the report.
> 
> ,----
> | ACPI: Battery Slot [BAT1] (battery present)
> | ACPI: Battery Slot [BAT2] (battery present)
> `----
> 
> ? I have only one battery.

I will correct this trouble (it is a DSDT trouble, actually).

> 
> ,----
> | ACPI: Power Button (FF) [PWRF]
> | ACPI: Lid Switch [LID]
> | ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states)
> | ACPI: Thermal Zone [THM0] (44 C)
> `----
> 
> Sometimes i get an
> ,----
> | Mar  3 14:52:18 gryffindor kernel:     ACPI-0322: *** Error: Handler for
> |      [embedded_control] returned AE_TIME 
> | Mar  3 14:52:18 gryffindor kernel:     ACPI-1102: *** Error: Method
> |      execution failed [\_SB_.PCI0.LPCB.THM0._TMP] (Node c12d02c0), AE_TIME 
> `----
> or
> ,----
> | Mar  2 02:24:22 gryffindor kernel:     ACPI-0322: *** Error: Handler for
> |      [embedded_control] returned AE_TIME 
> | Mar  2 02:24:22 gryffindor kernel:     ACPI-1102: *** Error: Method
> |      execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c12d1f60), AE_TIME
> `----

Don't know.  Will look.

> 
> The S1 sleep works but i must reload the ide-scsi module, without the
> machine hangs on the first access.
> 
> The present rate is always 0.

I don't know how to resolv this issue in the DSDT part (and the
original one do not help either..)

> ,----
> | gryffindor:/proc/acpi # cat battery/BAT1/state
> | present:                 yes
> | capacity state:          ok
> | charging state:          discharging
> | present rate:            0 mA
> | remaining capacity:      2760 mAh
> | present voltage:         14800 mV
> | gryffindor:/proc/acpi #
> `----
> 
> The prozessor is alway in C2 state

No, or else you will lock for ever actually :)

> ,----
> | gryffindor:/proc/acpi # cat processor/CPU0/power
> | active state:            C2
> | default state:           C1
> | bus master activity:     ffffffff
> | states:
> |     C1:                  promotion[C2] demotion[--] latency[000] usage[00005860]
> |    *C2:                  promotion[C3] demotion[C1] latency[010] usage[00477940]
> |     C3:                  promotion[--] demotion[C2] latency[100] usage[00000000]
> | gryffindor:/proc/acpi #
> `----
> 
> Why is there no throttling support?

The i830 has know issue for throttling.  Those it was disabled
by the OEM.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
