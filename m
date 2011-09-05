From: Markus Pargmann <scos@allfex.org>
Subject: acpi schedule() calls rely on taskswitch?
Date: Mon, 5 Sep 2011 17:46:21 +0200
Message-ID: <20110905174621.1a4d2a31@aplus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.85-10-204-57.clients.your-server.de ([85.10.204.57]:39573
	"EHLO s1.allfex.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab1IEP5F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Sep 2011 11:57:05 -0400
Received: from aplus (port-92-205-85-3.dynamic.qsc.de [92.205.85.3])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by s1.allfex.org (Postfix) with ESMTPSA id 13FA0A57BC
	for <linux-acpi@vger.kernel.org>; Mon,  5 Sep 2011 17:49:32 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I am currently testing an alternative CPU-scheduler and have problems when ACPI is activated.
If the scheduler does not change the currently running task after a call of schedule(), the kernel hangs with ACPI activated. The kernel has no problems with acpi=off.

Is there any ACPI code that relies on a taskswitch when calling schedule?

I saw this behaviour with linux-2.6.38.6 and an AMD Athlon II M320.

Thanks,

Markus
