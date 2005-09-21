From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] STD needs HOTPLUG_CPU on SMP
Date: Tue, 20 Sep 2005 19:48:13 -0700
Message-ID: <20050920194813.4dd6f6da.rdunlap@xenotime.net>
References: <59D45D057E9702469E5775CBB56411F171F9D7@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59D45D057E9702469E5775CBB56411F171F9D7@pdsmsx406>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: jochen-AVN6mSxK9lsdnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 19 Sep 2005 16:29:02 +0800 Li, Shaohua wrote:

> Hi,
> >
> >"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> >
> >On further thinking, why does Suspend-to-RAM need HOTPLUG_CPU, but
> >Suspend-to-Disk works without?  Might help in finding a better
> >solution.
> STD also requires HOTPLUG_CPU. It might be the config error.

Yes, Kconfig error, if indeed your statement is correct,
which I'm not verifying, but accepting it to be.

Pavel, I guess this is yours to merge?

---
From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>

SOFTWARE_SUSPEND needs HOTPLUG_CPU on SMP.

Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
---

 kernel/power/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp linux-2614-rc1-git4/kernel/power/Kconfig~std_needs_hotplug_cpu linux-2614-rc1-git4/kernel/power/Kconfig
--- linux-2614-rc1-git4/kernel/power/Kconfig~std_needs_hotplug_cpu	2005-09-18 20:21:08.000000000 -0700
+++ linux-2614-rc1-git4/kernel/power/Kconfig	2005-09-19 19:28:33.000000000 -0700
@@ -29,7 +29,7 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))
+	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
