From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC][PATCH] ACPI: EC: Don't trust ECDT tables from ASUS
Date: Tue, 2 Dec 2008 13:52:28 -0200
Message-ID: <20081202155228.GI1668@khazad-dum.debian.net>
References: <20081201204706.32465.23231.stgit@thinkpad> <1228205657.4035.206.camel@yakui_zhao.sh.intel.com> <49350201.9010601@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53955 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbYLBPwd (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 2 Dec 2008 10:52:33 -0500
Content-Disposition: inline
In-Reply-To: <49350201.9010601@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Zhao Yakui <yakui.zhao@intel.com>, LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

On Tue, 02 Dec 2008, Alexey Starikovskiy wrote:
> ASUSTek keeps feeding us with broken ECDT tables, which are very hard to workaround.
> So, we end up always checking that ECDT from ASUS has the same info as DSDT, and
> bark otherwise.

I wish we would do more of that, AND printk "BIOS BUG" and "FIRMWARE BUG"
everytime we activate any quirk or bug due to something we are completely
sure to be a vendor firmware screw-up.

Otherwise, the situation never seems to get better :(

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
