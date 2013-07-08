From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI errors from TPM PPI
Date: Mon, 8 Jul 2013 17:13:01 +0100
Message-ID: <20130708161301.GA611@srcf.ucam.org>
References: <CAMfhd9XWfp420M9wF-ACya9hbQGUSkneRB6sry9=nj1KtB_ygw@mail.gmail.com>
 <10172565.WQexNecTHe@vostro.rjw.lan>
 <CAMfhd9U6qvm2kTb2D8PgzR8qCqZnDWhLNC4Ojzftc8PdmKwjnA@mail.gmail.com>
 <20130706111025.GZ4898@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51557 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab3GHQNZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jul 2013 12:13:25 -0400
Content-Disposition: inline
In-Reply-To: <20130706111025.GZ4898@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Adam Langley <agl@imperialviolet.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, xiaoyan.zhang@intel.com, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sat, Jul 06, 2013 at 02:10:25PM +0300, Mika Westerberg wrote:

> I wonder whether there is a real PNP Id associated with that device?

You'd really hope so - it's certainly completely bogus to rely on the 
device name. On the other hand, this is basically re-probing for a 
device that the kernel already knows about. Just exporting the device 
from tpm_tis would make more sense.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
