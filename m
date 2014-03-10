From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: trace, RAS: New eMCA trace event interface
Date: Mon, 10 Mar 2014 16:41:22 -0300
Message-ID: <20140310164122.465fb795.m.chehab@samsung.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <5316136f1918986e5@agluck-desk.sc.intel.com>
 <20140307061047.5c901413@samsung.com>
 <CA+8MBbLBZLJW=4ahJn5uCvXdj4Q4uP_U9joxgsFJXV5Yp7PBWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]:20450 "EHLO
	usmailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbaCJTlj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2014 15:41:39 -0400
Received: from uscpsbgm2.samsung.com
 (u115.gpu85.samsung.co.kr [203.254.195.115]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N2800GO8K1DK440@usmailout3.samsung.com> for
 linux-acpi@vger.kernel.org; Mon, 10 Mar 2014 15:41:37 -0400 (EDT)
In-reply-to: <CA+8MBbLBZLJW=4ahJn5uCvXdj4Q4uP_U9joxgsFJXV5Yp7PBWA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, "arozansk@redhat.com" <arozansk@redhat.com>, linux-acpi <linux-acpi@vger.kernel.org>

Em Mon, 10 Mar 2014 11:55:24 -0700
Tony Luck <tony.luck@gmail.com> escreveu:

> On Fri, Mar 7, 2014 at 1:10 AM, Mauro Carvalho Chehab
> <m.chehab@samsung.com> wrote:
> > As I just pointed, we'll also need some code at the rasdaemon that would
> > associate the CPER error location data into the corresponding DIMM label.
> 
> In most cases the kernel will provide a label (that it got from
> SMBIOS). I assume
> this is for the case that the SMBIOS table is bad?

Well, except for reference boards, I'm yet to see such info
properly filled at the SMBIOS table that matches the names
printed at the motherboard.

> I haven't looked too hard at how EDAC does this - the "--register-labels" option
> to edac-ctl?

Right now, it uses the EDAC sysfs nodes to store the labels at
the Kernel. The advantage is that a fatal error dmesg will also
print the proper labels.

Moving it to userspace will only solve for non-fatal errors where
the rasdaemon will handle the traces.

> Since we don't have a sysfs interface for extlog - perhaps any
> translation can be handled entirely in rasdaemon(8).

That could be done, but some additional logic will be needed to
teach the rasdaemon that the information should be stored on some
database. The rasdaemon would also need to detect at runtime if
the stored data matches the machine where it is running.

Regards,
Mauro
