From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [BUG] nvidia vga card is missed after S3
Date: Tue, 01 Apr 2008 08:58:41 +0800
Message-ID: <1207011521.25182.0.camel@sli10-desk.sh.intel.com>
References: <1206691229.1362.5.camel@sli10-desk.sh.intel.com>
	 <200804010102.59665.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19901 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbYDAA5o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Mar 2008 20:57:44 -0400
In-Reply-To: <200804010102.59665.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>


On Tue, 2008-04-01 at 01:02 +0200, Rafael J. Wysocki wrote:
> On Friday, 28 of March 2008, Shaohua Li wrote:
> > Still in ASUS A6VC laptop (linux is quite broken in the system). If
> > 'pm_restore_console()' is called the video card (03:00.0, Nevidia Go
> > 6200/6400, it hasn't a driver) pci config space read is messy (some are
> > 0xffffffff, others are 0). If I comment pm_restore_console(), then
> > everything is fine. Anything I can provide to debug the issue?
> 
> Hmm.  Do you suspend the box from under X or crom the console?
from console.

