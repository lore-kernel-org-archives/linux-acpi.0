From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: problem about ACPI processor procfs
Date: Tue, 27 Feb 2007 17:33:46 +0800
Message-ID: <58A36151585E4047913F40517D307BAE43BDE8@pdsmsx404.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23211 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161108AbXB0JfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Feb 2007 04:35:14 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

Hello, list

I met some problems when duplicating ACPI processor procfs interface in=
 sysfs.
#cat /proc/acpi/processor/CPU0/limit
Active limit:		P0:T0
User limit:		P0:T0
Thermal limit:	P0,T0

IMO, "Tx" is easy to understand. It indicates the active T-state, T-sta=
te set by user and T-state set by thermal (in passive mode).

But what does the "Px" stand for? After reading the code in processor_t=
hermal.c, I don't think user or thermal will change its value.
And I don't know if it's still needed when porting to sysfs.

Best regards,
Zhang.Rui(Ray)
=A0
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
