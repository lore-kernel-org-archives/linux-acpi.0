From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 13 May 2008 20:59:21 -0400
Message-ID: <200805132059.22031.lenb@kernel.org>
References: <1210259416.6710.13.camel@hammer1.suse.de> <1210346444.29724.49.camel@queen.suse.de> <20080510121754.GA18338@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48111 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971AbYENA7n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2008 20:59:43 -0400
In-Reply-To: <20080510121754.GA18338@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>

On Saturday 10 May 2008, Henrique de Moraes Holschuh wrote:
> On Fri, 09 May 2008, Thomas Renninger wrote:
> > IMO the whole [XTR][45]* models which came out at that time should be
> > added also, this should be rather safe to do.
> 
> The X4x are rather different beasts. Better check.  The T40-2 are the
> same BIOS, and it was the most updated BIOS in IBM's thinkpad history.
> Better check that one too.  They might not need (or want) the "fix".
> 
> What do you need to compare between the tables? I have them.

please send me the acpidump for an r40e that need to use
the RSDT instead of an XSDT.

thanks,
-Len



