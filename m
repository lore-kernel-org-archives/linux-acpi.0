From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / APD: Remove CLK_IS_ROOT
Date: Wed, 04 May 2016 23:12:08 +0200
Message-ID: <1733358.WWnG5RucIq@vostro.rjw.lan>
References: <1461115666-30906-1-git-send-email-sboyd@codeaurora.org> <20160420100957.GM1725@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59729 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751844AbcEDVI5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2016 17:08:57 -0400
In-Reply-To: <20160420100957.GM1725@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ken Xue <Ken.Xue@amd.com>

On Wednesday, April 20, 2016 01:09:57 PM Mika Westerberg wrote:
> On Tue, Apr 19, 2016 at 06:27:46PM -0700, Stephen Boyd wrote:
> > This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> > CLK_IS_ROOT", 2016-02-02) so remove it.
> > 
> > Cc: Ken Xue <Ken.Xue@amd.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!

