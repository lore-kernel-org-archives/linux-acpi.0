From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] ACPI toshiba: only register rfkill if bt is enabled
Date: Mon, 1 Dec 2008 11:40:04 -0800
Message-ID: <20081201114004.731cec86@infradead.org>
References: <20081029081934.GB26314@gambetta>
	<20081201113052.9e9aae36.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59295 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbYLATi4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 14:38:56 -0500
In-Reply-To: <20081201113052.9e9aae36.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Frederik Deweerdt <frederik.deweerdt@xprog.eu>, arvidjaar@mail.ru, linux-kernel@vger.kernel.org, philipl@overt.org, linux-acpi@vger.kernel.org

On Mon, 1 Dec 2008 11:30:52 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> This patch:
> 
> On Wed, 29 Oct 2008 08:19:34 +0000
> Frederik Deweerdt <frederik.deweerdt@xprog.eu> wrote:
> 
> > Register toshiba RFKill Switch only if bluetooth is enabled
> 
> which is here:
> http://userweb.kernel.org/~akpm/mmotm/broken-out/acpi-toshiba-only-register-rfkill-if-bt-is-enabled.patch
> 
> fixes a post-2.6.27 regression.  It doesn't apply any more, due to the
> recent merge of this:
> 
> commit e251fa12fb5713e722029341c03b2f48bcd7b7be
> Author: Arjan van de Ven <arjan@linux.intel.com>
> Date:   Fri Nov 28 08:19:09 2008 -0800
> 
>     toshiba_acpi: close race in toshiba_acpi driver
>     
> in linux-next.
> 
> It is unclear to me whether these two patches fix the same bug, or
> different ones.
> 

they fix the same symptom, but are both needed.
My patch fixes "if it goes wrong and init fails, don't oops", the mmotm
patch fixes "lets not make init fail for <this case>". If there's some
other reason the init fails, my patch is still needed.

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
