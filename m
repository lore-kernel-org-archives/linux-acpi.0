From: "Kamala Narasimhan" <Kamala.Narasimhan@citrix.com>
Subject: Ways to inject system reset in resume code path
Date: Wed, 7 Jan 2009 22:28:42 -0500
Message-ID: <0519110A9448BC429B231AD118D7270803161A64@FTLPEXCH05.citrite.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:24700 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZAHD2n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jan 2009 22:28:43 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Is there a sure bet way to -

1) Cause a system reset by setting the 32-bit FACS waking vector to a
particular address?  Setting it to 0xffff0 did not help as hoped.
2) Failing that, is there a way to cause a system reset by tweaking the
16-bit wakeup code?  While zero length idt always causes a system reset
in protected mode, the same won't work in real mode.  Keyboard reset
approach also did not work in real mode for some reason.  It would be
nice to know if there is a trick similar to zero length idt that could
be used in real mode that is sure to cause system reset early on in the
real mode wakeup code path.

I normally inject system reset code at different points in the early
wakeup code path to troubleshoot resume issues and information on the
above will help better troubleshoot some S3 resume issues I encounter.

Thanks,
Kamala
