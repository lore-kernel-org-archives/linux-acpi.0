From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: wrong documentation for /proc/acpi/sleep?
Date: Sun, 18 Sep 2005 23:08:05 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3004A13DD5@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Jochen Hein <jochen-AVN6mSxK9lsdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Seems it is pretty obscure to enable SMP SLEEP in Kconfig.

Anybody got suggestions?

it might be that we want to use "select" instead
of "depends on" here?

thanks,
-Len=20

>-----Original Message-----
>From: Jochen Hein [mailto:jochen-AVN6mSxK9lsdnm+yROfE0A@public.gmane.org]=20
>Sent: Friday, September 16, 2005 2:20 PM
>To: Brown, Len
>Subject: Re: [ACPI] wrong documentation for /proc/acpi/sleep?
>
>"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
>
>>>>> System is a Thinkpad R40, Debian/sarge with kernel=20
>2.6.14-rc1. Did I
>>>>> miss something obvious?
>>>>
>>>> Enable CONFIG_ACPI_SLEEP
>>>
>>>Which is a maze to find, if you have SMP enabled.  Can that be made
>>>easier?  Thanks for your help.
>>
>> The idea is that /proc/acpi/sleep is deprecated --
>> it is disabled by default.  Indeed, we're deprecating
>> all of /proc/acpi as we move to sysfs -- so when equivalent
>> functions appear in sysfs, other parts of /proc/acpi
>> will be under similar non-default config options
>> solely for backwards compatibility.
>
>That's fine with me.
>
>> I'm open to suggestions for better clarity if you've got any.
>
>I asked myself, why I didn't find CONFIG_ACPI_SLEEP in menuconfig.
>Looking into drivers/acpi/Kconfig:
>
>,----
>| config ACPI_SLEEP
>|         bool "Sleep States"
>|         depends on X86 && (!SMP || SUSPEND_SMP)
>|         depends on PM
>`----
>
>Ok, my kernel has been SMP, so I needed to look for SUSPEND_SMP first.
>In menuconfig I didn't find it in the suspect places.  So a grep told
>me:
>
>,----
>| root@hermes:/usr/src/linux-2.6.14-rc1# find . -name Kconfig | xargs
>| grep SUSPEND_SMP
>| ./drivers/acpi/Kconfig: depends on X86 && (!SMP || SUSPEND_SMP)
>| ./kernel/power/Kconfig:config SUSPEND_SMP
>`----
>
>Ok, looking int kernel/power/Kconfig:
>
>,----
>| config SUSPEND_SMP
>|         bool
>|         depends on HOTPLUG_CPU && X86 && PM
>`----
>
>I never imagined that I'd need HOTPLUG_CPU outside a virtualized
>environment ala LPAR or VM on S/390.
>
>Where the heck is HOTPLUG_CPU defined?
>
>,----
>| root@hermes:/usr/src/linux-2.6.14-rc1# find . -name Kconfig | xargs
>| grep HOTPLUG_CPU
>| ./arch/i386/Kconfig:config HOTPLUG_CPU
>| ./arch/ia64/Kconfig:config HOTPLUG_CPU
>| ./arch/parisc/Kconfig:config HOTPLUG_CPU
>`----
>
>And there it is:
>,----
>| config HOTPLUG_CPU
>|         bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
>|         depends on SMP && HOTPLUG && EXPERIMENTAL
>`----
>
>So, wouldn't it be far easier for a user to get all the needed symbols
>selected, instead of hunting dependencies in Kconfig?  For me it
>doesn't matter *what* options I need for ACPI_SLEEP.  I just want it
>enabled.
>
>I see that the dependency on EXPERIMENTAL might force us to have the
>user select three symbols to achive a single thing - but once
>HOTPLUG_CPU isn't experimental any more, we should try to make it
>easier for users.
>
>Jochen
>
>--=20
>#include <~/.signature>: permission denied
>


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
