From: Theodore Tso <tytso@mit.edu>
Subject: Re: Critical temp shutdowns on ThinkPad X60 1706-GMG
Date: Thu, 31 Jul 2008 10:06:02 -0400
Message-ID: <20080731140602.GB11632@mit.edu>
References: <200807301556.01815.trenn@suse.de> <20080730175227.GA13850@khazad-dum.debian.net> <87zlnyv14h.fsf_-_@gismo.pca.it> <200807311439.46393.trenn@suse.de> <871w1aurwc.fsf@gismo.pca.it> <20080731131512.GI5347@mit.edu> <87od4etc6k.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:37288 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752185AbYGaOGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2008 10:06:07 -0400
Content-Disposition: inline
In-Reply-To: <87od4etc6k.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ak@linux.intel.com, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, lenb@kernel.org

On Thu, Jul 31, 2008 at 03:28:51PM +0200, Luca Capello wrote:
> OK, if you want to give a try to my test case:
> 
>   $ [install darcs]
>   $ darcs get http://alioth.debian.org/~gismo/darcs-pull-bug/parenscript.upstream/
>   $ darcs get http://alioth.debian.org/~gismo/darcs-pull-bug/parenscript/
>   $ cd parenscript
>   $ darcs pull ../parenscript.upstream/
>     [choose to apply only the first patch]
> 
> At that point, darcs takes 100% of the CPU and temperature starts to
> rise :-(

Hmm.... darcs is not impressing me as a good choice of version control
systems.  I mean, yes I'm spoiled with git being able to merge
hundreds of patches is seconds, but this is rediculous!  :-)

I've tried running for it for a while, and THM0 and THM1 are in the
80-83 degree range, but it's not going above that.  According to THM1
has a passive trip point at 96 degrees, and a critical trip point at
100 degrees, but with your test case I'm not going anywhere near that
level.

Just for yucks I tried running a second copy of your test case (since
I hae a dual-core processor), and with the second core also busy 100%,
I was able to drive the temperature up another degree or two, but that
was about it.

Regards,

							- Ted
