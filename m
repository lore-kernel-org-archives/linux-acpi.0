From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [BUG] long freezes on thinkpad t60
Date: Thu, 24 May 2007 19:08:16 -0300
Message-ID: <20070524220816.GC23214@khazad-dum.debian.net>
References: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33603 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751165AbXEXWIW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 May 2007 18:08:22 -0400
Content-Disposition: inline
In-Reply-To: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, linux-acpi@vger.kernel.org

On Thu, 24 May 2007, Miklos Szeredi wrote:
> Tried nmi_watchdog=1, but then the machine locks up hard shortly after
> boot.

NMIs in some thinkpads are bad trouble, they lock up the blasted IBM/Lenovo
SMBIOS if they happen to hit it while it is servicing a SMI, and thinkpads
do SMIs like crazy.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
