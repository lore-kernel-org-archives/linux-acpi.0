From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM
	(was: Re: Resume from Suspend to RAM))
Date: Wed, 08 Jun 2005 09:15:41 +0800
Message-ID: <1118193341.3857.4.camel@linux-hp.sh.intel.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	 <1118125410.3828.12.camel@linux-hp.sh.intel.com>
	 <200506071732.23095.hugelmopf@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506071732.23095.hugelmopf-S0/GAf8tV78@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
On Tue, 2005-06-07 at 17:32 +0200, Frank wrote:
> > For those who suffer from strange S3 resume problem such as resume hang,
> > could you please try this debug patch.
> > It uses machine_real_restart to switch to real mode, and soon jump to
> > the S3 wakeup address. So it simulates how BIOS resume a system from S3,
> > but completely bypasses BIOS. If the system lives after S3 with the
> > patch, at least we can know the suspend/resume code path is ok and it's
> > not a Linux driver issue.
> >
> > Thanks,
> > Shaohua
> >
> > --- a/drivers/acpi/hardware/hwsleep.c	2005-06-07 13:45:04.088273424 +0800
> > +++ b/drivers/acpi/hardware/hwsleep.c	2005-06-07 13:49:31.858566152 +0800
> > @@ -242,6 +242,19 @@ acpi_enter_sleep_state_prep (
> >   *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
> >   *
> >  
> 
> Against which kernel version/tree does this patch go? I would be happy to test 
> it, but I am pretty new to kernel patching, so this is not so obvious to me.
I think any kernel version should be ok, but please try latest kernel.
Please note, this isn't a fix but a test case.
If the test failed, then suspend/resume code path or drivers are broken.
If the test succeeded, then
	1. Linux forgot doing something BIOS lets it do
	or 2. BIOS is broken.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
