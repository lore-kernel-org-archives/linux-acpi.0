From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC PATCH 0/2] acpi: video: Allow forcing native backlight on non win8 laptops
Date: Tue,  3 Mar 2015 08:39:08 +0100
Message-ID: <1425368350-4028-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55266 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbbCCHjQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Mar 2015 02:39:16 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Hi All,

I've long wanted to have a way for users to force native-backlight behavior as
that makes debugging backlight problems a bit easier.

And now a laptop has shown up which needs native backlight behavior for things
to work, has a non win8 ready bios, and I cannot use a quirk in the vendor
backlight driver as it implements both the acer-wmi and ideapad-laptop vendor
interfaces and putting the same quirk in 2 places is just wrong.

So I've finally written a small patch to allow forcing native-backlight
behavior as well as a second patch using this to add a quirk for said laptop.

For now this is just a RFC series as I'm waiting for confirmation from the
user that this actually fixes things, but I wanted to get the discussion going
beforehand in case anyone has any objections against the solution I've come
up with.

Regards,

Hans
