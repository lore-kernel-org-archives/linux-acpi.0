From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Howto switch system/CPU states?
Date: Tue, 5 Nov 2002 09:35:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021105093559.B1465@brodo.de>
References: <20021104060200.95943.qmail@web11002.mail.yahoo.com> <20021104075706.A635@brodo.de> <200211050128.37267.chris@chrishowells.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200211050128.37267.chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>; from chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org on Tue, Nov 05, 2002 at 01:29:01AM +0000
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 05, 2002 at 01:29:01AM +0000, Chris Howells wrote:
> 
> Hi,
> 
> On Monday 04 November 2002 6:57 am, Dominik Brodowski wrote:
> > On Sun, Nov 03, 2002 at 10:02:00PM -0800, Happy Camper wrote:
> > > 2. Switch CPU C states.  When I load the processor module, I get this
> > > in the /var/log/messages :
> > > Nov  3 16:09:25 localhost kernel: ACPI: Processor [CPU] (supports C1 C2
> > > C3, 8 throttling states)
> > > However I cant figure out how to switch these processor states.
> >
> > http://www.brodo.de/english/pub/acpi/proc/processor.html
> 
> In the current ACPI patches (e.g. without the ACPI to cpufreq stuff), does the
> switching CPU states have any actual effect?

Yes, it should. Although you don't know whether it works until you have
tested it. cpufreq only offers a cross-architecture interface, device driver
notification, and timer updates (so that delay() loops are correct and
/proc/cpuinfo shows the right frequency).

	Dominik


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
