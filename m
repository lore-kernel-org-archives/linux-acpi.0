From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 2/2] acpi: use __cpuinit for the
	 acpi_processor_set_pdc() call tree
Date: Thu, 17 Feb 2011 15:01:42 -0800
Message-ID: <987664A83D2D224EAE907B061CE93D53019D4BCAD3@orsmsx505.amr.corp.intel.com>
References: <4D5D5C9802000078000327B1@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8156 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab1BQXBo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Feb 2011 18:01:44 -0500
In-Reply-To: <4D5D5C9802000078000327B1@vpn.id2.novell.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> Once acpi_map_lsapic() in ia64 follows how x86 treats it wrt section
> placement, the whole tree from acpi_processor_set_pdc() can become
> __cpuinit.


Acked-by: Tony Luck <tony.luck@intel.com>

