From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PNP: set IRQ index in sysfs "set irq" interface
Date: Mon, 5 May 2008 09:00:45 -0600
Message-ID: <200805050900.46521.bjorn.helgaas@hp.com>
References: <200805011539.58705.bjorn.helgaas@hp.com> <481DBE81.8000608@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:10680 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYEEPAq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2008 11:00:46 -0400
In-Reply-To: <481DBE81.8000608@keyaccess.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On Sunday 04 May 2008 07:47:45 am Rene Herman wrote:
> But what I wanted to ask -- judging from my .gitconfig (as opposed to my 
> memory) I haven't done anything special to get the -p (--show-c-function) 
> functionality from git-diff. Do you do anything special to not get it? It 
> really helps when looking at patches.

I agree, "--show-c-function" is often handy.  I use quilt, and it
looks like it doesn't add that option by default.  I added a ~/.quiltrc
containing 'QUILT_DIFF_OPTS="-p"', and it looks like that will do the
trick.  Thanks for the tip.

Bjorn

