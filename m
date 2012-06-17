From: Andy Isaacson <adi@hexapodia.org>
Subject: Re: [ibm-acpi-devel] t420s: unhandled HKEY
Date: Sat, 16 Jun 2012 21:51:33 -0700
Message-ID: <20120617045133.GL11306@hexapodia.org>
References: <20120606222804.GA6931@cloudera.com>
 <20120608080824.GS25324@hexapodia.org>
 <20120616201735.GH15543@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from straum.hexapodia.org ([207.7.131.186]:38389 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab2FQEvd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Jun 2012 00:51:33 -0400
Content-Disposition: inline
In-Reply-To: <20120616201735.GH15543@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sat, Jun 16, 2012 at 05:17:35PM -0300, Henrique de Moraes Holschuh wrote:
> Andy, as an early follow up, does it make any difference whether you
> plug/unplug AC power directly on the notebook, or on a docking
> station/port replicator?
> 
> Do you have more than one power brick with different power ratings (e.g.
> 65W and 90W)?
> 
> Because AFAIK you really should get a 0x6040 every time the AC power
> adapter state changes.

I do use two or three different PSUs, they may have different ratings.
The one I have in front of me is 65W, and I do get 0x6040 when I plug or
unplug it today.  The other one is at the office and I'll check on
Monday.

Looking through syslog, I do have a lot of pairs of "unhandled HKEY
event 0x6040" followed immediately by "EC reports that Thermal Table has
changed", but there are also a few Thermal Table changed without a
preceding HKEY event.  Perhaps 90% of "Thermal Table has changed" have a
HKEY before them.  There don't appear to be any HKEY 0x6040 without a
"Thermal Table has changed" immediately after.

-andy
