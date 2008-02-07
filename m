From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH][drivers/misc/thinkpad_acpi.c] duplicate test if (level
	& TP_EC_FAN_FULLSPEED)
Date: Wed, 6 Feb 2008 23:18:50 -0200
Message-ID: <20080207011850.GC10122@khazad-dum.debian.net>
References: <47A78CBB.2090401@tiscali.nl> <ada8x20gykq.fsf@cisco.com> <47A79EC8.6060700@tiscali.nl> <20080205050504.GB30670@khazad-dum.debian.net> <47A81FAE.2090709@tiscali.nl> <20080206230702.GA12395@kroah.com> <47AA4748.3040702@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33366 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750977AbYBGBSz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 20:18:55 -0500
Content-Disposition: inline
In-Reply-To: <47AA4748.3040702@tiscali.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: Greg KH <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>, len.brown@intel.com, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, stable@kernel.org

On Thu, 07 Feb 2008, Roel Kluin wrote:
> It's a oneliner and the patch is from linus' tree.

Roel, better to just let me and Len Brown handle it.  I will add your patch
to my thinkpad-acpi queue and send it to Len soon, along with other simple
patches that are pending.  Either I or Len will notify stable@k.o when it
hits mainline.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
