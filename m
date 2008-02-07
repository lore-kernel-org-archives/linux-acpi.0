From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 053/112] the generic thermal sysfs driver
Date: Thu, 7 Feb 2008 16:38:43 -0500
Message-ID: <200802071638.43935.lenb@kernel.org>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com> <203d3d4aa482339b4816f131f713e1b8ee37f6dd.1202376824.git.len.brown@intel.com> <20080207200900.GA2082@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38214 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965059AbYBGVjE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 16:39:04 -0500
In-Reply-To: <20080207200900.GA2082@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>

On Thursday 07 February 2008 15:09, Matthew Garrett wrote:
> On Thu, Feb 07, 2008 at 04:34:15AM -0500, Len Brown wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > The Generic Thermal sysfs driver for thermal management.
> 
> There's still ongoing discussion about what the interface should look 
> like (and I certainly agree that the difference in units between this 
> class and hwmon should be a showstopper) - can we skip pushing this 
> until those are resolved?

It is upstream now.

I'm hopeful that getting into -rc1 will poke us to get
these issues resolved sooner than if we had kept the
series out of tree.  I'm also hopeful that we'll have
no major issues with it by 2.6.25.final.

thanks,
-len

