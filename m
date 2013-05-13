From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: implement acpi_os_get_timer() according the spec
Date: Mon, 13 May 2013 14:44:32 +0300
Message-ID: <20130513114432.GK20562@intel.com>
References: <1368440871-27552-1-git-send-email-mika.westerberg@linux.intel.com>
 <9521576.ePuIMg9qsX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32100 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622Ab3EMLkY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 May 2013 07:40:24 -0400
Content-Disposition: inline
In-Reply-To: <9521576.ePuIMg9qsX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Mon, May 13, 2013 at 01:38:46PM +0200, Rafael J. Wysocki wrote:
> On Monday, May 13, 2013 01:27:51 PM Mika Westerberg wrote:
> > ACPI Timer() opcode should return monotonically increasing clock with 100ns
> > granularity. Implement this with the help of ktime_get().
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> That looks reasobable.  Have you tested it?

Very lightly. Basically I added some debug printks() between two
successsive calls of Timer() and it seemed like it returned correct time.

It is certainly better than returning t+1 every time Timer() is called :)
