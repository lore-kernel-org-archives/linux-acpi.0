From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86 acpi: on wakeup, ljmp directly after writing CR0.PE
Date: Sun, 26 Oct 2008 21:38:15 +0100
Message-ID: <200810262138.15669.rjw@sisk.pl>
References: <200810262038.51149.rjw@sisk.pl> <4904D30C.7080200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55380 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbYJZUdl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Oct 2008 16:33:41 -0400
In-Reply-To: <4904D30C.7080200@zytor.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sunday, 26 of October 2008, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
> > Ingo, Peter,
> > 
> > I have this patch in my queue, is it necessary or should I drop it?
> > 
> 
> It's unclear if it's necessary, but I think it's more compliant and we 
> should do it.

OK, then.

Ingo, please queue. :-)

Thanks,
Rafael
