From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 0/3] ACPI: Fix handling of power resources during initialization
Date: Thu, 28 Oct 2010 15:07:34 +0200
Message-ID: <201010281507.34994.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33286 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758686Ab0J1NNG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Oct 2010 09:13:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

The following series of patches attempts to fix the problems with the handling
of power resources during initialization.

[1/3] allows power resource devices to be initialized by acpi_power driver as
      soon as they are found.

[2/3] creates power resource device objects as soon as they appear in the _PRn
      output for any devices.

[3/3] uses acpi_power_transition() to set up the initial reference counting of
      power resources as appropriate.

I have only tested them on machines without ACPI power resource objects, so all
this is kind of theoretical at the moment, but I think the patches are simple
enough.

Please test if you can and let me know what's wrong. :-)

Thanks,
Rafael

