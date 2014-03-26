From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: RFC: APEI hardware reduced profile
Date: Wed, 26 Mar 2014 13:08:10 +0100
Message-ID: <5332C32A.5070301@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:35392 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaCZMIM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2014 08:08:12 -0400
Received: by mail-bk0-f54.google.com with SMTP id 6so500915bkj.41
        for <linux-acpi@vger.kernel.org>; Wed, 26 Mar 2014 05:08:11 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi <linaro-acpi@lists.linaro.org>

Hi,

Currently APEI depends on x86 architecture. It is because of many x86 
specific features like "IA-32 Architecture Corrected Machine Check
" error source or NMI hardware error notification. However, many other 
features like "PCI Express Device AER Structure" or GHES via external 
interrupt can be still used perfectly by other architectures. So my idea 
is to move x86 dependency away form Kconfig to APEI areas where it 
really applies to.

I have started refactoring ghes.c driver in that direction. And here 
comes my confusion, how should we treat x86 related parts, as fixed 
profile? (which means we could use ACPI_REDUCED_HARDWARE or 
CONFIG_ACPI_REDUCED_HARDWARE_ONLY define). I would like to ask for your 
opinion.

Regards,
Tomasz
