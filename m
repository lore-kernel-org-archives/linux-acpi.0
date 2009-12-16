From: Len Brown <lenb@kernel.org>
Subject: Re: PATCH: Toshiba Bluetooth enabler (v3)
Date: Wed, 16 Dec 2009 12:06:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912161205580.6089@localhost.localdomain>
References: <4B192D08.9080608@gmail.com>
 <9b2b86520912080205x478b47eek2377dacdbe44a522@mail.gmail.com>
 <4B1E85A9.3030005@gmail.com>
 <9b2b86520912090517l458bc21cobbb138d460e11f53@mail.gmail.com>
 <4B211346.2000205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:41502 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762426AbZLPRHF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 12:07:05 -0500
In-reply-to: <4B211346.2000205@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jes Sorensen <jes.sorensen@gmail.com>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

applied, sans dependency on RFKILL where I agree with Alan
that it will probably just confuse folks who build their own kernel
rather than add significant value.

thanks,
Len Brown, Intel Open Source Technology Center

