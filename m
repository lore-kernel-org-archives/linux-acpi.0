From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Fix ACPI's EC regression from 2.6.29: use usleep()
 instead of msleep()
Date: Mon, 7 Sep 2009 18:57:12 -0300
Message-ID: <20090907215712.GH16533@khazad-dum.debian.net>
References: <20090907211423.GA2535@bizet.domek.prywatny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43279 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751072AbZIGV5O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 17:57:14 -0400
Content-Disposition: inline
In-Reply-To: <20090907211423.GA2535@bizet.domek.prywatny>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karol Lewandowski <karol.k.lewandowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, astarikovskiy@suse.de, lenb@kernel.org, linux-acpi@vger.kernel.org, rjwysocki@sisk.pl

On Mon, 07 Sep 2009, Karol Lewandowski wrote:
> Following patch reverts commit that changed usleep() to mleep()
> in ACPI's EC driver. That change made hotkeys on my Thinkpad T21
> unusable after resume.

Karol, can you send us the dmidecode information for your thinkpad?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
