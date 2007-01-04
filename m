From: Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: RE: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 04 Jan 2007 18:58:41 +0100
Message-ID: <459D4051.9020506@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tur.go2.pl ([193.17.41.50]:41939 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964881AbXADSOu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jan 2007 13:14:50 -0500
Received: from poczta.o2.pl (unknown [193.17.41.142])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id 5CC442303F7
	for <linux-acpi@vger.kernel.org>; Thu,  4 Jan 2007 18:57:47 +0100 (CET)
Received: from poczta.o2.pl (mx12 [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id C61376280C9
	for <linux-acpi@vger.kernel.org>; Thu,  4 Jan 2007 18:56:44 +0100 (CET)
Received: from [192.168.226.86] (imc.pcz.czest.pl [212.87.225.147])
	by poczta.o2.pl (Postfix) with ESMTP
	for <linux-acpi@vger.kernel.org>; Thu,  4 Jan 2007 18:56:44 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello everyone!

I know that the thread is much further but I'd like to inform the 
maintainer (whoever is) that the driver v0.2 (there is v0.3 but in this 
context it is not important) with the updated sony_acpi_values structure 
(enclosed at the end) is working and gives me about 20% of energy 
conservation.
By clear, I have Sony Vaio SZ2.
The cdpower(cdrom),sound,lan files in sony directory can power off 
(_PS3) the relevant devices. To do that

echo 0 >/proc/acpi/sony/cdpower etc.

To ON the devices

echo 1 >/proc/acpi/sony/cdpower etc.

(unfortunately, after the commend sequence the lan card is not 
initialized properly and to use it again the computer must be rebooted - 
but i'm working to change it :))

The acpi methods of SNC are:

Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GBRT, args 0
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: SBRT, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GPBR, args 0
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: SPBR, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: PWAK, args 0
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: PWRN, args 0
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: CSXB, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GWDP, args 0
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: CDPW, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GCDP, args 0
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: SLRS, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: RBMF, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: RSBI, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: CBMF, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: AZPW, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GAZP, args 0
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: LNPW, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GLNP, args 0
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: SCAM, args 1
Jan  4 17:56:12 darkstar kernel: sony_acpi: method: name: GCAM, args 0

Anyone knows what the rest do?

Best regards
Cacy


} sony_acpi_values[] = {
         {
                 .name           = "brightness",
                 .acpiget        = "GBRT",
                 .acpiset        = "SBRT",
                 .min            = 1,
                 .max            = 8,
                 .debug          = 0,
         },
         {
                 .name           = "brightness_default",
                 .acpiget        = "GPBR",
                 .acpiset        = "SPBR",
                 .min            = 1,
                 .max            = 8,
                 .debug          = 0,
         },
         {
                 .name           = "cdpower",
                 .acpiget        = "GCDP",
                 .acpiset        = "CDPW",
                 .min            = 0,
                 .max            = 1,
                 .debug          = 0,
         },
         {
                 .name           = "sound",
                 .acpiget        = "GAZP",
                 .acpiset        = "AZPW",
                 .min            = 0,
                 .max            = 1,
                 .debug          = 0,
         },
         {
                 .name           = "lan",
                 .acpiget        = "GLNP",
                 .acpiset        = "LNPW",
                 .min            = 0,
                 .max            = 1,
                 .debug          = 0,
         },
         {
                 .name           = NULL,
         }
};
