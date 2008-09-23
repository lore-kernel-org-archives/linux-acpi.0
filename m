From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/5] ACPI: EC: Don't degrade to poll mode at storm
 automatically
Date: Mon, 22 Sep 2008 18:39:47 -0700
Message-ID: <20080922183947.23eba3a6.akpm@linux-foundation.org>
References: <200809222137.m8MLbXl5031009@imap1.linux-foundation.org>
	<1222131818.3999.161.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49668 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753829AbYIWBkW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 21:40:22 -0400
In-Reply-To: <1222131818.3999.161.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, andi@firstfloor.org, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

On Tue, 23 Sep 2008 09:03:38 +0800 Zhao Yakui <yakui.zhao@intel.com> wrote:

> On Mon, 2008-09-22 at 14:37 -0700, akpm@linux-foundation.org wrote:
> > From: Alexey Starikovskiy <astarikovskiy@suse.de>
> > 
> > Not all users of semi-broken EC devices want to degrade to poll mode, so
> > give them right to choose.
> > 
> > This fixes a regression in 2.6.26 (from 2.6.25.3).  Initially reported as
> > "Asus Eee PC hotkeys stop working if pressed quickly" in bugzilla
> > <http://bugzilla.kernel.org/show_bug.cgi?id=11089>.
> This patch is not very reasonable. 

Yes, I know.  I'm just sort of hanging on to it until someone tells me
that the bug which it purports to fix is otherwise fixed.  And frankly
there have been so many bugs in this area that I've forgotten which one
we're fixing.

I think I'll just give up and drop it.

