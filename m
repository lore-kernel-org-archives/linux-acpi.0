From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: USB suspend/resume in linux
Date: Fri, 13 Oct 2006 11:13:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0610131110550.6612-100000@iolanthe.rowland.org>
References: <0FB24CC078F78248B19595A43F00E01FD92DF3@fmsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:3595 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751151AbWJMPNi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 11:13:38 -0400
In-Reply-To: <0FB24CC078F78248B19595A43F00E01FD92DF3@fmsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kaburlasos, Nikos" <nikos.kaburlasos@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, trenn@suse.de, linux-acpi@vger.kernel.org

On Fri, 13 Oct 2006, Kaburlasos, Nikos wrote:

> Alan, will the 2.6.19-rc1 fix you mention also place USB controllers in
> D3 (after all the ports under them are in suspend) to save a bit of
> extra power?

No.  My work affects only the USB stack.  The controllers belong to the 
PCI stack.

There's another reason not to do this: Power Management Event handling for
PCI devices isn't working.  So the controller would not automatically go
back into D0 when you plugged in a new USB device.

Alan Stern

