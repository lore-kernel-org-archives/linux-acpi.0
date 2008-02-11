From: Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: acpi_apic_instance=2
Date: Mon, 11 Feb 2008 23:06:17 +0100
Message-ID: <47B0C6D9.2010508@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx10.go2.pl ([193.17.41.74]:60502 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753416AbYBKWGU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 17:06:20 -0500
Received: from poczta.o2.pl (mx10.go2.pl [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id B197458014
	for <linux-acpi@vger.kernel.org>; Mon, 11 Feb 2008 23:06:18 +0100 (CET)
Received: from [10.1.1.146] (i01m-62-35-173-211.d4.club-internet.fr [62.35.173.211])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP
	for <linux-acpi@vger.kernel.org>; Mon, 11 Feb 2008 23:06:17 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
I ran the kernel with the acpi_apic_instance=2 option and I found that 
the fan works different. The power supplier was attached to my laptop at 
the time which means that the fan should rotate continuously like 
usually, but it starts to work only when the cooling is needed. The 
computer with default instance works in that way only when the power 
comes from battery. So it seems that the default acpi table depends on 
the power state.
The benefit of using acpi_apic_instance=2 is the quiet work of the 
plugged machine. I did not try to change the acpi instance without power 
supplier.
cacy
I have sony vaio SZ series
