From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-acpi: add SDHCI ACPI driver
Date: Fri, 23 Nov 2012 15:27:49 +0200
Message-ID: <20121123132749.GA3867@intel.com>
References: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
 <1353670561-22515-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36927 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab2KWNYb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Nov 2012 08:24:31 -0500
Content-Disposition: inline
In-Reply-To: <1353670561-22515-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 23, 2012 at 01:36:01PM +0200, Adrian Hunter wrote:
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Chris Ball <cjb@laptop.org>

Looks like you left that redundant check in place but it doesn't hurt
anyway.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
