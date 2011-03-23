From: Len Brown <lenb@kernel.org>
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Wed, 23 Mar 2011 00:28:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103230026170.10549@x980>
References: <1299766243-494-1-git-send-email-amwang@redhat.com>
 <20110310082600.b52de7fb.rdunlap@xenotime.net> <4D86F3A7.8060706@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-250848358-1300854502=:10549"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:62591 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab1CWE2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 00:28:45 -0400
In-reply-to: <4D86F3A7.8060706@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cong Wang <amwang@redhat.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-250848358-1300854502=:10549
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 21 Mar 2011, Cong Wang wrote:

> 于 2011年03月11日 00:26, Randy Dunlap 写道:
> > On Thu, 10 Mar 2011 22:10:43 +0800 Amerigo Wang wrote:
> > > +	acpi_addr=	[ACPI,EFI]
> > > +			Pass the RSDP address to the kernel, mostly used
> > > +			on machines running EFI runtime service to boot the
> > > +			second kernel for kdump.
> > > +
> > 
> > I think that "acpi_addr" is a bit too generic.  How about
> > acpi_rsdp or acpi_root instead?
> > 
> 
> Yup, I agree "acpi_rsdp" is better.

This should also be [KEXEC], and the code should be #ifdef CONFIG_KEXEC
so that sane people can exclude it from their kernels.

thanks,
Len Brown, Intel Open Source Technology Center

--8323328-250848358-1300854502=:10549--
