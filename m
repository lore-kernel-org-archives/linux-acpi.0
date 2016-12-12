From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V3] i2c: designware: fix wrong tx/rx fifo for ACPI
Date: Mon, 12 Dec 2016 21:21:13 +0200
Message-ID: <20161212192113.GA1460@lahna.fi.intel.com>
References: <1481531810-31695-1-git-send-email-tnhuynh@apm.com>
 <1481569373.7188.48.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52522 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752657AbcLLTX2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Dec 2016 14:23:28 -0500
Content-Disposition: inline
In-Reply-To: <1481569373.7188.48.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tin Huynh <tnhuynh@apm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

On Mon, Dec 12, 2016 at 09:02:53PM +0200, Andy Shevchenko wrote:
> > +	tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
> > +	rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
> > +	if (!dev->tx_fifo_depth) {
> > +		dev->tx_fifo_depth = tx_fifo_depth;
> > +		dev->rx_fifo_depth = rx_fifo_depth;
> > +	} else if (tx_fifo_depth) {
> > +		dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
> > +				tx_fifo_depth);
> > +		dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
> > +				rx_fifo_depth);
> > +	}
> 
> So, let's clarify here:
> Is it possible to have an IP without parameter block enabled? I mean to
> read something arbitrary (or zeroes, or all-ones) from param1.

Yes and it is Intel IP. Haswell IIRC and it returned zeroes.
