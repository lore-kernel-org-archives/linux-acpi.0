From: Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH v2 0/7] ideapad: hotkey enablement
Date: Thu,  9 Dec 2010 15:56:16 +0800
Message-ID: <1291881376-4729-1-git-send-email-ike.pan@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:58070 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab0LIH41 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Dec 2010 02:56:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Hansen <dave@linux.vnet.ibm.com>

Here are the enablement patches for hotkey events on ideapads and these patches
are made against current checkout of mainline kernel.

After last time posting on LKML, there are several feedback and these patches
are modified.

>From Dmitry Torokhov, using markup on functions to let the compiler knows where
to put and passing private variable instead of using global vairable. The
acpi_handle is still a global variable becuase we need to pass handle pointer
to rfk_set with its opcode but only one data argument available.

>From Dave Hansen, select INPUT_SPARSEKMAP to fill the dependency.

These patches are available in the git repository at:
  git://kernel.ubuntu.com/ikepanhc/ideapad-laptop.git ideapad-laptop

Ike Panhc (7):
  ideapad: add platform driver for ideapad
  ideapad: let camera power control entry under platform driver
  ideapad: add hotkey support
  ideapad: select INPUT_SPARSEKMAP
  ideapad: add markups, unify comments and return result when init
  ideapad: pass ideapad_priv as argument (part 1)
  ideapad: pass ideapad_priv as argument (part 2)

 drivers/platform/x86/Kconfig          |    1 +
 drivers/platform/x86/ideapad-laptop.c |  255 ++++++++++++++++++++++----------
 2 files changed, 176 insertions(+), 80 deletions(-)

