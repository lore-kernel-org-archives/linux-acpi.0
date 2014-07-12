From: Julian Wollrath <jwollrath@web.de>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Sat, 12 Jul 2014 18:24:52 +0200
Message-ID: <20140712182452.19ef6a91@saldaea>
References: <20140712180636.698e2e4c@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:61502 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbaGLQY7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jul 2014 12:24:59 -0400
Received: from saldaea ([84.134.38.250]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MgO8g-1WuPEc0Jrq-00NeHs for
 <linux-acpi@vger.kernel.org>; Sat, 12 Jul 2014 18:24:56 +0200
In-Reply-To: <20140712180636.698e2e4c@saldaea>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

> changing the brightness on my Thinkpad X230 with Intel HD4000
> graphics, stopped working after commit 886129a8eebe (ACPI / video:
> change acpi-video brightness_switch_enabled default to 0). Changing
> it back to 1, fixes the problem, if "acpi_osi=!Windows 2012" is also
> set. Before that commit just setting "acpi_osi=!Windows 2012" was
> enough to get changing the brightness working.
small correction: It setting "acpi_osi=!Windows 2012" does only help
when using a kernel with commit 886129a8eebe as HEAD, with v3.16-rc4
setting video.brightness_switch_enabled=1 and acpi_osi=!Windows 2012 or
just one of them, does not make changing the brightness work again.
> 
> 
> With best regards,
> Julian Wollrath
