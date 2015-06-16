From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 00/35] acpi-video: Rewrite backlight interface selection logic
Date: Tue, 16 Jun 2015 16:27:38 +0200
Message-ID: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50564 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614AbbFPO2Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2015 10:28:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net

Hi Rafael,

As requested here is a rebased version of my acpi-video backlight interface
selection logic rewrite. This is based on linux-pm/linux-next.

I've also included 3 platform/x86 patches already queued up by Darren as you
will need those to apply some later patches without conflicts. These should
"disappear" when merged with Darren's tree.

Regards,

Hans
