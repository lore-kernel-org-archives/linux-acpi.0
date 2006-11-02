From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: udev broken by recent ACPI git commits
Date: Wed, 1 Nov 2006 21:12:42 -0300
Message-ID: <20061102001242.GB11581@khazad-dum.debian.net>
References: <200611010004.28483.rjw@sisk.pl> <200611011844.30280.rjw@sisk.pl> <4548F530.3000206@linux.intel.com> <200611012100.16836.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58252 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752604AbWKBAMs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Nov 2006 19:12:48 -0500
Content-Disposition: inline
In-Reply-To: <200611012100.16836.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Andrew Morton <akpm@osdl.org>

On Wed, 01 Nov 2006, Rafael J. Wysocki wrote:
> Yes, and that smells bad, because theoretically there's no reason for which
> they could be different.  FWIW, 2.6.19-rc4-mm1 shows the same addresses

There is if some ACPI methods are (or are not) being called in one of the
two situations (like _INI methods).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
