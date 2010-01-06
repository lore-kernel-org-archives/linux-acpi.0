From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 0/5] eeepc-laptop updates for 2.6.33-rc4
Date: Wed,  6 Jan 2010 22:07:36 +0100
Message-ID: <1262812061-4119-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:34096 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932368Ab0AFVHr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jan 2010 16:07:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Hi Len,

Here is some fixes for eeepc-laptop, and a patch to switch
to the new sparse keymap library.

Thanks,

Alan Jenkins (1):
  eeepc-laptop: disable cpu speed control on EeePC 701

Corentin Chary (3):
  eeepc-laptop: dmi blacklist to disable pci hotplug code
  eeepc-laptop: add hotplug_disable parameter
  eeepc-laptop: disable wireless hotplug for 1201N

Dmitry Torokhov (1):
  eeepc-laptop: switch to using sparse keymap library

 drivers/platform/x86/Kconfig        |    1 +
 drivers/platform/x86/eeepc-laptop.c |  298 +++++++++++++++++++----------------
 2 files changed, 164 insertions(+), 135 deletions(-)

