From: Benjamin Scherrer <realhangman@web.de>
Subject: Re: MSI K9A2 Platinum Rev.1 bios update from 1.1 to 1.5 breaks ACPI
 _PSS objects
Date: Tue, 23 Sep 2008 10:13:18 +0200
Message-ID: <48D8A51E.8040409@web.de>
References: <1006443634@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:41685 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYIWIWf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Sep 2008 04:22:35 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2F295F1749E9
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2008 10:22:34 +0200 (CEST)
Received: from [88.64.46.67] (helo=[192.168.2.43])
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Ki3AI-0005ZM-00
	for linux-acpi@vger.kernel.org; Tue, 23 Sep 2008 10:22:34 +0200
In-Reply-To: <1006443634@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

wow, MSI replied very fast  - they sent me an e-mail with a link to the
new 1.6.5 bios (dated early this month, it's not officially out yet).
Cpufreq is working again.

Thank you for the good powernow-k8 output; it got me to the solution in
less than a day!

Benjamin


Benjamin Scherrer wrote:
> Hi,
>
> I just updated my bios on the MSI K9A2 Platinum mainboard from version 1.1 to 1.5. Unfortunately, cpufreq is not working any more, and "modprobe powernow-k8" gives me:
>
> "powernow-k8: Found 1 AMD Phenom(tm) 9850 Quad-Core Processor processors (4 cpu cores) (version 2.20.00)
> powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor."
>
> I complaint to MSI, and am kindly asking you for advice what to do now, since I don't want to run all my cpus on 100% all the time. Will the cpufreq_ondemand governer also work without the PSS objects?
>
> greetings,
> Benjamin
>
> p.s. I mailed MSI that they should contact you at http://www.lesswatts.org/projects/acpi/ (just as info for you, they most probably won't do anything I guess)
>   

