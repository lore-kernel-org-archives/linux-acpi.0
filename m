From: mihn <mihnsk@gmail.com>
Subject: cpu voltage change question
Date: Thu, 27 Jan 2011 01:10:53 -0800
Message-ID: <1296119453.4653.1.camel@genix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:51220 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab1A0JKt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jan 2011 04:10:49 -0500
Received: by yib18 with SMTP id 18so488591yib.19
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jan 2011 01:10:48 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I want to change voltage and frequency seperately.
With cpu-freq, i can change frequency, but cannot change voltage AFAIK.

Can I do this using cpu-freq?

If possible, how can I set voltage with the fixed value?
If not, is there any way to do that?

FYI, i'm using intel i7-core(nehalem) and ubuntu 10.10.
FYI2, i found out i can do using IA32_PERF_CTL register, but there's no
detail from intel.
FYI3, can i change P-state table so that i can only change voltage in P
states?

Thanks,
mihn


