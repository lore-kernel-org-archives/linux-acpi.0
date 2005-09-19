From: Jochen Hein <jochen-AVN6mSxK9lsdnm+yROfE0A@public.gmane.org>
Subject: Re: wrong documentation for /proc/acpi/sleep?
Date: Mon, 19 Sep 2005 08:50:17 +0200
Message-ID: <871x3l4kly.fsf@echidna.jochen.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004A13DD5@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3004A13DD5-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
	(Len Brown's message of "Sun, 18 Sep 2005 23:08:05 -0400")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:

> Seems it is pretty obscure to enable SMP SLEEP in Kconfig.

Yes, it is ;-)

>>So, wouldn't it be far easier for a user to get all the needed symbols
>>selected, instead of hunting dependencies in Kconfig?  For me it
>>doesn't matter *what* options I need for ACPI_SLEEP.  I just want it
>>enabled.

On further thinking, why does Suspend-to-RAM need HOTPLUG_CPU, but
Suspend-to-Disk works without?  Might help in finding a better
solution.

Jochen

-- 
#include <~/.signature>: permission denied


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
