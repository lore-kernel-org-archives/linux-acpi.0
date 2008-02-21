From: Jan Willies <jan@willies.info>
Subject: 100% C0 with 2.6.25-rc
Date: Thu, 21 Feb 2008 12:27:11 +0100
Message-ID: <47BD600F.9090502@willies.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from will39.synserver.de ([212.40.172.10]:37503 "EHLO
	will39.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbYBUMCS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 07:02:18 -0500
Received: from [92.227.69.220] (helo=[192.168.2.101])
	by will39.synserver.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <jan@willies.info>)
	id 1JS9aR-0001P8-NI
	for linux-acpi@vger.kernel.org; Thu, 21 Feb 2008 12:27:35 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Since 2.6.25-rc1 I have a lot of wakeups/s (=E2=89=88134191,4) and spen=
d 100% in C0. It worked fine with 2.6.24 and commandline nolapic. Witho=
ut nolapic I had 80k wakeups/s after some time, but not right from the =
start like now.

What useful information can I provide?


- Jan
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
