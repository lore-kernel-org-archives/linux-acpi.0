From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 22:55:10 -0300
Message-ID: <20080515015510.GD3415@khazad-dum.debian.net>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec> <20080514005636.GA21608@srcf.ucam.org> <20080514111817.GA21186@tangens.sinus.cz> <200805141322.26879.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52408 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751060AbYEOBzP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 21:55:15 -0400
Content-Disposition: inline
In-Reply-To: <200805141322.26879.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Troller <patrol@sinus.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, cpufreq@lists.linux.org.uk, Alex =?iso-8859-1?B?VmlsbGFj7a1z?= Lasso <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Wed, 14 May 2008, Len Brown wrote:
> But the cost is that others with actual working hardware
> unnwittingly run p4-clockmod and slow down their machine with
> no energy savings benefit.

Well, there ARE ways to make sure p4-clockmod is only used as a last
ressort, and we CAN make sure the user will be told it is using a last
ressort measure that does not save energy.  Major nasty printks come to
mind.

p4-clockmod has saved my bacon on an Intel D875PBZ motherboard whose
processor was overheating, as well (older kernel, though. That box runs
2.6.16.y).  I can't check right now if that motherboard has proper ACPI
thermal zones that would do the same in a new kernel without
p4-clockmod, but I will do so when I have the chance.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
