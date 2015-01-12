From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: check the result of ioremap
Date: Mon, 12 Jan 2015 09:28:04 +0200
Message-ID: <20150112072804.GA18246@kuha.fi.intel.com>
References: <1420703845-85859-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1758606.yZCgaz5aih@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52959 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbbALHaP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2015 02:30:15 -0500
Content-Disposition: inline
In-Reply-To: <1758606.yZCgaz5aih@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Sun, Jan 11, 2015 at 11:35:30PM +0100, Rafael J. Wysocki wrote:
> On Thursday, January 08, 2015 09:57:25 AM Heikki Krogerus wrote:
> > If it fails we have to skip the device.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> "stable" stuff?  Which version if so?

Not stable stuff. v3.20.

Cheers,

-- 
heikki
