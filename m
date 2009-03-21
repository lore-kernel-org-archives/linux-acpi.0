From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 14:53:48 +0100
Message-ID: <200903211453.49039.matze@welwarsky.de>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:8385
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZCUNxz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 09:53:55 -0400
Received: from wind.localnet (p54A7BA80.dip.t-dialin.net [84.167.186.128])
	by basyskom.de (Postfix) with ESMTP id 34CE939BA1E
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2009 14:53:50 +0100 (CET)
In-Reply-To: <200903211222.36642.matze@welwarsky.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Saturday 21 March 2009 12:22:35 Matthias Welwarsky wrote:
> I've also backported Matthews patch to the standard Suse 11.1 kernel so
> that we can test it more easily.

Done, looks quite promising. The "wireless" switch on the Z21 works now, and 
apparently there is some script magic in opensuse that operates all rfkill 
switches, so it kills all wireless devices at once. Not bad.

The new init sequence for SN07 also enables all the special keys, even the 
speed/stamina switch now generates an ACPI event, as well as S1, S2 and Eject. 
But you cannot distinguish them, they all report the same event.

All in all - nice.
regards,
	matthias

