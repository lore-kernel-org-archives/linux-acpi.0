From: "Zhao Forrest" <forrest.zhao@gmail.com>
Subject: Help on a ACPI error message during kernel boot
Date: Thu, 28 Sep 2006 19:45:16 -0700
Message-ID: <ac8af0be0609281945y7eb5129bp61e9fc7b489cf838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:58255 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWI2CpV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 22:45:21 -0400
Received: by ug-out-1314.google.com with SMTP id o38so237823ugd
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2006 19:45:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi list,

When booting the linux on my hardware, ACPI output some error messages
like this:

PCI: Using configuration type 1
    ACPI-1121: *** Error: Method execution failed [\_SB_.LNKA._STA]
(Node 0000010011dcb6c0), AE_AML_REGION_LIMIT
    ACPI-0098: *** Error: Method execution failed [\_SB_.LNKA._STA]
(Node 0000010011dcb6c0), AE_AML_REGION_LIMIT
    ACPI-1121: *** Error: Method execution failed [\_SB_.LNKB._STA]
(Node 0000010011dcb8c0), AE_AML_REGION_LIMIT
    ACPI-0098: *** Error: Method execution failed [\_SB_.LNKB._STA]
(Node 0000010011dcb8c0), AE_AML_REGION_LIMIT

Anyone has met the similar problems? Could you share some experience
of how to debug this problem? Now I'm totally clueless......

Thanks,
Forrest
