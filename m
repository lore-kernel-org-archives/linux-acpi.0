From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI errors from TPM PPI
Date: Tue, 9 Jul 2013 11:54:57 +0300
Message-ID: <20130709085457.GG4898@intel.com>
References: <CAMfhd9XWfp420M9wF-ACya9hbQGUSkneRB6sry9=nj1KtB_ygw@mail.gmail.com>
 <10172565.WQexNecTHe@vostro.rjw.lan>
 <CAMfhd9U6qvm2kTb2D8PgzR8qCqZnDWhLNC4Ojzftc8PdmKwjnA@mail.gmail.com>
 <20130706111025.GZ4898@intel.com>
 <20130708161301.GA611@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60585 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167Ab3GIItb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jul 2013 04:49:31 -0400
Content-Disposition: inline
In-Reply-To: <20130708161301.GA611@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Adam Langley <agl@imperialviolet.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, xiaoyan.zhang@intel.com, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Jul 08, 2013 at 05:13:01PM +0100, Matthew Garrett wrote:
> On Sat, Jul 06, 2013 at 02:10:25PM +0300, Mika Westerberg wrote:
> 
> > I wonder whether there is a real PNP Id associated with that device?
> 
> You'd really hope so - it's certainly completely bogus to rely on the 
> device name. On the other hand, this is basically re-probing for a 
> device that the kernel already knows about. Just exporting the device 
> from tpm_tis would make more sense.

Indeed, you are right. I didn't even check whether there already exists a
driver for that.
