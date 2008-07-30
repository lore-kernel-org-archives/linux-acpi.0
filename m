From: Thomas Renninger <trenn@suse.de>
Subject: Debug interface used for error message cleanups
Date: Wed, 30 Jul 2008 22:22:13 +0200
Message-ID: <1217449342-20312-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:49434 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756462AbYG3UWZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com

This removes all DB_WARN and DB_ERROR instances from the kernel.

It is still one time used in ACPICA code in the namespace dir.
It would be great to remove this from ACPICA to finally avoid
people from mis-using it.

Patches are compile tested.

Hmm, there seem to be a compile error in the wireless area, but
my touched files have compiled already, no time to look
at this right now, I expect it's known already:
  CC [M]  drivers/net/wireless/iwlwifi/iwl-led.o
drivers/net/wireless/iwlwifi/iwl-led.c: In function =E2=80=98iwl_led_br=
ightness_set=E2=80=99:
drivers/net/wireless/iwlwifi/iwl-led.c:198: error: =E2=80=98led_type_st=
r=E2=80=99 undeclared (first use in this function)
drivers/net/wireless/iwlwifi/iwl-led.c:198: error: (Each undeclared ide=
ntifier is reported only once
drivers/net/wireless/iwlwifi/iwl-led.c:198: error: for each function it=
 appears in.)
make[4]: *** [drivers/net/wireless/iwlwifi/iwl-led.o] Error 1


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
