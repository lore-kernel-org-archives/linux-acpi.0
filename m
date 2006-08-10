From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Date: Thu, 10 Aug 2006 16:54:57 -0400
Message-ID: <200608101654.58358.len.brown@intel.com>
References: <20060804213230.D5D4.Y-GOTO@jp.fujitsu.com> <20060810142329.EB03.Y-GOTO@jp.fujitsu.com> <44DB965A.3050208@redhat.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:27611 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932150AbWHJUxl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Aug 2006 16:53:41 -0400
In-Reply-To: <44DB965A.3050208@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, akpm@osdl.org, keith mannthey <kmannth@us.ibm.com>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>

On Thursday 10 August 2006 16:26, Prarit Bhargava wrote:
> 
> Yasunori Goto wrote:
> > Hello.
> >
> > I would like to repost this patch to remove noisy useless message at boot
> > time from 2.6.18-rc4.
> > (I said "-mm doesn't shows this message in previous post", but it was wrong.
> >  This messages are shown by -mm too.)
> >
> > -------------------------
> > This is to remove noisy useless message at boot time from 2.6.18-rc4.
> > The message is a ton of
> > "ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"
> >
> >   
> I'm seeing this on some of my ia64 boxes, however, I see
> 
> ACPI Exception (acpi_memory-0491): AE_ERROR, handle is no memory device 
> [20060707]
> 
> What's interesting is that last little bit looks an awful lot like a 
> date.... It's almost as if we were
> reading beyond the end of the ACPI table?

[20060707] is the version (yes, it is a date) of the ACPICA core.
The ACPI_EXCEPTION() macro appends it to the exception message.

-Len
