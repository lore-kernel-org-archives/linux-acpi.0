From: Eric Atkin <eric@certus.bz>
Subject: New battery doesn't work under linux, but does under windows
Date: Wed, 15 Oct 2008 13:59:58 -0600
Message-ID: <200810151359.58976.eric@certus.bz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ericatkin.fttp.xmission.com ([207.135.146.139]:39818 "EHLO
	charon.certus.bz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYJOUFh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Oct 2008 16:05:37 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

So I bought a new battery for my laptop and installed it. I booted into Linux 
(gentoo) and kpowersave recognized the new battery and for the next few hours 
showed it charging up. The guy at the battery store said I should charge it 
fully and then discharge fully to calibrate, so, once full, i disconnected AC 
power and continued to work. kpowersave recognize that power had been removed 
and showed the battery discharging at a normal rate. After about 1 minute, my 
laptop just shut off. No warnings or attempts to suspend or hibernate or 
anything. Power was just cut off. I tested several times and always got the 
same result. I assumed it was a bad battery, but then I had to boot into 
windows for something and decided to try it there. In windows, I waited till 
the charge was at 100% then disconnected AC and let it run. It ran for about 
two hours as expected before dying. But if I boot back into linux, it dies 
again after just a minute or two. I don't even know where to begin. Any 
ideas? $170 battery that I can't take back because it does actually work, and 
anyway, it seems to be a software issue.
Eric
