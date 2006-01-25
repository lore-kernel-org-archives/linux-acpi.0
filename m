From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 0/2] Deliver ACPI events upon subscription and implement multiple readers for /proc/acpi/event
Date: Tue, 24 Jan 2006 20:17:07 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005D29F8D@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr15.intel.com ([192.55.52.69]:39320 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750751AbWAYBRP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2006 20:17:15 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>

What's the problem with opening a socket to the user-space acpid --
the way multiple readers work today?

thanks,
-Len
