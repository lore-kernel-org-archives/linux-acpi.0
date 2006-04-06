From: Felix Kuehling <fkuehlin@ati.com>
Subject: Power-button event after resume from S3
Date: Thu, 06 Apr 2006 16:12:08 -0400
Message-ID: <1144354328.30190.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-red.frontbridge.com ([216.148.222.49]:35509 "EHLO
	outbound2-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751143AbWDFUMM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Apr 2006 16:12:12 -0400
Received: from outbound2-red.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-red-R.bigfish.com (Postfix) with ESMTP id F026E9D0D41
	for <linux-acpi@vger.kernel.org>; Thu,  6 Apr 2006 20:12:09 +0000 (UTC)
Received: from mail95-red-R.bigfish.com (unknown [172.18.12.1])
	by outbound2-red.bigfish.com (Postfix) with ESMTP id EECFE9D0D0E
	for <linux-acpi@vger.kernel.org>; Thu,  6 Apr 2006 20:12:09 +0000 (UTC)
Received: from mail95-red.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail95-red-R.bigfish.com (Postfix) with ESMTP id DDB164DB187
	for <linux-acpi@vger.kernel.org>; Thu,  6 Apr 2006 20:12:09 +0000 (UTC)
Received: from mail4.ati.com (h209-50-91-134.gtconnect.net [209.50.91.134])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail95-red.bigfish.com (Postfix) with ESMTP id AA7B74DAF0B
	for <linux-acpi@vger.kernel.org>; Thu,  6 Apr 2006 20:12:09 +0000 (UTC)
Received: from torcaexgw1.atitech.com (exchange.atitech.com [172.24.5.245])
	by mail4.ati.com (8.13.1/8.13.1) with ESMTP id k36KC8V1009115
	for <linux-acpi@vger.kernel.org>; Thu, 6 Apr 2006 16:12:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>

Hi,

I am investigating a problem where acpid receives a power-button event
immediately after resuming from S3. I looked at the mailing list
archives and found that this problem is not entirely uncommon. The
advice users got so far all looked like workarounds for the real
problem. The same goes for
http://bugzilla.kernel.org/show_bug.cgi?id=3525, which further declares
it as a bug in acpid. However, I'm not sure it is really a bug in acpid.

This is my understanding:

The only ways for acpid to distinguish power-up and power-down are hacks
that somehow remember that the system is going into suspend and to
ignore the next power button event. However, there is no guarantee that
there will be such an event after resuming, so you need some kind of a
time-out. All that doesn't feel very robust to me and that's why I'm
calling it a hack.

The kernel on the other hand has more information. It could reliably
distinguish power-up and power-down events. The first SCI interrupt
after resume always seems to be the power-up event, no time-out
required. Thus it could generate different events for power-up and
power-down in /proc/acpi/event. That would make it much easier and
cleaner for acpid to distinguish them and take the appropriate action.

Finally my assumption is that it is correct behaviour for the ACPI
hardware to report the power-button to the OS on resuming from S3. I
came to that conclusion after reading parts of the ACPI 2.0 spec. Please
confirm.

Are there plans for a real fix for this problem, either in the kernel or
in acpid?

Thanks,
  Felix

P.S.: Please include the CC-list on replies.



