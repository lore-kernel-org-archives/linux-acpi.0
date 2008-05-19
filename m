From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/5] pci-acpi: improvement for _OSC evaluation
Date: Mon, 19 May 2008 15:27:51 -0700
Message-ID: <200805191527.51549.jbarnes@virtuousgeek.org>
References: <482BD572.30504@jp.fujitsu.com> <200805161100.06049.jbarnes@virtuousgeek.org> <1211167762.2836.0.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-34.bluehost.com ([69.89.18.154]:55720 "HELO
	outbound-mail-34.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756767AbYESW2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 May 2008 18:28:04 -0400
In-Reply-To: <1211167762.2836.0.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Sunday, May 18, 2008 8:29 pm Shaohua Li wrote:
> On Fri, 2008-05-16 at 11:00 -0700, Jesse Barnes wrote:
> > On Wednesday, May 14, 2008 11:17 pm Kenji Kaneshige wrote:
> > > Hi,
> > >
> > > Here are some improvement patches for _OSC evaluation on PCI.
> > >
> > > - [PATCH 1/5] pci-acpi: remove duplicate code for _OSC
> > > - [PATCH 2/5] pci-acpi: use local buffer for _OSC
> > > - [PATCH 3/5] pci-acpi: add flag to indicate query had been done
> > > - [PATCH 4/5] pci-acpi: remove unused variable in __pci_osc_support_set
> > > - [PATCH 5/5] pci-acpi: minor cleanups for _OSC
> > >
> > > For details, please see the header of each patch.
> >
> > These cleanups look nice; Shaohua maybe you could take a look too and
> > ack/nack?
>
> Looks good. ACKed.

Great, thanks for the review.  Applied to linux-next.

Thanks,
Jesse
