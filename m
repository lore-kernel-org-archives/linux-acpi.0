From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI-related problem with resuming from RAM
Date: Sun, 30 Jul 2006 11:43:11 +0200
Message-ID: <200607301143.11698.rjw@sisk.pl>
References: <200607301140.09836.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:13956 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932158AbWG3Jn3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 05:43:29 -0400
In-Reply-To: <200607301140.09836.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Sunday 30 July 2006 11:40, Rafael J. Wysocki wrote:
> Hi,
> 
> To make my box (Asus L5D, x86_64) resume from RAM, I have to unload all of the
> ACPI-related modules and the ohci_hcd module before the suspend.
> 
> Also, I can't reload the ohci_hcd module after the resume, because if I try,
> the system crashes with the appended trace.

The kernel is 2.6.18-rc2-mm1.
