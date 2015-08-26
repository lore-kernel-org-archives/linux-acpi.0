From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/1] ACPI / osl: replace custom implementation of readq / writeq
Date: Wed, 26 Aug 2015 02:09:21 +0200
Message-ID: <2031719.BJ8i8cg2CT@vostro.rjw.lan>
References: <1439821726-146561-1-git-send-email-andriy.shevchenko@linux.intel.com> <20150818134940.GN1552@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47908 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756112AbbHYXls (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Aug 2015 19:41:48 -0400
In-Reply-To: <20150818134940.GN1552@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org

On Tuesday, August 18, 2015 04:49:40 PM Mika Westerberg wrote:
> On Mon, Aug 17, 2015 at 05:28:46PM +0300, Andy Shevchenko wrote:
> > The readq() and writeq() helpers are available in the
> > asm-generic/io-64-nonatomic-hi-lo.h and asm-generic/io-64-nonatomic-lo-hi.h
> > headers. Replace custom implementation by the generic helpers.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
