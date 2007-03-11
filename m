From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] ibm-acpi: more updates
Date: Sun, 11 Mar 2007 14:34:34 -0500
Message-ID: <200703111534.34366.lenb@kernel.org>
References: <11723292823837-git-send-email-hmh@hmh.eng.br> <200703082259.55832.lenb@kernel.org> <20070310171626.GA9644@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52617 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965103AbXCKTmm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Mar 2007 15:42:42 -0400
In-Reply-To: <20070310171626.GA9644@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Saturday 10 March 2007 12:16, Henrique de Moraes Holschuh wrote:
> On Thu, 08 Mar 2007, Len Brown wrote:
> > Henrique,
> > If you could refresh this on to of the latest acpi-test,
> > that would be great.  (ibm-acpi changes in acpi-test are
> > headed for 2.6.21).
> 
> These are not 2.6.21 material, I don't want Linus goint postal on either of
> us :-)
> 
> Please tell me when you open the merge window for acpi-test targeting
> 2.6.22, and I will rediff and resubmit them.

heh, the service window is always open at this restaurant:-)

seriously, as I use topic branches, I'm happy to accept patches
for future releases sooner than later and they will not get
in the way of the current release.

some of the topic branches I pull into "release" for linus,
and additional ones I pull into "test" for andrew.
the other day, for example, I sent out the contents
of "release", which subsequently got pulled into 2.6.21-rc3-git6,
and the additional contents of "test", which is the
current queue for 2.6.22 -- or beyond if they
prove not to be ready by then.

thanks,
-Len

ps. ibm-acpi-devel@lists.sourceforge.net almost always bounces
on me with a timeout.  I think sourceforge as an e-mail
list host is disfunctional (which is why we moved linux-acpi
a while back)
