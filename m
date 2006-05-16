From: "Brown, Len" <len.brown@intel.com>
Subject: RE:  Help request on S3 resume problems
Date: Tue, 16 May 2006 02:34:52 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB675ABCB@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23327 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751526AbWEPGfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2006 02:35:03 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Giddy <d.giddy@bigpond.com>, linux-acpi@vger.kernel.org

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
