From: Theodore Tso <tytso@mit.edu>
Subject: Re: Critical temp shutdowns on ThinkPad X60 1706-GMG
Date: Thu, 31 Jul 2008 09:15:12 -0400
Message-ID: <20080731131512.GI5347@mit.edu>
References: <200807301556.01815.trenn@suse.de> <20080730175227.GA13850@khazad-dum.debian.net> <87zlnyv14h.fsf_-_@gismo.pca.it> <200807311439.46393.trenn@suse.de> <871w1aurwc.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:57278 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751264AbYGaNPV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2008 09:15:21 -0400
Content-Disposition: inline
In-Reply-To: <871w1aurwc.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ak@linux.intel.com, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, lenb@kernel.org

On Thu, Jul 31, 2008 at 03:04:03PM +0200, Luca Capello wrote:
> I read the list, thanks.  I was so surprised that no one reported this
> issue before and I've already planned to deal with it during
> DebCamp8/DebConf8 (starting on Sunday, Aug 3rd [2]).

One possibility is that it's a hardware problem; for example, it could
be that your heat sink on the CPU or GPU didn't have enough thermal
compound installed, or some such.

I have an X61s, which has a different BIOS series and a low-voltage
CPU chip, so it's not directly comparable, but I can say that I've not
had any problems even when I've loaded the CPU significantly.

Of course, I also use mainline kernels and not Debian kernels.  One
thing that you might try to do while you are at DebConf is to see if
you can find other people with the same laptop model and see if they
can duplicate the problem on their machine, so you can try varying
both the Debian/non-debian kernel, as well as trying to see if you can
reproduce the problem on multiple laptops.

Regards,

        		      	   	       - Ted


