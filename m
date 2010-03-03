From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ISAPNP: don't unlock isapnp_cfg_mutex unless we've locked
 it first
Date: Wed, 3 Mar 2010 07:48:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003030747330.28127@eeebox2.perex-int.cz>
References: <20100302223648.7178.17333.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.perex.cz ([212.20.107.53]:50870 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab0CCHH6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Mar 2010 02:07:58 -0500
In-Reply-To: <20100302223648.7178.17333.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Alexander Strakh <strakh@ispras.ru>, Adam Belay <abelay@mit.edu>

On Tue, 2 Mar 2010, Bjorn Helgaas wrote:

>
> If isapnp_cfg_begin() fails, it returns without locking isapnp_cfg_mutex.
> Previously, we always unlocked the mutex, even if we haven't locked it
> first.
>
> This patch checks the isapnp_cfg_begin() return value so we can just
> exit and avoid this locking error.
>
> Found by the Linux Device Drivers Verification Project and reported by
> Alexander Strakh <strakh@ispras.ru>.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Jaroslav Kysela <perex@perex.cz>

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

