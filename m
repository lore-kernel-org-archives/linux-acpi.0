From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] ACPI / ACPICA: Disable GPEs during initialization
Date: Tue, 28 Dec 2010 10:49:43 +0100
Message-ID: <201012281049.43624.rjw@sisk.pl>
References: <1293403143-11922-1-git-send-email-lenb@kernel.org> <201012272116.23678.rjw@sisk.pl> <1293497455.2565.328.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58549 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588Ab0L1JuX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Dec 2010 04:50:23 -0500
In-Reply-To: <1293497455.2565.328.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Tuesday, December 28, 2010, Lin Ming wrote:
> On Tue, 2010-12-28 at 04:16 +0800, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The patch below is needed in the ACPICA core.
> 
> Thanks, and I'm also looking at below patch
> 
> ACPI / ACPICA: Fix global lock acquisition
> https://bugzilla.novell.com/show_bug.cgi?id=637377#c82

OK, thanks!

I guess I should send it to the list, then.

Rafael
