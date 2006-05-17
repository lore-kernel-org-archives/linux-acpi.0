From: "David Giddy" <d.giddy@bigpond.com>
Subject: RE: Help request on S3 resume problems
Date: Wed, 17 May 2006 15:55:07 +1000
Message-ID: <001101c67976$75f54d30$0400a8c0@vic.bigpond.net.au>
References: <CFF307C98FEABE47A452B27C06B85BB675ABCB@hdsmsx411.amr.corp.intel.com>
Reply-To: <d.giddy@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:15549 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932162AbWEQFz1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 May 2006 01:55:27 -0400
Received: from NewPC ([155.143.208.3]) by omta05sl.mx.bigpond.com with SMTP
          id <20060517055525.ILGL25409.omta05sl.mx.bigpond.com@NewPC>
          for <linux-acpi@vger.kernel.org>; Wed, 17 May 2006 05:55:25 +0000
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB675ABCB@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Len,

Thanks for the quick response. Unfortunately, I think in this instance that
the failure on resume IS related to the method of waking. Here are the
results of testing as you imply below:

Resume from S3 using power button	  -> 100% functional, both ttyS0 serial
console and NVIDIA video card console
Resume from S3 using WOL magic packet -> Fans run, disk activity, NO NVIDIA
video card console response, NO ttyS0 serial console response, NO ping
response
Resume from S5 using power button	  -> Normal boot
Resume from S5 using WOL magic packet -> Normal boot

I haven't tried wake from S4 as I don't currently have a swap partition
large enough to try it (1GB RAM).

Regards,

David.


-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org]On Behalf Of Brown, Len
Sent: Tuesday, 16 May 2006 4:35 PM
To: David Giddy; linux-acpi@vger.kernel.org
Subject: RE: Help request on S3 resume problems


I expect that the method to wake the system
and the fact that resume from S3 fails
are independent problems.

Likely you can use WOL from S5 and the system
will boot normally from poweroff.  (same can
be said for suspend-to-disk -- S4).

Likely you can wake the system from S4/S5 via
power or sleep button, and it will fail the same
way as it fails via WOL.

The way to debug an S3 resume with no video
is to use a serial or a firewire console.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

