From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [GIT PULL] rename ibm-acpi driver to thinkpad-acpi
Date: Fri, 30 Mar 2007 22:03:04 -0300
Message-ID: <20070331010304.GB2555@khazad-dum.debian.net>
References: <11751443243976-git-send-email-hmh@hmh.eng.br> <200703301603.55424.lenb@kernel.org> <200703301606.33216.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59599 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933231AbXCaBDJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2007 21:03:09 -0400
Content-Disposition: inline
In-Reply-To: <200703301606.33216.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Fri, 30 Mar 2007, Len Brown wrote:
> > >       ACPI: ibm-acpi: rename driver to thinkpad-acpi
> 
> Oh, and if it were me, I'd probably name it simply "thinkpad",
> but it is your driver, so you can name it what you like.

We shall need the thinkpad-* namespace for other modules soon, both in-tree
and out-of-tree :-)   So I added ibm-acpi to that namespace instead of
taking over its root.  "thinkpad" is better left unused, or reserved for a
module with common code needed by various other thinkpad-* modules.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
