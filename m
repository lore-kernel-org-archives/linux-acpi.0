From: Oliver Neukum <oliver@neukum.org>
Subject: boot regression from rc1 to rc2
Date: Thu, 22 Jan 2009 21:28:20 +0100
Message-ID: <200901222128.20865.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:53057 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZAVU2A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jan 2009 15:28:00 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi,

2.6.29-rc2 crashes hard during boot on my laptop.
I've bisected it down to commit c6cb0e878446c79f42e7833d7bb69ed6bfbb381f
ACPI: EC: Don't trust ECDT tables from ASUS

The laptop boots with "acpi=off".

	Regards
		Oliver
