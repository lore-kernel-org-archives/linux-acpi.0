From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Thu, 23 Sep 2004 14:06:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040923120604.GD7963@elf.ucw.cz>
References: <Pine.LNX.4.44.0409231514270.8729-100000@mazda.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409231514270.8729-100000-7yGjFsf0sy5rdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Zhu, Yi" <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I make the ipw2100 driver (http://ipw2100.sf.net) support suspend/resume
> with below patch.
> http://cache.gmane.org//gmane/linux/drivers/ipw2100/devel/2129-001.bin
> 
> Current state is the patch makes ipw2100 suspend/resume work in the expense
> of addtional ~200k kernel runtime memory. So I'd rather look on it as a
> workaround instead of a finial solution.
> 
> The problem is ipw2100 requires an external on-disk firmware support. When
> the device is put to D3 state, firmware needs to be unloaded. And the
> firmware should be loaded again after the device is put to D0 state. But
> currently there is no suspend/resume order(dependency) for the online
> devices list in the kernel (dpm_active). So the ide disk might still be in
> the suspend state when ipw2100->resume is called. This causes a deadlock.
> 
> 
> I propose 2 choices to fix the problem.
> 
> Choice 1. In 2.5 kernel, there used to be a ->save_state method in the
> device PM interface. From the "not yet updated" document
> (Documentation/power/pci.txt), this function can be used as "a notification
> that it(the device) may be entering a sleep state in the near future". If we
> take back this interface, the problem can be solved. That is, the driver
> loads firmware into memory in ->save_state and frees the memory in ->resume.
> The deadlock is resolved without any runtime memory wasted.
> 
> 3 patches are attached for this idea.
> device-save_state.patch adds back the interface ->save_state for the devices
> 	and implements pci bus save_state method.
> swsusp-save_state.patch makes swsusp walks all devices ->save_state method
> 	before calling ->suspend method.
> ipw2100-save_state.patch implements ipw2100 ->save_state method. 
> They are proved working.

Are you sure you'll be able to allocate 200KB of memory at runtime?
Well, you probably can using vmalloc or such.

Yes, this looks like reasonable way to go. I guess I'd survive
notifier chain, too, because saving state can be done at any order for
todays devices, but this looks better with the driver model.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
