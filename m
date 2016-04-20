From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / APD: Remove CLK_IS_ROOT
Date: Wed, 20 Apr 2016 13:09:57 +0300
Message-ID: <20160420100957.GM1725@lahna.fi.intel.com>
References: <1461115666-30906-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:3565 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933452AbcDTKKD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Apr 2016 06:10:03 -0400
Content-Disposition: inline
In-Reply-To: <1461115666-30906-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ken Xue <Ken.Xue@amd.com>

On Tue, Apr 19, 2016 at 06:27:46PM -0700, Stephen Boyd wrote:
> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
> 
> Cc: Ken Xue <Ken.Xue@amd.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
