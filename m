From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Temporarily disable ACPI (hibernate, standby) via module
Date: Wed, 1 Mar 2006 19:28:27 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063BFA14@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:17337 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751152AbWCBA2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 19:28:32 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: c.thilo@gmx.de, linux-acpi@vger.kernel.org


>I'm working at a module for bios flashing. Now my prob. is, when the
>computer wants to go in a not useful power state during the 
>flash, would not be nice.

please define "not useful power state"

you can disable P-states and C-states at run-time, if that
is what you're looking for.  Note that the same problem
will exist without ACPI.

-Len
