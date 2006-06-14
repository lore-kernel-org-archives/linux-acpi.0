From: "Brown, Len" <len.brown@intel.com>
Subject: RE: nx6125 battery issues
Date: Wed, 14 Jun 2006 12:36:22 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6BCAE3E@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23590 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750826AbWFNQgi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2006 12:36:38 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cyril Scetbon <cyril.scetbon@free.fr>, linux-acpi@vger.kernel.org

The NX6125 was screwed up enough that we went out and bought one.

After verifying you have the latest BIOS, you might look here:

http://bugzilla.kernel.org/show_bug.cgi?id=5534
and
http://bugzilla.kernel.org/show_bug.cgi?id=6455

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Cyril Scetbon
>Sent: Wednesday, June 14, 2006 10:58 AM
>To: linux-acpi@vger.kernel.org
>Subject: nx6125 battery issues
>
>Hi people,
>
>I got a laptop nx6125 and acpi is not able to refresh battery status.
>If I boot with ac on acpi sees that the battery is charging in  
>/proc/acpi/battery/C179/*
>But if I unplug the ac, acpi sees that the battery is charged and 
>whatever I do after the state is not modified !!!
>
>I use kernel 2.6.17-rc6, and U can see my dmesg output.
>
>Thanks.
>
>
>
