From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Thu, 23 Sep 2004 18:42:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040923164203.GC6412@elf.ucw.cz>
References: <20040923140018.25346.qmail@web81309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040923140018.25346.qmail-ockkSbn3fCqA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: "Zhu, Yi" <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I make the ipw2100 driver (http://ipw2100.sf.net) support suspend/resume
> > with below patch.
> > http://cache.gmane.org//gmane/linux/drivers/ipw2100/devel/2129-001.bin
> > 
> > Current state is the patch makes ipw2100 suspend/resume work in the
> > expense
> > of addtional ~200k kernel runtime memory. So I'd rather look on it as a
> > workaround instead of a finial solution.
> > 
> > The problem is ipw2100 requires an external on-disk firmware support. When
> > the device is put to D3 state, firmware needs to be unloaded. And the
> > firmware should be loaded again after the device is put to D0 state. But
> > currently there is no suspend/resume order(dependency) for the online
> > devices list in the kernel (dpm_active). So the ide disk might still be in
> > the suspend state when ipw2100->resume is called. This causes a deadlock.
> > 
> > 
> > I propose 2 choices to fix the problem.
> > 
> > Choice 1. In 2.5 kernel, there used to be a ->save_state method in the
> > device PM interface. From the "not yet updated" document
> > 
> > Choice 2. Add a notifier call chain for swsusp before prepare_suspend.
> > Each
> > driver requires the notification(i.e. ipw2100) registers its own callback.
> > For people who think device PM ->save_state is an overkill since 99%
> > devices
> > don't require firmwares (really today, who knows the future?), this can be
> > considered as another (better) solution.
> > 
> > 
> > Choice 3? or I missed something here?
> > 
> 
> What about splitting resume in 2 parts - the ->resume method
> would just schedule_work() real resume for the card out of
> line where it can safely wait for drive to be available without
> blocking other devices from resuming. This way you do not need
> to pre-load firmware on suspend.

That way, userspace could see wifi card in half-suspended state. Not
good.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
