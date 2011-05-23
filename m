From: Thomas Mitterfellner <thomas@mitterfellner.at>
Subject: ACPI support for Toshiba Satellite Pro L770-116
Date: Mon, 23 May 2011 14:02:36 +0200
Message-ID: <4DDA4CDC.5010902@mitterfellner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx04.easyname.eu ([77.244.243.8]:38439 "EHLO mail.easyname.eu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750972Ab1EXFfC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 May 2011 01:35:02 -0400
Received: from faochcn87.tu-graz.ac.at ([129.27.176.87])
	by mail.easyname.eu with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@mitterfellner.at>)
	id 1QOTrZ-00006u-Do
	for linux-acpi@vger.kernel.org; Mon, 23 May 2011 12:03:57 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

I run a 2.6.37.6 kernel on a Toshiba Satellite Pro L770-116 Notebook 
with an American Megatrends BIOS (Aptio Setup Utility).

I read that Toshibas with Phoenix BIOS are treated differently from the 
ones with a Toshiba BIOS, with different kernel modules being necessary 
(the toshiba_acpi module is not appropriate for my laptop ('no such 
device'). However, I could not find any information on Toshiba Laptops 
with an AMI BIOS. The only Toshiba-specific module that's being loaded 
is toshiba_bluetooth.

Some ACPI features do work like e.g. the fan control, and toggling the 
state of the internal WLAN card with Fn-F8.

When I enter acpi -V, there's a line saying:

Cooling 0: LCD 6 of 7

I noticed that I can alter the value of 'Cooling 0: LCD 6 of 7' with 
Fn-F6/Fn-F7, but the brightness of the display does not change accordingly.

Fn-F3 and closing the lid crashes the system completely, enabling the 
VGA port output does not seem to work, Fn-ESC displays a symbol for 
muting toggled but it has no actual effect on the sound output.

I tried to manually load omnibook kernel module, as some pages suggested 
it supports Toshibas with non-Toshiba BIOSes, but it does not seem to do 
so and gives kernel error messages (omnibook: Unknown model).

I would be glad to provide additional information that might be needed 
by module developers to add support for the ACPI functions of the 
Toshiba Satellite Pro L770-116. I read that Toshiba may provide 
information for Linux developers too [1], which at least *sounds* good.

Thank you for reading, kind regards,

Thomas

   [1] http://linux.toshiba-dme.co.jp/linux/eng/develop.htm
