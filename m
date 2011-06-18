From: Thomas Mitterfellner <thomas@mitterfellner.at>
Subject: Re: ACPI support for Toshiba Satellite Pro L770-116 Update
Date: Sat, 18 Jun 2011 15:35:01 +0200
Message-ID: <4DFCA985.40604@mitterfellner.at>
References: <4DE68096.7040708@mitterfellner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx05.easyname.eu ([77.244.243.9]:45906 "EHLO mail.easyname.eu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751663Ab1FRNfF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Jun 2011 09:35:05 -0400
Received: from chello084115146121.1.graz.surfer.at ([84.115.146.121] helo=linux-jn3t.site)
	by mail.easyname.eu with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@mitterfellner.at>)
	id 1QXvfz-0001BS-FM
	for linux-acpi@vger.kernel.org; Sat, 18 Jun 2011 13:35:03 +0000
In-Reply-To: <4DE68096.7040708@mitterfellner.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

Please forgive me for asking again for your help adding ACPI support for 
the Toshiba Satellite Pro L770-116 laptop to the linux kernel.

Unfortunately, I do not know how I can help developers on this other 
than providing the ACPI tables of this laptop.

I uploaded the ACPI tables here:

http://www.mitterfellner.at/files/acpitables.tar.bz2

(Content: APIC.dat DSDT.dat ECDT.dat FACP.dat FACS.dat HPET.dat MCFG.dat 
RSDP.dat SLIC.dat SSDT1.dat SSDT2.dat XSDT.dat)

I'd be very glad if someone could write a patch which enables the Fn-Fx 
functionality for changing the display brightness and for cycling 
through the LCD/VGA output modes. If you need any further information, I 
will of course try to provide it.

Thank you very much for your efforts,

Thomas Mitterfellner
