From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: plans for toshiba_acpi
Date: Sun, 12 Jun 2005 17:15:16 +0200
Message-ID: <1118589316.14218.11.camel@nouse.net>
References: <42AC42E1.50801@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42AC42E1.50801-wanGne27zNesTnJN9+BGXg@public.gmane.org>
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
Cc: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, Jonathan Buzzard <jonathan-kE54VaY6i3ADXYZnReoRVg@public.gmane.org>, Daniel Silverstone <dsilvers-gyMb1R/nBgPUHbNLRunGg9i2O/JbrIOy@public.gmane.org>, Charles Schwieters <charles-65ntjE03WUhD60Wz+7aTrA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Sun, 2005-06-12 at 10:12 -0400, John Belmonte wrote:

> Here are my plans for enhancing the "toshiba_acpi" driver, and imploding
> the "/proc/acpi/toshiba" interface.
> 
> * incorporate ACPI hotkeys patch developed by Daniel Silverstone and
> used in Ubuntu Linux.  Available as a run-time option, this creates a
> kernel thread which polls the Toshiba firmware for hotkey events, and
> passes them along to the ACPI subsystem.

Since the hotkey values for brightness up and brightness down are
identical on Toshiba laptops, it would also make sense to let the kernel
thread trigger the appropriate SCI command.  This way no user space tool
would be required for this purpose any longer.

[...]

See you,

   Timo



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
