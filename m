From: Ron <ron-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: user agent for toshiba extras
Date: Thu, 13 Feb 2003 17:13:15 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030214011315.GA2476@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: toshiba_acpi-7wiBuN1tZDdg9hUCZPvPmw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Howdy John and All,

My interest in this is a satellite 5205-s703.  I've been toying with the
cPad driver and acpi/swsusp and I'd like to put the 'hotkeys' to better
use.  I've written an interface to poll /proc/acpi/toshiba/keys, but I
think I'd really like to see them enabled via a userspace agent similar
to what hotplug and other drivers now do rather than run a polling
daemon.

Is there any work in progress on adding support for this, and if not
would you accept a patch implementing something like it?

I started at the pointy end of stable with 2.4.21pre4 + the most current
acpi & swsusp and worked my way back to 2.4.19, which is the first that
keventd won't eat 100% cpu for me.

I'm also not on the list yet, so please CC.

thanks!
Ron




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
