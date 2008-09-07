From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: No cpufreq on a Celeron 550
Date: Sun, 7 Sep 2008 11:46:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0809071122100.3981@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42112 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752814AbYIGJiU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Sep 2008 05:38:20 -0400
Received: from lyakh (helo=localhost)
	by axis700.grange with local-esmtp (Exim 4.63)
	(envelope-from <g.liakhovetski@gmx.de>)
	id 1KcGqQ-0001Bp-CY
	for linux-acpi@vger.kernel.org; Sun, 07 Sep 2008 11:46:10 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all

I cannot use cpufreq on an ACER Extensa 5220 laptop with a Celeron 550 @ 
2GHz CPU. Reading various posts and articles, I saw that some kernel 
versions have been able to use acpi-cpufreq on these CPUs and some cannot. 
Currently using 2.6.26. acpidump output, cpuinfo, dmesg, lspci are at 
http://home.arcor.de/g.liakhovetski/extensa5220/. Is there any chance to 
get cpufreq fixed on this system?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
