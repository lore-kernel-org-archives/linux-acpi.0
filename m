From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Subject: Re: ACPI failures on Dell Latitude E6220
Date: Wed, 21 Dec 2011 17:40:11 +0100
Message-ID: <87vcp998us.fsf@pirx.pps.jussieu.fr>
References: <87r50zzvf6.fsf@pirx.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:40807 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab1LUQkT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Dec 2011 11:40:19 -0500
Received: from pirx.pps.jussieu.fr (unknown [IPv6:2a01:e35:2ee4:9090:2677:3ff:fe1a:db64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D37A8940662
	for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2011 17:40:12 +0100 (CET)
Received: from jch by pirx.pps.jussieu.fr with local (Exim 4.77)
	(envelope-from <jch@pps.jussieu.fr>)
	id 1RdPD9-000142-Di
	for linux-acpi@vger.kernel.org; Wed, 21 Dec 2011 17:40:11 +0100
In-Reply-To: <87r50zzvf6.fsf@pirx.pps.jussieu.fr> (Juliusz Chroboczek's
	message of "Tue, 22 Nov 2011 02:29:48 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

>> [  227.525937] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20110623/evregion-478)
>> [  227.525946] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880128e7a3d0), AE_TIME (20110623/psparse-536)
>> [  227.525957] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880128e7a268), AE_TIME (20110623/psparse-536)

This appears to be fixed, or at least worked around, by Debian's kernel
3.1.5-1.  My idle battery time doubled (yay!).  Turbostat indicates that
the CPU is now entering the higher-numbered "PC" states, which it wasn't
doing beforehand.

Thanks a lot to whoever fixed this issue.

-- Juliusz Chroboczek
