From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] mce: acpi/apei: trace: Include PCIe AER trace event
 conditionally
Date: Mon, 12 Aug 2013 15:26:13 +0200
Message-ID: <20130812132613.GF18018@pd.tnic>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-2-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808152329.1f98b5e0@gandalf.local.home>
 <5208C8DD.3050204@linux.vnet.ibm.com>
 <20130812091337.6f8c057d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130812091337.6f8c057d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, tony.luck@intel.com, bhelgaas@google.com, rjw@sisk.pl, lance.ortiz@hp.com, m.chehab@samsung.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 12, 2013 at 09:13:37AM -0400, Steven Rostedt wrote:
> Yeah, if it's only used on one place, then it's fine. But if it gets
> used in other files, than those other files with have to define the
> macro as well.

Yeah, we need to be careful about this. When a ras tracepoint gets used
in multiple places, I'm guessing it would be cleaner/easier to fork it
out in its own ras-<a-lot-used-tracepoint>.h header, huh?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
