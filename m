From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI in Windows Vista
Date: Tue, 24 Apr 2007 11:28:27 -0300
Message-ID: <20070424142827.GB474@khazad-dum.debian.net>
References: <200704231458.31767.lenb@kernel.org> <1177385966.4635.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:38045 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161765AbXDXO2b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Apr 2007 10:28:31 -0400
Content-Disposition: inline
In-Reply-To: <1177385966.4635.5.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, 24 Apr 2007, Shaohua Li wrote:
> On Tue, 2007-04-24 at 02:58 +0800, Len Brown wrote:
> > It is useful to see what Microsoft is doing with ACPI in Vista --
> > as that shapes many of the BIOS implementations that Linux will
> > encounter:
> > 
> > http://download.microsoft.com/download/5/b/9/5b97017b-e28a-4bae-ba48-174cf47d23cd/CPA002_WH06.ppt
> vista disable MSI per fadt.iapc_boot_arch flags, looks we should do the
> same. This means we don't need MSI quirk too.

It actually means we need both.  Not every manufacturer is Intel.

> I'm curious why firmware shouldn't change low 1M memory between sleep,
> considering some ranges are reserved.

It is quite possible that they mean it as in "don't change the contents of
non-reserved ranges, nor the ranges themselves".

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
