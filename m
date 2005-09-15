From: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: Fan driver suspend/resume issues
Date: Thu, 15 Sep 2005 12:42:42 +0200
Message-ID: <E1EFrCU-0002lM-00@dorka.pomaz.szeredi.hu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: pavel-+ZI9xUNit7I@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It seems that the ACPI fan driver lacks suspend/resume support, which
causes problems on some laptops (e.g HP nc-4000, nc-8000).

But it's not just suspend.  I see more than one issue:

 1)  ACPI initializes the fans all-off.

  This is dangerous.  If fan/thermal_zone driver are not compiled into
  the kernel or are modules or acpid is not installed (to insert the
  modules), then the system will silently overheat.  This is not a
  theoretical scenario, I've seen cases where sysadmin simply "forgot"
  to install the acpid package and user was clueless about
  overheating, and it resulted in hard disk failure.

 2) The fan/thermal_zone modules dont turn on all fans when removed.

    Also dangerous for same reasons as above.

 3) Fan driver doesn't have suspend/resume support.

Can someone familar with the ACPI internals please comment on the
above?

Thanks,
Miklos


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
