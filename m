From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: wrong documentation for /proc/acpi/sleep?
Date: Mon, 19 Sep 2005 16:29:02 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F171F9D7@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jochen Hein <jochen-AVN6mSxK9lsdnm+yROfE0A@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
>
>> Seems it is pretty obscure to enable SMP SLEEP in Kconfig.
>
>Yes, it is ;-)
>
>>>So, wouldn't it be far easier for a user to get all the needed
symbols
>>>selected, instead of hunting dependencies in Kconfig?  For me it
>>>doesn't matter *what* options I need for ACPI_SLEEP.  I just want it
>>>enabled.
>
>On further thinking, why does Suspend-to-RAM need HOTPLUG_CPU, but
>Suspend-to-Disk works without?  Might help in finding a better
>solution.
STD also requires HOTPLUG_CPU. It might be the config error.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
