From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 4 Feb 2009 17:12:57 +0100
Message-ID: <200902041713.00301.elendil@planet.nl>
References: <4989A784.3030604@suse.de> <200902041628.03675.elendil@planet.nl> <alpine.LRH.2.00.0902041642450.7690@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml20.KPNXCHANGE.COM ([213.75.38.85]:33841 "EHLO
	hpsmtp-eml20.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755545AbZBDQNE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Feb 2009 11:13:04 -0500
In-Reply-To: <alpine.LRH.2.00.0902041642450.7690@vixen.sonytel.be>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Frank Seidel <fseidel@suse.de>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, len.brown@intel.com, shaohuhua.li@intel.com, kristen.c.accardi@intel.com, frank@f-seidel.de

On Wednesday 04 February 2009, Geert Uytterhoeven wrote:
> > This patch looks broken to me, at least for some of your changes.
> > For example, in the bit quoted above all printks together make up
> > *one single* message, which means that only the _first_ of the
> > printks should have the KERN_* prefix. printks that are continuations
> > should not have the prefix.
>
> Actually they should, but the right prefix :-)

Hmm. I was going by memory and from what I've seen in existing code, but
also found this (somewhat old) post:
https://lists.linux-foundation.org/pipermail/kernel-janitors/2005-October/014375.html

> Quoting include/linux/kernel.h:
> | /*
> |  * Annotation for a "continued" line of log printout (only done after a
> |  * line that had no enclosing \n). Only to be used by core/arch code
> |  * during early bootup (a continued line is not SMP-safe otherwise).
> |  */
> | #define KERN_CONT       ""
>
> Please also consider the note about SMP-safeness.

>From that it looks like KERN_CONT should only be used in a very limited
context, but I guess this example qualifies.
