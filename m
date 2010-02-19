From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to support shared GPEs
Date: Fri, 19 Feb 2010 22:08:24 +0100
Message-ID: <201002192208.24378.rjw@sisk.pl>
References: <201002172335.47703.rjw@sisk.pl> <201002182101.44171.rjw@sisk.pl> <4B7E3CC5.9040901@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4B7E3CC5.9040901@np.css.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Oliver Neukum <oliver@neukum.org>, Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Gary Hade <garyhade@us.ibm.com>
List-Id: linux-acpi@vger.kernel.org

On Friday 19 February 2010, Jin Dongming wrote:
> Hi, Rafael J. Wysocki
> 
> Rafael J. Wysocki wrote:
> > On Thursday 18 February 2010, Jin Dongming wrote:
> >> Hi, Rafael J. Wysocki
> >>> -	/* Update enable mask, but don't enable the HW GPE as of yet */
> >>> -
> >>> -	status = acpi_ev_enable_gpe(gpe_event_info, FALSE);
> > 
> > You could preserve some more context.
> > 
> >> I think the above line code should be remained. If it is deleted, the exception 
> >> event will be raised on some machine.
> > 
> > Why would it?  The GPE is still disabled at the hardware level at this point.
> > 
> > Rafael
> > 
> > 
> I am very sorry for my wrong comment. The GPE is still disabled as you wrote.
> 
> The error message what I got was not caused by GPE event, it was caused by the "status"
> variable which had not been deleted on x86-next tree. And it is also deleted at this
> file. So I don't there is problem here.

Great, thanks for the review.

Rafael
