From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 4/5] ACPI: disable SBS by default
Date: Sun, 9 Jul 2006 22:44:49 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFA23@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15129 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161307AbWGJCox convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 22:44:53 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Roman Zippel <zippel@linux-m68k.org>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, dtor@insightbb.com, dtor@mail.ru


>Default is 'n' when omitted...

This default stuff seems to be make-work
without any real value.

At one time we had default =m to try to show
what a reasonable usable configuration was.
These got globally replaced to =y because
apparently it is taboo to have default =m.

But =y defaults don't make much sense either,
particularly if you use =m like most people do.

The last time we discussed this, Roman suggested
deleting all the defaults that require human interaction.

As the concept appears to be meaningless, I'm inclined to agree.

-Len
