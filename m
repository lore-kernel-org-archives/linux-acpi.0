From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Fri, 1 Apr 2005 17:31:16 +0800
Message-ID: <200504011731.16467.luming.yu@intel.com>
References: <200503291156.19112.rjw@sisk.pl> <200503301205.40555.rjw@sisk.pl> <200503311044.58673.rjw@sisk.pl>
Reply-To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200503311044.58673.rjw-KKrjLPT3xs0@public.gmane.org>
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
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


On Thursday 31 March 2005 16:44, Rafael J. Wysocki wrote:
> Hi,
>
> On Wednesday, 30 of March 2005 12:05, Rafael J. Wysocki wrote:
> > On Wednesday, 30 of March 2005 07:53, Yu, Luming wrote:
> > > On Tuesday 29 March 2005 17:56, Rafael J. Wysocki wrote:
> > > > Hi,
> > > >
> > > > There is a problem on my box (Asus L5D, x86-64 kernel) with the ACPI
> > > > battery driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely, the
> > > > battery monitor that I use (the kpowersave applet from SUSE 9.2) is
> > > > no longer able to report the battery status (ie how much % it is
> > > > loaded).  It can only check if the AC power is connected (if it is
> > > > connected, kpowersave behaves as though there was no battery in the
> > > > box, and if it is not connected, kpowersave always shows that the
> > > > battery is 1% loaded).
> > > >
> > > > Also, there are big latencies on loading and accessing the battery
> > > > module, but the module loads successfully and there's nothing
> > > > suspicious in dmesg.
> > > >
> > > > Please let me know if you need any additional information.
> > > >
> > > > Greets,
> > > > Rafael
> > >
> > > Could you just revert ec-mode patch, then retest?
> >
> > Could you please point me to it?
>
> I assume you mean the "Enable EC Burst Mode" patch at:
>
> http://linux-acpi.bkbits.net:8080/to-akpm/cset%401.2181.17.12?nav=index.htm
>l|ChangeSet@-2w
>
> Anyway, reverting this patch helps. :-)

Could you let me see Dmesg and  DSDT?

TIA


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
