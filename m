From: Len Brown <lenb@kernel.org>
Subject: proposed fix for multiple MADT issue
Date: Sun, 11 Mar 2007 21:24:19 -0400
Message-ID: <11736626612135-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:40297 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874AbXCLBYa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Mar 2007 21:24:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

If this approach doesn't work, then we'll have to look into
parsing the namespace to reliably enumerate processors.

-Len
 
