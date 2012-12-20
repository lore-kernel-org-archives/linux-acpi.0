From: Laszlo Ersek <lersek@redhat.com>
Subject: [PATCH 0/1] acpi_get_sleep_type_data(): accept package with one element
Date: Thu, 20 Dec 2012 18:31:22 +0100
Message-ID: <1356024683-28542-1-git-send-email-lersek@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49746 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab2LTR3n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Dec 2012 12:29:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, lersek@redhat.com

I'm trying to follow the guidelines set forth under
<https://lesswatts.org/projects/acpi/> and in the MAINTAINERS file.
Apologies if I'm getting wrong any posting requirement.

The patch is against Linus's tree @ commit f01af9f8.

I'm not subscribed to linux-acpi; please CC me on any followup.

"Please apply". Thanks for considering.

Laszlo Ersek (1):
  acpi_get_sleep_type_data(): accept package with one element

 drivers/acpi/acpica/hwxface.c |   60 ++++++++++++++++++++++-------------------
 1 files changed, 32 insertions(+), 28 deletions(-)

