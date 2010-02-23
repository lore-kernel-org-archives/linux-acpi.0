From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to support shared
 GPEs
Date: Mon, 22 Feb 2010 16:26:22 -0800
Message-ID: <20100222162622.3d9c684a@jbarnes-piketon>
References: <4911F71203A09E4D9981D27F9D83085859958760@orsmsx503.amr.corp.intel.com>
	<201002200018.02700.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201002200018.02700.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, Matthew Garrett <mjg@redhat.com>, "Brown, Len" <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 20 Feb 2010 00:18:02 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> [Sorry for resending, tried to restore the CC list.]
> 
> On Friday 19 February 2010, Moore, Robert wrote:
> > 
> > Here's some comments and questions on the GPE changes in ACPICA.
> > Overall, looks good.
> 
> First of all, thanks a lot for the review.

I missed this one when applying the series, can you resend as an
incremental patch on top of linux-next?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
