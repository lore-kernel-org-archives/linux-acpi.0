From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Lenovo ThinkPads need acpi_osi="Linux"
Date: Sun, 13 Jan 2008 22:10:05 -0200
Message-ID: <20080114001005.GF10693@khazad-dum.debian.net>
References: <20080112022348.GC27524@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:48202 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754580AbYANAKK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Jan 2008 19:10:10 -0500
Content-Disposition: inline
In-Reply-To: <20080112022348.GC27524@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

A bit more on this issue.  I have received a report that on a X61, it
actually works the opposite from the T61 and you need acpi_osi="!Linux" to
get the "mute" key to work.

Well, I am asking the users to track down exactly *where* the mute key is
comming from in each case (ACPI or keyboard controller).  When I have the
results, I will send an update to this thread.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
