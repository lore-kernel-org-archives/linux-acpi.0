From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 09:08:54 +0900
Message-ID: <20090323000853.GA31671@kamineko.org>
References: <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090322231449.GA14166@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:43551
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZCWAI5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2009 20:08:57 -0400
Content-Disposition: inline
In-Reply-To: <20090322231449.GA14166@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Norbert Preining <preining@logic.at>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Sun, Mar 22, 2009 at 11:14:49PM +0000, Matthew Garrett wrote:
> On Mon, Mar 23, 2009 at 08:10:30AM +0900, Mattia Dongili wrote:
> > On Sun, Mar 22, 2009 at 10:46:52PM +0000, Matthew Garrett wrote:
> > > Ok, sounds like the mapping needs to be changed. Can you let me know 
> > > which ACPI events are generated for each key?
> > 
> > Yes it does.
> > A vaio SR user sent me this list for 0x9c that after a call to SN07(202)
> > becomes:
> 
> 0x9c as well? Interesting. Easy enough to generalise that code, I guess. 

well, I was thinking of a two layer lookup keyed on the event code
(0x9[02ce]).

> If we don't have a match, maybe we should just send the scancode with 
> KEY_UNKNOWN and let hal remap them?

the problem is that the decoded keypress (after the SN07 call) generates
duplicates, i.e.: 0x81 is fn+f1 for the 0x92 case and some "Mode" key
for 0x9c the an SR model.
I guess sending the whole combination as the scancode would do the trick
(0x9c81).
But as long as we can make it consistent with what sony-laptop currently
sends to userspace then we should try to have a map.

-- 
mattia
:wq!
