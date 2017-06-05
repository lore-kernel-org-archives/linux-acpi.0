From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/5] acpi, nfit: Switch to use new generic UUID API
Date: Mon, 5 Jun 2017 23:22:50 +0200
Message-ID: <20170605212250.GA3772@lst.de>
References: <20170605164046.82676-1-andriy.shevchenko@linux.intel.com> <20170605164046.82676-2-andriy.shevchenko@linux.intel.com> <CAPcyv4h4PY1JBxTB6Powf2y2uiHAZ4QtnZG16bBzdQqsQ2KAYQ@mail.gmail.com> <1496682642.22624.23.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42384 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbdFEVWw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 17:22:52 -0400
Content-Disposition: inline
In-Reply-To: <1496682642.22624.23.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org

On Mon, Jun 05, 2017 at 08:10:42PM +0300, Andy Shevchenko wrote:
> I hope Christoph can replace old version of this series with new one in
> his uuid branch. URL in cover letter, repeating for your convenience:
> 
> [1]: git://git.infradead.org/users/hch/uuid.git

Yeah, but I had to drop it again after noticing the guid_equals bits,
and after not fixing up the GUID -> GUID_INIT rename.

for-next in the above repo should have the proper base now, and acpi
has the ACPI bits for Dan to test.
