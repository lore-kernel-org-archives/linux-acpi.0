From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI -- Workaround for broken DSDT
Date: Wed, 4 Feb 2004 02:22:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A9F@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
content-class: urn:content-classes:message
To: trelane@digitasaru.net
Cc: bluefoxicy@linux.net, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

> From Brown, Len on Sunday, 01 February, 2004:
> >The vendor should supply a correct DSDT with their BIOS.
> >In the case of Dell, you might inquire here: http://linux.dell.com/
> >For non-vendor supplied solutions, you might also follow the 
> DSDT link
> >here: http://acpi.sourceforge.net/  
> 
> Hmm.  Do vendors generally release these?  I know Dell's very shaky on
>   the Linux support front, at least for desktop/laptop.
> Also, how do non-vendor supplied ones get made?  Seems like something
>   you need NDA'ed docs for.

Non-vendor supplied DSDTs are created by end-users who bought machines
that don't work.  Per the DSDT link above, one can extract,
dis-assemble, modify a DSDT -- and tell Linux to use your copy instead
of the version burned into PROM.

While detailed hardware docs would be required to understand all the
code, that is not necessary to fix the majority of DSDT errors that
confuse Linux.  The common errors generally result from simple
programming blunders that are not caught at build-time by the partciular
AML compiler the vendor uses, nor at run-time by the particular OS the
vendor uses for validation.

When vendors use an improved AML compiler (such as the one freely
available from Intel;-), and test their platforms on ACPI-enabled Linux,
these problems generally go away and so does the topic of fixing broken
DSDTs.

Indeed, I'm not confident that fixing DSDTs for vendors is always a good
idea -- particularly if the vendors don't take the feedback.  I'd rather
see Linux users able to vote with their dollars to support vendors that
best support Linux.

That said, if you're stuck with a box that needs a DSDT fix -- I
encourage you to work with the vendor to get the DSDT fixed.  Yes, I've
seen handing them the fix on a silver platter work just fine;-)
However, as I'm not a lawyer and don't play one on TV, note that I can't
give anybody permission to _publish_ modified vendor firmware -- only
the vendor can do that. 

Cheers,
-Len
