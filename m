From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Thu, 21 Oct 2004 03:36:52 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF713F042E.6095AA90-ON49256F33.00637EC8-49256F33.0065C963@jp.ibm.com>
References: <1098233908.4032.12.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1098233908.4032.12.camel@tyrosine>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org





>I'm testing this patch plus the wakeup address one on an EiSystem 3001
>(some random cheap VIA-based system). Suspend appears to work correctly
>- if I use Pavel's BEEP code in do_suspend_lowevel I get a tone
>immediately before the machine shuts down. The sleep light then comes
>on. Hitting the power button results in the machine rebooting
>immediately - putting a BEEP at the start of wakeup_start doesn't result
>in any tone. Are there any further useful details I can send?

>(This machine is of sufficiently poor quality that its DMI table claims
>it's a desktop, but it suspends correctly under Windows XP...)

Beep is not always audible. The timer registers should be initialized to
get a certain clock and the output of the beep may be controlled via
buttons,
sliders, or other software controllable registers. We cannot assume that
all of BIOS can do this kind of minimum POST setup from wakeup. It is not
a significant problem when the resume code can come back under OS control
to
re-initialize.

Instead, I test my machine to write a byte value on I/O port 0x3bc. This
is the parallel port's output register to be latched and observable if you
have a simple hardware decoder with 7 segment LEDs. <- do it yourself work
is required. :-)

The port write is very simple one instruction using dx and al registers
without any stack help. So It's nice for our suspend/resume debug.

- Hiro



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
