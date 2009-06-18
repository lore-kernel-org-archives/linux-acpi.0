From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [2.6.30] Kernel bug with dock driver
Date: Thu, 18 Jun 2009 19:10:20 -0300
Message-ID: <20090618221020.GA2979@khazad-dum.debian.net>
References: <200906142100.48621.jplatte@naasa.net> <200906161125.00685.jplatte@naasa.net> <20090617123440.GA400@khazad-dum.debian.net> <200906182322.54566.jplatte@naasa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44938 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752691AbZFRWKW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2009 18:10:22 -0400
Content-Disposition: inline
In-Reply-To: <200906182322.54566.jplatte@naasa.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joerg Platte <jplatte@naasa.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 18 Jun 2009, Joerg Platte wrote:
> Am Wednesday, 17. June 2009 schrieb Henrique de Moraes Holschuh:
> > If it causes a NULL derreference, it means someone has changed API and did
> > NOT change all callsites.  It is that simple.
> >
> thinkpad_acpi: dev_name() is returning NULL

There it is.  "Someone set us up the bomb."

> Hope it helps...

Yes, it does.  Thank you.  Now at least I know what to look for.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
