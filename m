From: "Ken MacLeod" <ken@bitsko.slc.ut.us>
Subject: blacklisted with no SMBIOS
Date: Thu, 13 Sep 2007 11:57:37 -0500
Message-ID: <7ee95fff0709130957v5ff84932odd83ef3b07c1fec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:47962 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbXIMQ5j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Sep 2007 12:57:39 -0400
Received: by fk-out-0910.google.com with SMTP id z23so525490fkz
        for <linux-acpi@vger.kernel.org>; Thu, 13 Sep 2007 09:57:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

What's the way forward if we have a current BIOS with ACPI but no SMBIOS?

acpi=force works as expected.

Is SMBIOS a requirement with ACPI?  If not, what would a patch need to
do to correctly identify a working ACPI without SMBIOS present to
avoid the blacklist?

Thanks,

  -- Ken
