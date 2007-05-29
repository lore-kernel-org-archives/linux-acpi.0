From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: [PATCH 0/3] Series short description
Date: Tue, 29 May 2007 16:42:47 +0400
Message-ID: <20070529123823.20303.55101.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:24896 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbXE2Mmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 May 2007 08:42:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1849490ugf
        for <linux-acpi@vger.kernel.org>; Tue, 29 May 2007 05:42:53 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, linux-acpi@vger.kernel.org

In order to get notifications from Smart Batteries there is a need to
allow non-AML query handlers in EC driver.
AML query handlers are now found at init time, so there is no need to
look them up in namespace at query time.

-- 
Regards,
Alex.
