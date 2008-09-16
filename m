From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: DSDT from your system / new DSDT archive
Date: Tue, 16 Sep 2008 19:22:31 -0300
Message-ID: <20080916222231.GB26035@khazad-dum.debian.net>
References: <20080916165543.EA6A42003D@smtp.hushmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57108 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144AbYIPWWi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Sep 2008 18:22:38 -0400
Content-Disposition: inline
In-Reply-To: <20080916165543.EA6A42003D@smtp.hushmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Thompson <postfail@hushmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Tue, 16 Sep 2008, Scott Thompson wrote:
> Since a current one doesn't seem to exist, I am attempting to put 
> my own database together up on the 
> internets (URL coming soon) and am looking for folks to send me the 
> DSDT from their systems.  Gathering your system DSDT takes
> less than about 2 minutes by running the following:  

You also want the dmidecode output, which BTW you must sanitize to remove
UUIDs and serial numbers.  Otherwise, the DSDTs are a lot less useful.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
