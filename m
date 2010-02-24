From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to support shared
 GPEs
Date: Wed, 24 Feb 2010 14:26:12 -0800
Message-ID: <20100224142612.772e4bcc@jbarnes-piketon>
References: <4911F71203A09E4D9981D27F9D83085859958760@orsmsx503.amr.corp.intel.com>
	<201002200018.02700.rjw@sisk.pl>
	<20100222162622.3d9c684a@jbarnes-piketon>
	<201002240052.08098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-158.bluehost.com ([67.222.39.38]:46451 "HELO
	outbound-mail-158.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758401Ab0BXW0G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Feb 2010 17:26:06 -0500
In-Reply-To: <201002240052.08098.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, Matthew Garrett <mjg@redhat.com>, "Brown, Len" <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>

On Wed, 24 Feb 2010 00:52:08 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday 23 February 2010, Jesse Barnes wrote:
> > On Sat, 20 Feb 2010 00:18:02 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > [Sorry for resending, tried to restore the CC list.]
> > > 
> > > On Friday 19 February 2010, Moore, Robert wrote:
> > > > 
> > > > Here's some comments and questions on the GPE changes in ACPICA.
> > > > Overall, looks good.
> > > 
> > > First of all, thanks a lot for the review.
> > 
> > I missed this one when applying the series, can you resend as an
> > incremental patch on top of linux-next?
> 
> Sure, appended.
> 
> Please note that it also fixes a bug I found earlier today.
> 
> I added a changelog in case you want to apply it as a separate patch.

Applied, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
