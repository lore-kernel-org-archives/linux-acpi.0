From: Gerald Pfeifer <gp@suse.de>
Subject: RE: [ACPI] [PATCH] restore _OS object to "Linux" for ia64
Date: Mon, 13 Sep 2004 23:30:12 +0200 (CEST)
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.61.0409132325261.11103@lifschitz.suse.de>
References: <37F890616C995246BE76B3E6B2DBE05501FB467C@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05501FB467C@orsmsx403.amr.corp.intel.com>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Alex Williamson <alex.williamson@hp.com>, linux-ia64@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Mon, 13 Sep 2004, Moore, Robert wrote:
> Not only is the !Windows code path apparently untested for the most 
> part, we have discovered many machines that simply do not work properly 
> unless we report "Microsoft Windows NT" for the _OS string.

Can you name some of these (broken) systems?

Given that we apparently did not encounter this with our 2.6.5-based SLES9 
kernel so far, I'm a bit sceptical that many (if any) ia64 machines are 
affected.

Gerald
