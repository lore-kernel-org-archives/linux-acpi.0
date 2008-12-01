From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] ACPI toshiba: only register rfkill if bt is enabled
Date: Mon, 1 Dec 2008 11:30:52 -0800
Message-ID: <20081201113052.9e9aae36.akpm@linux-foundation.org>
References: <20081029081934.GB26314@gambetta>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54333 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753547AbYLATbr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 14:31:47 -0500
In-Reply-To: <20081029081934.GB26314@gambetta>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frederik Deweerdt <frederik.deweerdt@xprog.eu>
Cc: arvidjaar@mail.ru, linux-kernel@vger.kernel.org, philipl@overt.org, linux-acpi@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>

This patch:

On Wed, 29 Oct 2008 08:19:34 +0000
Frederik Deweerdt <frederik.deweerdt@xprog.eu> wrote:

> Register toshiba RFKill Switch only if bluetooth is enabled

which is here: http://userweb.kernel.org/~akpm/mmotm/broken-out/acpi-toshiba-only-register-rfkill-if-bt-is-enabled.patch

fixes a post-2.6.27 regression.  It doesn't apply any more, due to the
recent merge of this:

commit e251fa12fb5713e722029341c03b2f48bcd7b7be
Author: Arjan van de Ven <arjan@linux.intel.com>
Date:   Fri Nov 28 08:19:09 2008 -0800

    toshiba_acpi: close race in toshiba_acpi driver
    
in linux-next.

It is unclear to me whether these two patches fix the same bug, or
different ones.

Could you please take a look in linux-next and see what needs to be
done?

Thanks.
