From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/3] aerdrv: Trace Event for AER
Date: Sat, 1 Dec 2012 12:43:10 +0100
Message-ID: <20121201114310.GA7853@liondog.tnic>
References: <20121130213330.7649.51101.stgit@grignak.americas.hpqcorp.net>
 <20121201093614.720aa96a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:52261 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab2LALnP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Dec 2012 06:43:15 -0500
Content-Disposition: inline
In-Reply-To: <20121201093614.720aa96a@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Lance Ortiz <lance.ortiz@hp.com>, bhelgaas@google.com, lance_ortiz@hotmail.com, jiang.liu@huawei.com, tony.luck@intel.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 01, 2012 at 09:36:14AM -0200, Mauro Carvalho Chehab wrote:
> Please don't call it as "ras.h". Call it, instead, ras_aer.h
> (or something similar) as, if we're moving the tracing back to
> include/trace/events/, the same should happen for the memory error
> events.

As you can see yourself, include/trace/events/ contains one header per
topic so having ras_event.h and ras_aer.h or whatever, doesn't fit the
scheme. IOW, we want all RAS-specific tracepoints to be collected in a
header called ras.h like the rest of the subsystems do it. See rcu.h
there for a good example.

-- 
Regards/Gruss,
    Boris.
