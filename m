From: Andika Triwidada <andika@startrek.or.id>
Subject: drivers for Lenovo 3000 series?
Date: Sun, 12 Apr 2009 14:51:09 +0700
Message-ID: <d0cc17060904120051h11e44079u5cf8174466b4e71e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:31980 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250AbZDLHvK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 03:51:10 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1629086rvb.1
        for <linux-acpi@vger.kernel.org>; Sun, 12 Apr 2009 00:51:09 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I have a Lenovo 3000 G430 [1] which seems to work ok except for
brightness control

but from [2]:
"... The ACPI and EC firmware are completely incompatible with
ThinkPads, and ibm-acpi/thinkpad-acpi will not support it. The Lenovo
3000 are not ThinkPads."

so, what do you suggest? create a new driver for Lenovo 3000 series?
Can I use thinkpad_acpi.c as a start or should I start from scratch?

Thanks
Andika Triwidada

[1] http://research.indocisc.com/~andika/g430/lenovo-g430.html
[2] http://www.thinkwiki.org/wiki/Category:Lenovo_3000
