From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/13] ACPI / PM: Rework power resources management
Date: Thu, 25 Nov 2010 00:01:11 +0100
Message-ID: <201011250001.11297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52712 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab0KXXQg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Nov 2010 18:16:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Maciej Rutecki <maciej.rutecki@gmail.com>

Hi,

Unfortunately there are a few problems with ACPI power resources management
that should be fixed by the following series of patches.

Patch [1/13] is necessary to fix a recent regression in the mainline kernel and
patch [2/13] also should go into 2.6.37 IMO.  The remaining patches are not so
urgent, but they all are necessary.

[1/13] - Fix regression if fan resume resulting from the rework of power
         resources reference counting.

[2/13] - Do not reference count power resources that can't be turned on.

[3/13] - Rework acpi_power_get_inferred_state() so that it doesn't update
         device->power.state behind the caller's back.

[4/13] - Introduce functions for handling lists of power resources.

[5/13] - Introduce helper function for reference counting power resources
         for a given device and power state.

[6/13] - Introduce function for reading device power state without modifying
         the device object.

[7/13] - Add function for device power state initialization.

[8/13] - Add function for updating device power state in a consistent way.

[9/13] - Register acpi_power_driver before scanning the root of the namespace.

[10/13] - Add power resource ACPI device objects as soon as they are needed.

[11/13] - Rework the management of ACPI power resources in the ACPI fan driver.

[12/13] - Drop acpi_bus_get_power() that has no users now.

[13/13] - Drop acpi_power_nocheck which isn't necessary any more.

The patches have been tested on my HP nx6325 (which is the only machine using
ACPI power resources I have) and a combo patch functionally equivalen to this
series has been tested by Maciej Rutecki.

Please apply.

Thanks,
Rafael

