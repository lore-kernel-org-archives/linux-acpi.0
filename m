From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset in acpi_read/write
Date: Tue, 15 Nov 2011 17:49:53 +0100
Message-ID: <201111151749.53917.trenn@suse.de>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com> <20111111230513.20897.36014.stgit@bhelgaas.mtv.corp.google.com> <CAErSpo7SJNM73ei5aN=9UCsvgU6OZoupWUoUP3Hts3GGfwE37A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36988 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169Ab1KOQt5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Nov 2011 11:49:57 -0500
In-Reply-To: <CAErSpo7SJNM73ei5aN=9UCsvgU6OZoupWUoUP3Hts3GGfwE37A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Myron Stowe <myron.stowe@redhat.com>

On Tuesday, November 15, 2011 04:13:15 PM Bjorn Helgaas wrote:
> On Fri, Nov 11, 2011 at 4:05 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > acpi_read(), acpi_write(), acpi_hw_read(), and acpi_hw_write() currently
> > ignore the GAS bit_offset field (but they do warn if it is non-zero).
> >
> > APEI tables are starting to use non-zero bit_offsets.  APEI uses
> > special-purpose apei_exec_read_register() and apei_exec_write_register()
> > interfaces that apply the bit_offset.
> >
> > This patch adds bit_offset support to the generic interfaces, which is
> > one small step toward using them instead of the special-purpose APEI ones.
> 
> Eww, brown paper bag time.  Just pretend you never saw this lame
> implementation attempt.
> 
> I do think we need to make acpi_read() smart enough to extract a bit
> field, but this try doesn't work.

As a first step it would be great if Ying's and Myron's patches which
afaik conflict get serialized and pushed into an "acpi branch".
What the status there?

I'd like to add access width support to the APEI parts on top then.

Thanks,

   Thomas
