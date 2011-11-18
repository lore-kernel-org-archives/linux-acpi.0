From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure
 bit_offset in acpi_read/write
Date: Fri, 18 Nov 2011 09:04:39 +0800
Message-ID: <1321578279.13860.108.camel@yhuang-dev>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
	 <201111170027.14509.rjw@sisk.pl> <1321491083.13860.93.camel@yhuang-dev>
	 <201111172127.40664.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19148 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab1KRBEo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Nov 2011 20:04:44 -0500
In-Reply-To: <201111172127.40664.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

On Fri, 2011-11-18 at 04:27 +0800, Rafael J. Wysocki wrote:
> On Thursday, November 17, 2011, Huang Ying wrote:
> > On Thu, 2011-11-17 at 07:27 +0800, Rafael J. Wysocki wrote:
> > > On Wednesday, November 16, 2011, Bjorn Helgaas wrote:
> > > > On Tue, Nov 15, 2011 at 9:49 AM, Thomas Renninger <trenn@suse.de> wrote:
> > > > > On Tuesday, November 15, 2011 04:13:15 PM Bjorn Helgaas wrote:
> > > > >> On Fri, Nov 11, 2011 at 4:05 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > > > >> > acpi_read(), acpi_write(), acpi_hw_read(), and acpi_hw_write() currently
> > > > >> > ignore the GAS bit_offset field (but they do warn if it is non-zero).
> > > > >> >
> > > > >> > APEI tables are starting to use non-zero bit_offsets.  APEI uses
> > > > >> > special-purpose apei_exec_read_register() and apei_exec_write_register()
> > > > >> > interfaces that apply the bit_offset.
> > > > >> >
> > > > >> > This patch adds bit_offset support to the generic interfaces, which is
> > > > >> > one small step toward using them instead of the special-purpose APEI ones.
> > > > >>
> > > > >> Eww, brown paper bag time.  Just pretend you never saw this lame
> > > > >> implementation attempt.
> > > > >>
> > > > >> I do think we need to make acpi_read() smart enough to extract a bit
> > > > >> field, but this try doesn't work.
> > > > >
> > > > > As a first step it would be great if Ying's and Myron's patches which
> > > > > afaik conflict get serialized and pushed into an "acpi branch".
> > > > > What the status there?
> > > > 
> > > > Ying's patch ("Add RAM mapping support") fixes a real issue with using
> > > > EINJ, so we need to do something with it.
> > > 
> > > I kind of agree, but I wonder if page_is_ram() is the right check?
> > 
> > page_is_ram() is used by x86 ioremap implementation to exclude RAM
> > range.  So I think it can be used here.
> 
> Except that ACPI is not going to be x86-specific any more in the (near?)
> future.  Have you taken that into consideration?

Take a look at ARM ioremap implementation.  It appears that RAM can be
ioremaped on ARM.  But this changes should be harmless for ARM too.
Because ioremap implementation is different between different
architecture, maybe we should use #ifdef CONFIG_X86, #endif to enclose
the code?

Best Regards,
Huang Ying


