From: mihn leigh <mihnsk@gmail.com>
Subject: cpu voltage scaling .. help me
Date: Wed, 9 Feb 2011 23:59:52 -0800
Message-ID: <AANLkTik4=7a1b4prYmw4Pn2b34_Cf-ur9wKQq2eSfu_Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48186 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1BJH7x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Feb 2011 02:59:53 -0500
Received: by wyb28 with SMTP id 28so1053981wyb.19
        for <linux-acpi@vger.kernel.org>; Wed, 09 Feb 2011 23:59:52 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I want to change voltage and frequency seperately in intel i7 core(nehalem).
With cpu-freq, i can change frequency, but cannot change voltage AFAIK.

I tried PHC "http://www.linux-phc.org", but change of voltage leads to
frequency as well.
Also, i tried to change IA32_PERF_CTL(MSR) register, but i also failed
to fix the frequency while changing the voltage.

Now, i have a plan to dig into PPC table, but i'm not sure if it's
possible or not.
Could you guys give me some infomartion how to change voltage seperately?

Thanks,
mihn
