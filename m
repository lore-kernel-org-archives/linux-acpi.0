From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: cap off P-state transition latency from buggy
	BIOSes
Date: Fri, 20 Mar 2009 00:50:16 -0300
Message-ID: <20090320035016.GA28010@khazad-dum.debian.net>
References: <20090319214140.GA28868@linux-os.sc.intel.com> <20090319214746.GC24898@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40442 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752271AbZCTDuV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Mar 2009 23:50:21 -0400
Content-Disposition: inline
In-Reply-To: <20090319214746.GC24898@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 19 Mar 2009, Matthew Garrett wrote:
> On Thu, Mar 19, 2009 at 02:41:40PM -0700, Pallipadi, Venkatesh wrote:
> > Fix it by capping-off the transition latency to 20uS for native MSR based
> > frequency transitions.
> > 
> > Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> We've confirmed that this also helps on the X31.
> 
> Acked-by: Matthew Garrett <mjg@redhat.com>

Any chance of sending this to -stable after it hits mainline?  It is the
sort of stuff a huge number of thinkpad users will want in their kernels
ASAP...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
