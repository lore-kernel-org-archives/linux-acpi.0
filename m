From: Len Brown <len.brown@intel.com>
Subject: Re: [RFC: 2.6 patch] i386: unexport acpi_strict
Date: 20 Jan 2005 13:39:11 -0500
Message-ID: <1106246351.2395.11.camel@d845pe>
References: <20050120181527.GF3174@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261398AbVATSl0@vger.kernel.org>
In-Reply-To: <20050120181527.GF3174@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-01-20 at 13:15, Adrian Bunk wrote:
> I haven't found any possible modular usage of acpi_strict.

I'd prefer to continue to export this flag if that isn't a burden.

The reason is that it is the only way we have to globally tell
the ACPI interpreter and all its (usually modularized) policy
drivers to allow or dis-allow support for platforms that openly
violate the ACPI spec.  (By default the flag is clear and is
set explicity with "acpi_strict")

While the ACPI modules in the tree at the moment don't use
this flag, there are other out-of-tree
modules on the way, and they may need it.

-Len
