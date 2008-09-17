From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: DSDT from your system / new DSDT archive
Date: Tue, 16 Sep 2008 23:41:27 -0300
Message-ID: <20080917024127.GB1187@khazad-dum.debian.net>
References: <20080916165543.EA6A42003D@smtp.hushmail.com> <20080916222231.GB26035@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52199 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631AbYIQClf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Sep 2008 22:41:35 -0400
Content-Disposition: inline
In-Reply-To: <20080916222231.GB26035@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Thompson <postfail@hushmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

Hi Scott!

On Tue, 16 Sep 2008, Henrique de Moraes Holschuh wrote:

> On Tue, 16 Sep 2008, Scott Thompson wrote:
> > Since a current one doesn't seem to exist, I am attempting to put 
> > my own database together up on the 
> > internets (URL coming soon) and am looking for folks to send me the 
> > DSDT from their systems.  Gathering your system DSDT takes
> > less than about 2 minutes by running the following:  
> 
> You also want the dmidecode output, which BTW you must sanitize to remove
> UUIDs and serial numbers.  Otherwise, the DSDTs are a lot less useful.

Come to think of it, the DSDTs are useless without the other tables in most
systems, anyway, so you want to store the entire acpidump :-p

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
