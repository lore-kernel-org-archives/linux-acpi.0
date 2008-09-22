From: "George Spelvin" <linux@horizon.com>
Subject: "Your BIOS does not provide ACPI _PSS objects"
Date: Mon, 22 Sep 2008 01:09:39 -0400
Message-ID: <20080922050939.17343.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:10811 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751225AbYIVFQU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 01:16:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mark.langsdorf@amd.com, linux-acpi@vger.kernel.org
Cc: linux@horizon.com

Booting 2.6.27-rc6 on a new MSI ms-7376 motherboard,
with both the shipped BIOS 1.4 and the latest & greatest 1.5,
produces the error message (one per processor):

powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.

I have submitted this to MSI's on-line technical support, although it may
not make it past the tech support munchkins to the Emerald City of Clue.

But since it says to "report this to the Linux ACPI maintainers", I'm
doing so... and the person who contrivuted the patch asking for notice.
