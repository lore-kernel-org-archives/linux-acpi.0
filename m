From: Jan Kokoska <kokoskaj-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Subject: Suspend to memory and Intel 8x0 soundcard
Date: Sat, 25 Sep 2004 15:28:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1096122506.2502.49.camel@zirael>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

While I am at it, I would like to report problems with this card, too:
Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller.

Unlike the other guy's recently reported in bugzilla, mine doesn't
resonate with motherboard, but rather severely drops volume. This
happens after wakeup from "echo mem > /sys/power/state". At first I
thought I have no sound at all, but after tuning everything to max I
could hear some bits of Beethoven's 9th, with background noise of
course.

The driver is unfortunately compiled in, so I cannot try re-loading
module, but even swsusp2 reboot (proper BIOS init) fixes it (of course).
Before recompiling kernel, I would like to know what all I cannot have
hardwired into it for proper suspending (USB EHCI is for sure, ipw2100 I
wouldn't put there anyway, Intel 8x0 sound seems to be next, FireWire
OHCI1394 might have caused unhandled interrupt - see the other e-mail -
list goes on... )

Please see my /proc/interrupts, /proc/version, dmesg and lspci -vvxxx in
the other message, large attachments.

Jan Kokoska



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
