From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: final set of EC init patches
Date: Wed, 7 Mar 2007 18:26:09 -0300
Message-ID: <20070307212609.GA1796@khazad-dum.debian.net>
References: <45E6050D.2060908@linux.intel.com> <200703070034.06530.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:49105 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965657AbXCGV0Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2007 16:26:16 -0500
Content-Disposition: inline
In-Reply-To: <200703070034.06530.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 07 Mar 2007, Len Brown wrote:
> Anybody got any candidates for a series of transactions that would
> benefit from this mode?  If yes, is it possible to detect an efficiency
> benefit from enabling burst mode for that series?

ibm-acpi would like a lot to have burst-mode for EC dumps (read of 256 EC
registers), and for thermal reading (two bursts of eight register reads, or
one of sixteen non-contiguous reads if that is possible -- I need to read
the ACPI spec on the burst mode).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
