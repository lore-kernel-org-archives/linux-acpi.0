From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/6] PNP: minor cleanups
Date: Wed, 15 Aug 2007 10:32:07 -0600
Message-ID: <20070815163207.062263984@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:51649 "EHLO
	tayrelbas04.tay.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932806AbXHOQyE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Aug 2007 12:54:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Fix a few more Lindent things and remove some unused code and
unnecessary casts.

The last patch removes some null pointer checks in cases where
I think it's better to just oops immediately rather than return
an error.

Bjorn

--
