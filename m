From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Powers off after suspen to mem
Date: Mon, 13 Mar 2006 22:50:01 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30065E13EC@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:47031 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932556AbWCNDu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Mar 2006 22:50:28 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Brow <dan@fullmotions.com>, linux-acpi@vger.kernel.org

rmmod button
before the suspend.

or resume by opening the lid instead of pressing the power button. 

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Danny Brow
>Sent: Monday, March 13, 2006 10:05 PM
>To: linux-acpi@vger.kernel.org
>Subject: Powers off after suspen to mem
>
>If I suspend to memory, ie. echo -n "mem" > /sys/power/state, upon a
>resume (when I hit any key) my laptop just powers off, I see my X
>session and the it drops to console and turns off. I'm running a 2.6.15
>kernel with acpi patch for 2.6.15. My system is an Acer aspire 
>1694wlmi,
>custom dsdt file.
>
>Thanks,
>Dan.
>
>ps. I'm not on the list could you please cc me on your reply.
>
>
>-- 
>This message has been scanned for viruses and
>dangerous content by MailScanner, and is
>believed to be clean.
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
