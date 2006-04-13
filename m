From: Andreas Saur <saur@acmelabs.de>
Subject: RE: RE: Failed resuming IDE from S3 on Abit NF7 (nForce2)
Date: Thu, 13 Apr 2006 14:21:40 +0200
Message-ID: <443E4254.3060008@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natipslore.rzone.de ([81.169.145.179]:4513 "EHLO
	natipslore.rzone.de") by vger.kernel.org with ESMTP id S964880AbWDMMVy
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 08:21:54 -0400
Received: from server.zuhause.xx (p508138F7.dip0.t-ipconnect.de [80.129.56.247])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k3DCLihF012028
	for <linux-acpi@vger.kernel.org>; Thu, 13 Apr 2006 14:21:45 +0200 (MEST)
Received: from server.zuhause.xx ([192.168.1.2] helo=[127.0.0.1])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1FU0r6-00018x-F2
	for linux-acpi@vger.kernel.org; Thu, 13 Apr 2006 14:23:27 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

    Dear Luming,

the bug you are refering to, seems pretty much the same bug like I do 
have here. But I've got two questions. Could you please help me? And I 
do asume, that this patch isn't in the resent kernel yet, isn't it?

1) If I want to adopt your patch, I should use the values from my 
acpidump, but I can't find anything reasonable. What should my values 
look like? (see here: 
http://bugzilla.kernel.org/attachment.cgi?id=7762&action=view )

2) How do I ensure, that this native IDE driver is really used? Do I 
have to uncheck all non-native IDE drivers in the kernel config? (In my 
case it's the amd71xx, I guess)

Please excuse the silly questions, but I am pretty new to game of kernel 
configuration and compilation, but steady learning :-)

Thank you very much.

Refering to:
----------------------------------------------------------------------
 >>Bugzilla:
 >>   http://bugzilla.kernel.org/show_bug.cgi?id=5604#c19ide_sleep.dpatch
 >>
 >>Patch:
 >>   http://www.codon.org.uk/~mjg59/tmp/external-drivers-ide_sleep.dpatch
 >>
 >>------- Additional Comment #17 From Luming Yu  2005-11-18 07:49 -------
 >>
 >>The ide patch mentioned in comment#16 is not complete yet.
 >>That is the reason for ACPI HANDLE IS NULL.
 >>
 >>So, It's not surprise it doesn't work.
 >>Could you try to remove error detecting code before invoking _GTM and 
_STM
 >>And hardcode with :
 >>
 >>For invoking _GTM:
 >>
 >>{
 >>acpi_handle tmp;
 >>acpi_get_handle(NULL, \\_SB.C002.C0A6.C1D5, &tmp);
 >>status = acpi_evaluate_object(tmp, "_GTM", NULL, &buffer);
 >>...
 >>}
 >>
 >>For invoking _STM:
 >>
 >>{
 >>acpi_handle tmp;
 >>acpi_get_handle(NULL, \\_SB.C002.C0A6.C1D5, &tmp);
 >>status = acpi_evaluate_object(stat->handle, "_STM", &input, NULL);
 >>..
 >>}
----------------------------------------------------------------------
