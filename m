From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Mon, 2 Feb 2009 20:40:27 +0100
Message-ID: <20090202204027.006bb2e2@mjolnir.drzeus.cx>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at>
	<20081108213414.579e178d@mjolnir.drzeus.cx>
	<20081108233337.GA21200@gamma.logic.tuwien.ac.at>
	<20081114222557.04025d36@mjolnir.drzeus.cx>
	<20081025214602.GB27030@gamma.logic.tuwien.ac.at>
	<20081108213414.579e178d@mjolnir.drzeus.cx>
	<20081108233337.GA21200@gamma.logic.tuwien.ac.at>
	<20090127004840.GA7246@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:54975 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbZBBTpp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Feb 2009 14:45:45 -0500
In-Reply-To: <20090127004840.GA7246@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Tue, 27 Jan 2009 01:48:40 +0100
Norbert Preining <preining@logic.at> wrote:

> 
> Funny things happened: WIth 2.6.29-rc2 inserting the card did not help,
> nothing showed up. But then I did WITH THE CARD IN THE SLOT a suspend
> and afterwards resume, and voila, there is the card, can be read ...
> I send you the output of dmesg, MMC_DEBUG is still on. It shows from
> boot on the errors while
> 
> Maybe you can squeeze something out of that.
> 

Hmmm...

Could you try building without ricoh_mmc and see if things work? Also
try having the card in during boot.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
