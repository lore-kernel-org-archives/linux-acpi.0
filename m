From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: evxfevnt glitch
Date: Wed, 12 Jul 2006 15:58:52 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1D28E81@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18341 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750809AbWGLH7c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2006 03:59:32 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org

what kernel you are using?

Is it due to a patch to reboot box with ACPI FADT reset register?

Thanks,
Luming=20

-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Andrew Morton
Sent: 2006=C4=EA7=D4=C212=C8=D5 15:53
To: linux-acpi@vger.kernel.org
Subject: evxfevnt glitch


I have an old machine which doesn't use ACPI.  During a reboot (sysrq-B=
)
I get

ACPI Warning (evxfevnt-0115): No FADT information present! [20060707]

It shouldn't print that if ACPI has disabled itself.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
