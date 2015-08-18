From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/1] ACPI / osl: replace custom implementation of
 readq / writeq
Date: Tue, 18 Aug 2015 16:49:40 +0300
Message-ID: <20150818134940.GN1552@lahna.fi.intel.com>
References: <1439821726-146561-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25478 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbbHRNtu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Aug 2015 09:49:50 -0400
Content-Disposition: inline
In-Reply-To: <1439821726-146561-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Mon, Aug 17, 2015 at 05:28:46PM +0300, Andy Shevchenko wrote:
> The readq() and writeq() helpers are available in the
> asm-generic/io-64-nonatomic-hi-lo.h and asm-generic/io-64-nonatomic-lo-hi.h
> headers. Replace custom implementation by the generic helpers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
