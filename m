From: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v3 1/5] acpi, nfit: Switch to use new generic UUID API
Date: Wed, 7 Jun 2017 12:17:01 +0200
Message-ID: <20170607101701.GA28877@lst.de>
References: <20170605164046.82676-1-andriy.shevchenko@linux.intel.com> <20170605164046.82676-2-andriy.shevchenko@linux.intel.com> <CAPcyv4h4PY1JBxTB6Powf2y2uiHAZ4QtnZG16bBzdQqsQ2KAYQ@mail.gmail.com> <1496682642.22624.23.camel@linux.intel.com> <20170605212250.GA3772@lst.de> <1496816744.6978.6.camel@intel.com> <1496828271.22624.38.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51653 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdFGKRD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Jun 2017 06:17:03 -0400
Content-Disposition: inline
In-Reply-To: <1496828271.22624.38.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "hch@lst.de" <hch@lst.de>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "bp@suse.de" <bp@suse.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Jun 07, 2017 at 12:37:51PM +0300, Andy Shevchenko wrote:
> It think we may fold it.

Yes, I'll fold it and delcare the tree stable late tonight my time.

> Besides that we might need the following fix as well.

Yeah.  Another reasone why buffer.pointer should be a void pointer.
