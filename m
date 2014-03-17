From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 5/5] gpio / ACPI: Add support for ACPI GPIO operation
 regions
Date: Mon, 17 Mar 2014 11:44:34 +0200
Message-ID: <20140317094434.GA19349@intel.com>
References: <1394456094-21671-6-git-send-email-mika.westerberg@linux.intel.com>
 <1394812687-12715-1-git-send-email-mika.westerberg@linux.intel.com>
 <CACRpkdYyBgL0W5cYpAEQZzc7u5K4yEBOr5hD5gDFFPBYvxkgqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62319 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485AbaCQJhA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Mar 2014 05:37:00 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYyBgL0W5cYpAEQZzc7u5K4yEBOr5hD5gDFFPBYvxkgqQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>, Lv Zheng <lv.zheng@intel.com>, Alan Cox <alan.cox@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Mar 14, 2014 at 05:25:39PM +0100, Linus Walleij wrote:
> On Fri, Mar 14, 2014 at 4:58 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > GPIO operation regions is a new feature introduced in ACPI 5.0
> > specification. This feature adds a way for platform ASL code to call back
> > to OS GPIO driver and toggle GPIO pins.
> 
> OK this version of the patch applied!

Thanks!
