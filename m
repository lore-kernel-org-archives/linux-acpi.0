From: "Zhu, Yi" <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: suspend/resume support for driver requires an external firmware
Date: Thu, 23 Sep 2004 15:17:56 +0800 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0409231514270.8729-100000@mazda.sh.intel.com>
Reply-To: "Zhu, Yi" <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

I make the ipw2100 driver (http://ipw2100.sf.net) support suspend/resume
with below patch.
http://cache.gmane.org//gmane/linux/drivers/ipw2100/devel/2129-001.bin

Current state is the patch makes ipw2100 suspend/resume work in the expense
of addtional ~200k kernel runtime memory. So I'd rather look on it as a
workaround instead of a finial solution.

The problem is ipw2100 requires an external on-disk firmware support. When
the device is put to D3 state, firmware needs to be unloaded. And the
firmware should be loaded again after the device is put to D0 state. But
currently there is no suspend/resume order(dependency) for the online
devices list in the kernel (dpm_active). So the ide disk might still be in
the suspend state when ipw2100->resume is called. This causes a deadlock.


I propose 2 choices to fix the problem.

Choice 1. In 2.5 kernel, there used to be a ->save_state method in the
device PM interface. From the "not yet updated" document
(Documentation/power/pci.txt), this function can be used as "a notification
that it(the device) may be entering a sleep state in the near future". If we
take back this interface, the problem can be solved. That is, the driver
loads firmware into memory in ->save_state and frees the memory in ->resume.
The deadlock is resolved without any runtime memory wasted.

3 patches are attached for this idea.
device-save_state.patch adds back the interface ->save_state for the devices
	and implements pci bus save_state method.
swsusp-save_state.patch makes swsusp walks all devices ->save_state method
	before calling ->suspend method.
ipw2100-save_state.patch implements ipw2100 ->save_state method. 
They are proved working.


Choice 2. Add a notifier call chain for swsusp before prepare_suspend. Each
driver requires the notification(i.e. ipw2100) registers its own callback.
For people who think device PM ->save_state is an overkill since 99% devices
don't require firmwares (really today, who knows the future?), this can be
considered as another (better) solution.


Choice 3? or I missed something here?


Your comments are highly appreciated!


-- 
-----------------------------------------------------------------
Opinions expressed are those of the author and do not represent
Intel Corp.

Zhu Yi (Chuyee)

GnuPG v1.0.6 (GNU/Linux)
http://cn.geocities.com/chewie_chuyee/gpg.txt or
$ gpg --keyserver wwwkeys.pgp.net --recv-keys 71C34820
1024D/71C34820 C939 2B0B FBCE 1D51 109A  55E5 8650 DB90 71C3 4820



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
