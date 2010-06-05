From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/2] PNPACPI: cope with invalid device IDs
Date: Fri, 04 Jun 2010 19:23:59 -0700
Message-ID: <20100605022058.25768.77560.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:65116 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab0FECYF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 22:24:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Bjorn, Len,

Here is the updated version of the patch that handles invalid _HIDs,
this time without adding duplicate entriess into the ID list. There
is also a second patch adding error handling into pnp_add_device().

Please consider applying.

Thank you,

-- 
Dmitry
