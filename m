From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: /proc/acpi/
Date: Tue, 9 Mar 2004 22:54:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040309215432.GA12855@message-id.gmane0305.slipkontur.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0029EEDA9@hdsmsx402.hd.intel.com> <1083816719.3175.20.camel@coredump.stonepath.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1083816719.3175.20.camel-QTaIpnqiE1EgB3xxsXi9fr1mrQd+NHyP@public.gmane.org>
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

On Mon, Mar 08, 2004 at 04:22:12AM +0000, Mike Partyka wrote:
> Hmm, i had read that SuSE had enabled ACPI already but they did not seem
> to be working. That is . . .
> 
> When the lid closes
> When the ac adapter is not plugged in 
> 
> The latop should sense this.
> 
> When running on battery the gnome battery meter does not seem to
> understand.
> 
> My understanding is that for these features to work there should be some
> files to control events under /proc/acpi/battery and
> /proc/acpi/ac_adapter but there is nothing under these directories. 

try a "rcacpid start" and check thereafter with "lsmod" if the
acpi modules are loaded (processor, thermal, battery, button etc).
after that, at least the KDE Battery applet should work, don't know
about gnome.

If this was the problem, fix it permanently with "insserv acpid" so you
also start acpid on the next reboot.

> > >This is a stock install of SuSE 9 Pro but it doesn't seem to have any
> > >ACPI features enabled by default. How can i do this?

The "standard" ACPI features (battery status, shutdown on powerbutton)
work pretty well with SUSE 9.0, if the DSDT of your machine is ok.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
