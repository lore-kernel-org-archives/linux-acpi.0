From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Mon, 4 Apr 2005 17:34:23 +0800
Message-ID: <200504041734.23178.luming.yu@intel.com>
References: <200503291156.19112.rjw@sisk.pl> <200504011731.16467.luming.yu@intel.com> <200504011151.48468.rjw@sisk.pl>
Reply-To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504011151.48468.rjw-KKrjLPT3xs0@public.gmane.org>
Content-Disposition: inline
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
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Please testing patch filed at
http://bugzilla.kernel.org/show_bug.cgi?id=3D3851#c64
My testing results on toshiba satellite M20 is:

/proc/acpi/battery/BAT0#time cat state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            1500 mA
remaining capacity:      4064 mAh
present voltage:         15000 mV

real    0m0.023s
user    0m0.000s
sys     0m0.020s

Thanks
Luming

On Friday 01 April 2005 17:51, Rafael J. Wysocki wrote:
> On Friday, 1 of April 2005 11:31, Yu, Luming wrote:
>  > On Thursday 31 March 2005 16:44, Rafael J. Wysocki wrote:
>  > > Hi,
>  > >
>  > > On Wednesday, 30 of March 2005 12:05, Rafael J. Wysocki wrote:
>  > > > On Wednesday, 30 of March 2005 07:53, Yu, Luming wrote:
>  > > > > On Tuesday 29 March 2005 17:56, Rafael J. Wysocki wrote:
>  > > > > > Hi,
>  > > > > >
>  > > > > > There is a problem on my box (Asus L5D, x86-64 kernel) with the
>  > > > > > ACPI battery driver in the 2.6.12-rc1-mm[1-3] kernels.=A0 Name=
ly,
>  > > > > > the battery monitor that I use (the kpowersave applet from SUSE
>  > > > > > 9.2) is no longer able to report the battery status (ie how mu=
ch
>  > > > > > % it is loaded).=A0 It can only check if the AC power is conne=
cted
>  > > > > > (if it is connected, kpowersave behaves as though there was no
>  > > > > > battery in the box, and if it is not connected, kpowersave
>  > > > > > always shows that the battery is 1% loaded).
>  > > > > >
>  > > > > > Also, there are big latencies on loading and accessing the
>  > > > > > battery module, but the module loads successfully and there's
>  > > > > > nothing suspicious in dmesg.
>  > > > > >
>  > > > > > Please let me know if you need any additional information.
>  > > > > >
>  > > > > > Greets,
>  > > > > > Rafael
>  > > > >
>  > > > > Could you just revert ec-mode patch, then retest?
>  > > >
>  > > > Could you please point me to it?
>  > >
>  > > I assume you mean the "Enable EC Burst Mode" patch at:
>  > >
>  > > http://linux-acpi.bkbits.net:8080/to-akpm/cset%401.2181.17.12?nav=3D=
inde
>  > >x.htm l|ChangeSet@-2w
>  > >
>  > > Anyway, reverting this patch helps. :-)
>  >
>  > Could you let me see Dmesg and=A0 DSDT?
>
>  They are available at:
>
>  http://www.sisk.pl/kernel/050401/dmesg.out
>  http://www.sisk.pl/kernel/050401/dsdt
>
>  The dmesg output is from 2.6.12-rc1-mm4 with the patch reverted.
>
>  Greets,
>  Rafael
>
>
>  --
>  - Would you tell me, please, which way I ought to go from here?
>  - That depends a good deal on where you want to get to.
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 -- Lewis Carroll "Alice's Ad=
ventures in Wonderland"
>
>
>  -------------------------------------------------------
>  This SF.net email is sponsored by Demarc:
>  A global provider of Threat Management Solutions.
>  Download our HomeAdmin security software for free today!
>  http://www.demarc.com/Info/Sentarus/hamr30
>  _______________________________________________
>  Acpi-devel mailing list
>  Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>  https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
