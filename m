From: Thomas Renninger <trenn@suse.de>
Subject: Check for ACPI backlight support otherwise use vendor ACPI drivers - version 2
Date: Wed, 16 Jul 2008 12:52:22 +0200
Message-ID: <1216205553-8486-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48166 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754210AbYGPKwi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 06:52:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

Changes to last version:
  - I found some ugly typos mixing up ands and ors on the acpi_video_support
    bit mask -> fixed.
  - moved video capabilities checking from pci_root.c to the backlight/display
    switching modules. This is important to not search for capabilities where
    no graphics device is found and video.ko or vendor drivers (most through
    dmi modalias) do not load anyway. The real search is only done by the first
    video capable module invoking acpi_video_backlight_support() or
    acpi_video_display_switch_support(). Further calls to these functions
    return a cached value. This change was mainly moving function invokations
    the previous version was already designed in the right way, I somehow
    was fixed to the idea that checking must be done before module load time,
    but this turned out to be wrong.
  - Corrected messages/comments in thinkpad_acpi.c
  - Removed dmi check for Dells
  - Fixed a section mismatch compile message in the fujitsu driver

Most logic is in the second patch where video_detect.c is introduced.
I mean, there could be a typo in one of the vendor specific drivers,
it would be great if the maintainers of each driver could have a quick
look at the code (did I forget to free an already alloced backlight
struct or similar?).

It is highly recommended that these patches are tried out together with
Matthew's/Hong's IGD driver changes.
I do not know whether they are already in the dri tree or in linux-next,
whether they will be accepted for .27 etc. I hope Matthew will answer on
this mail and tell us.
AFAIK on thinkpads they already need an additional patch to work?
Chances are high that other laptop families also need a bit of a special
treatment to get the very new IGD parts to work.
If people test both patches together we could get a matrix like this:

          IGD/video.ko/Vista way   |  vendor specific, XP way
Dell    |           -              |             X
HP      |           -              |             ?
Lenovo  |           X              |             X
MSI     |           -              |             ?
Toshib  |           -              |             -
Fujitsu |           -              |             X
...     |           -              |

Above is more or less guessed, also everybody should tell about its
graphics card.
Intel graphics cards sooner or later must be switched through video.ko
(those and only those are intended by BIOSes to be IGD driven
already or in the near future (-> Matthew's/Hong's patch needed))
On Nvidia or AMD the binary only driver may take over switching
(it doesn't harm to still load and use video.ko then as they disable
 IO space, I expect/hope this will change at some time). Still if you
switch to console backlight can/must be switched through ACPI again
also on these.

Only Vista capable BIOSes are supposed to be switched via video.ko, but
those should sooner or later be switched through it, every Vista capable
BIOS shows generic ACPI backlight functions.


Off topic (a bit) - Toshiba only:
On Toshibas video.ko will not work.
They miss the third generic ACPI backlight function to query the current
brightness level (_BQC).
Zhao Yakui provided a patch ignoring this on module load time.
This resulted in a black screen on startup because of an initial
backlight state of zero.

IMO his patch was the right way and even Linus reverted it, trying again
is worth it:

commit 797de7bdb253624c16144f40b72ec65d63cdcca2
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Apr 5 12:14:13 2008 -0700

    Revert "ACPI: Ignore _BQC object when registering backlight device"

Ok, I followed up the bug link, there already is an updated fixed patch in bug:
http://bugzilla.kernel.org/show_bug.cgi?id=10206
attachment is:
http://bugzilla.kernel.org/attachment.cgi?id=16310&action=view

Zhao, could you repost this based on top of these, pls


