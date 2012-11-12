From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Patch to correct battery capacity values on Thinkpads (repost)
Date: Mon, 12 Nov 2012 18:22:03 -0200
Message-ID: <20121112202202.GA18138@khazad-dum.debian.net>
References: <20121112050935.GA25110@scooby.iskra.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36315 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752959Ab2KLUWH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Nov 2012 15:22:07 -0500
Content-Disposition: inline
In-Reply-To: <20121112050935.GA25110@scooby.iskra.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamil Iskra <kamil@iskra.name>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sun, 11 Nov 2012, Kamil Iskra wrote:
> Please find below a patch to drivers/acpi/battery.c that adds a quirk to
> correctly report battery capacity on 2010 and 2011 Lenovo Thinkpad models.
> I think the patch is ready to be applied (Len: please apply).  However,
> since it specifically affects Thinkpads, I've copied ibm-acpi-devel ML on
> this message to give them a chance to provide input, if any.

FWIW,

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>


-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
