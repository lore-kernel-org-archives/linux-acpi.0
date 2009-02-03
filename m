From: Norbert Preining <preining@logic.at>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Tue, 3 Feb 2009 01:13:19 +0100
Message-ID: <20090203001318.GA15113@gamma.logic.tuwien.ac.at>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <20081108213414.579e178d@mjolnir.drzeus.cx> <20081108233337.GA21200@gamma.logic.tuwien.ac.at> <20081114222557.04025d36@mjolnir.drzeus.cx> <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <20081108213414.579e178d@mjolnir.drzeus.cx> <20081108233337.GA21200@gamma.logic.tuwien.ac.at> <20090127004840.GA7246@gamma.logic.tuwien.ac.at> <20090202204027.006bb2e2@mjolnir.drzeus.cx> <20090202235754.GA13222@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:45571 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbZBCANa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Feb 2009 19:13:30 -0500
Content-Disposition: inline
In-Reply-To: <20090202235754.GA13222@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: linux-acpi@vger.kernel.org

On Di, 03 Feb 2009, preining wrote:
> Tests, all with kernel 2.6.29-rc3
> 
> - normal boot without card in the slot -> not detected
>   . suspending with OR without card in the slot makes it work!!!!
>     (that is new, I thought that the card has to be in the slot!)
>   . re-ejecting and re-inserting always make the card show up
>     One sequence of eject/re-insert's syslog output is attached.

       meant was AFTER a suspend/resume cycle the ejecting/re-inserting
       always makes the card show up.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HEATON PUNCHARDON (n.) A violent argument which breaks out in the car
on the way home from a party between a couple who have had to be
polite to each other in company all evening.
			--- Douglas Adams, The Meaning of Liff
