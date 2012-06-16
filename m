From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] t420s: unhandled HKEY
Date: Sat, 16 Jun 2012 17:11:31 -0300
Message-ID: <20120616201131.GE15543@khazad-dum.debian.net>
References: <20120606222804.GA6931@cloudera.com>
 <20120608080824.GS25324@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40378 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755995Ab2FPULe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Jun 2012 16:11:34 -0400
Content-Disposition: inline
In-Reply-To: <20120608080824.GS25324@hexapodia.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Isaacson <adi@hexapodia.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Fri, 08 Jun 2012, Andy Isaacson wrote:
> I'm running 3.4.0 on a Thinkpad T420s.  It works well nearly all of the
> time, but recently I got the following message when I unplugged the AC
> adapter:
> 
> [17037.973595] thinkpad_acpi: unknown possible thermal alarm or keyboard event received
> [17037.973599] thinkpad_acpi: unhandled HKEY event 0x6040
> [17037.973601] thinkpad_acpi: please report the conditions when this event happened to ibm-acpi-devel@lists.sourceforge.net
> 
> So, here's a report. :)
> 
> It's possible that I accidentally hit the keyboard or something while
> unplugging the power.
> 
> I don't get this message every time I unplug the power.

Thanks for the report.  Please ignore this issue for the time being.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
