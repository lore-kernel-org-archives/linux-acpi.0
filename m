From: "Brown, Len" <len.brown@intel.com>
Subject: RE: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Tue, 31 Jan 2006 21:36:16 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005E8FE81@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:39320 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S964894AbWBACgY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2006 21:36:24 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: Marco Giumelli <mr.giumo@gmail.com>, linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

>> If I were to hack the DSDT, probably a more interesting thing to do
>> would be fill in CPSS with some of the entries from PPSS to give
>> your system P-states when on AC power.
>
>What exactly would that provide?

It would provide power savings when on AC power.
While you might not notice this in your utility bill,
you may notice it in the tempearture or fan speed
of the system.

-Len
