From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Subject: ACPI Errors on Acer Aspire One
Date: Tue, 11 May 2010 20:25:31 +0530
Message-ID: <AANLkTilF304TbgACKtvc_FA01uxHrdRBS2Q-o6Tm-n8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48113 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab0EKOzd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2010 10:55:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello,

With latest git kernel, I am getting following ACPI errors :

[    0.289038] ACPI Error (dsfield-0143): [CAPB] Namespace lookup
failure, AE_ALREADY_EXISTS
[    0.289399] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f70477e8), AE_ALREADY_EXISTS
[    0.299684] ACPI Error (dsfield-0143): [CAPB] Namespace lookup
failure, AE_ALREADY_EXISTS
[    0.300007] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f70477e8), AE_ALREADY_EXISTS


dmesg : http://userweb.kernel.org/~jaswinder/acer_netbook/dmesg_2634-rc7.txt
.config : http://userweb.kernel.org/~jaswinder/acer_netbook/config_2634-rc7.txt

How can I fix these errors.

Thanks,
--
Jaswinder Singh.
