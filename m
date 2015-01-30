From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: check the result of ioremap
Date: Fri, 30 Jan 2015 01:06:51 +0100
Message-ID: <1860698.QtcepARTPl@vostro.rjw.lan>
References: <1420703845-85859-1-git-send-email-heikki.krogerus@linux.intel.com> <1758606.yZCgaz5aih@vostro.rjw.lan> <20150112072804.GA18246@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49653 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752349AbbA2XoD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jan 2015 18:44:03 -0500
In-Reply-To: <20150112072804.GA18246@kuha.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Monday, January 12, 2015 09:28:04 AM Heikki Krogerus wrote:
> On Sun, Jan 11, 2015 at 11:35:30PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, January 08, 2015 09:57:25 AM Heikki Krogerus wrote:
> > > If it fails we have to skip the device.
> > > 
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > "stable" stuff?  Which version if so?
> 
> Not stable stuff. v3.20.

Queued up for 3.20 then, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
