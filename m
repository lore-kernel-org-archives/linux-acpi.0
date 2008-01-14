From: Toby Cubitt <tsc25@cantab.net>
Subject: Rotating tablet screen updates lid state but doesn't generate an event
Date: Mon, 14 Jan 2008 13:39:23 +0000
Message-ID: <478B660B.3030706@cantab.net>
Reply-To: Toby Cubitt <t.s.cubitt.98-dated-1200750052.7226bb@cantab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:35158 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750791AbYANNqg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jan 2008 08:46:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I hope this is the right list to post this kind of question.

I'm running a 2.6.23 kernel (with the tuxonice and Gentoo patchsets
applied) on a Toshiba Portege M400 tablet PC, and I have the legacy
/proc/acpi support built into the kernel (CONFIG_ACPI_PROCFS=y and
CONFIG_ACPI_PROC_EVENT=y), since acpid still depends on it for now. I
also have Toshiba ACPI support built into the kernel, in case that's
also relevant (CONFIG_ACPI_TOSHIBA=y).

When I open or close the lid as on a normal laptop,
/proc/acpi/button/lid/LID/state is updated and acpi
"button/lid" events are generated in /proc/acpi/event, as expected.
However, when I rotate the screen into tablet mode, although the lid
state is updated to "closed", nothing is generated in /proc/acpi/event.
Then, when I lift the lid to rotate it back to normal laptop position, a
"button/lid" event _is_ generated in /proc/acpi/event, identical to
normal lid events (and the lid state is updated to "open").

So it seems as though acpi is correctly identifying closing the lid and
rotating the screen into tablet mode as two different types of events,
but isn't writing anything to /proc/acpi/event for the latter. On the
other hand, it is generating identical events for both opening the lid
and rotating the screen back to laptop mode.

I guess the correct behaviour would be along the lines of what
apparently happens in Thinkpad tablets: opening and closing the lid
should generate "button/lid" events, and rotating the screen to and from
tablet mode should generate a different type of event. (Though if
the kernel just generated any event other than "button/lid" when the
screen was rotated to tablet mode, it would still be usable.)

I'm happy to provide more information if it would be helpful, but I have
no experience at all in helping debug kernel code, so I'm not sure what
I should be telling you.

Thanks for any help,

Toby
