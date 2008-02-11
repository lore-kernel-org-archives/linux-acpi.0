From: Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: acpi_apic_instance=2
Date: Mon, 11 Feb 2008 23:44:23 +0100
Message-ID: <47B0CFC7.3030202@tlen.pl>
References: <47B0C6D9.2010508@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.go2.pl ([193.17.41.42]:42865 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758433AbYBKWoZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 17:44:25 -0500
Received: from poczta.o2.pl (mx2 [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id E24AD748080
	for <linux-acpi@vger.kernel.org>; Mon, 11 Feb 2008 23:44:23 +0100 (CET)
Received: from [10.1.1.146] (i01m-62-35-173-211.d4.club-internet.fr [62.35.173.211])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP
	for <linux-acpi@vger.kernel.org>; Mon, 11 Feb 2008 23:44:23 +0100 (CET)
In-Reply-To: <47B0C6D9.2010508@tlen.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

I retreat my previous letter.
The fan stops working with power supplier and with acpi_apic_instance=0 
as well. My bed, sorry.
I'll check twice before I write next time. I hoped I found a way to 
quiet down my machine. The fun stops periodically but for short time. 
It'll not be change until one find out how to turn on lower stages of 
processor. For both acpi instances I have C2 as the lowest with power 
supplier whilst C4 on battery.
cacy

Cacy Rodney wrote:
> Hi,
> I ran the kernel with the acpi_apic_instance=2 option and I found that 
> the fan works different. The power supplier was attached to my laptop at 
> the time which means that the fan should rotate continuously like 
> usually, but it starts to work only when the cooling is needed. The 
> computer with default instance works in that way only when the power 
> comes from battery. So it seems that the default acpi table depends on 
> the power state.
> The benefit of using acpi_apic_instance=2 is the quiet work of the 
> plugged machine. I did not try to change the acpi instance without power 
> supplier.
> cacy
> I have sony vaio SZ series
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

