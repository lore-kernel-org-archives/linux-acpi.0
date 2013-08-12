From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Date: Mon, 12 Aug 2013 17:04:24 +0200
Message-ID: <20130812150424.GH18018@pd.tnic>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com>
 <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com>
 <20130812123813.GD18018@pd.tnic>
 <20130812114932.52bb0314@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130812114932.52bb0314@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 12, 2013 at 11:49:32AM -0300, Mauro Carvalho Chehab wrote:
> Clear win from what PoV? Userspace will need to decode a different type
> of tracing, and implement a different logic for APEI.

There's no different type of tracing - it is the same info as in both
cases it comes from APEI. And if it can be done in the APEI layer, then
we don't need the next layer.

> Also, if both ghes_edac and this new tracing is enabled, userspace
> will receive twice the same event, as two traces will be received for
> the same thing.

We are, of course, going to have only one tracepoint which reports
memory errors, not two.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
