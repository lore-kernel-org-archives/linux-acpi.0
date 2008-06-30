From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Mon, 30 Jun 2008 16:29:33 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0806301607290.30785@cliff.in.clinika.pl>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806292123.16237.rjw@sisk.pl>
 <Pine.LNX.4.55.0806292023320.22548@cliff.in.clinika.pl> <200806300056.16399.rjw@sisk.pl>
 <Pine.LNX.4.55.0806300003080.22548@cliff.in.clinika.pl>
 <20080630090607.GA18856@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kirk.serum.com.pl ([213.77.9.205]:63946 "EHLO serum.com.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762503AbYF3PbT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jun 2008 11:31:19 -0400
In-Reply-To: <20080630090607.GA18856@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi-suse@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, 30 Jun 2008, Matthew Garrett wrote:

> >  Note that Matthew's made a point here, that apparently there are only two 
> > models using this southbridge and new ones are unlikely to be released, so 
> > my note is for a reference only.
> 
> No, there's many other systems using the same southbridge that don't 
> have the bizarre DSDT code and so don't show this behaviour.

 I meant "... two models [of HP laptops] using this southbridge..." of 
course. :)

 Now I did a search of the Internet and have become puzzled.  Apparently
there *are* other devices using this DSDT.  See for example a thread at:  
"http://bbs.archlinux.org/viewtopic.php?pid=359559" where an owner of an
HP Compaq 6715s has some other problems with a DSDT which coincidentally
is the very same HP/SB400/10000 (though built with a different ASL
compiler, hmm...).

 Matthew, where did you get these DMI IDs from? -- I cannot see them being 
reported in any bootstrap log.

  Maciej
