From: Zhang Rui <rui.zhang@intel.com>
Subject: ACPI procfs removal patches and video cleanup patches for 2.6.38
Date: Mon, 06 Dec 2010 15:04:10 +0800
Message-ID: <1291619050.19296.574.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:39891 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab0LFHHX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 02:07:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Len,

this patch set contains three patches for ACPI procfs I/F removal,
one patch for processor driver cleanup and another three patches for
ACPI video cleanup.

They are all made based on the latest acpi-test tree. As I only run the
build test, so we'd better keep them in acpi-test for some time to see
if they works, before sending out for linux-next.

thanks
rui

