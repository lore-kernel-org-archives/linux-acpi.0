From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Please pull ACPI updates
Date: Wed, 16 Jul 2008 16:33:01 -0700
Message-ID: <200807161633.01375.jbarnes@virtuousgeek.org>
References: <20080716214516.GA10777@basil.nowhere.org> <200807170011.12184.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-151.bluehost.com ([67.222.39.31]:55528 "HELO
	outbound-mail-151.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752557AbYGPXdI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 19:33:08 -0400
In-Reply-To: <200807170011.12184.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <andi@firstfloor.org>, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, July 16, 2008 3:11 pm Rafael J. Wysocki wrote:
> On Wednesday, 16 of July 2008, Andi Kleen wrote:
> > Linus,
> >
> > Please pull from
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-merge-2.6
> > release-2.6.27
> >
> > to get the initial ACPI updates for 2.6.27. We got a few more changes
> > dependent on yet unpulled trees and some other candidate patches,
> > but that's the bulk for the changes intended for 2.6.27. Most of that
> > has been collected by Len Brown before he went on sabbatical. I was
> > relatively conservative with additional changes so far.
>
> Well, IMO it would be better to merge PCI first.

Yeah, they're interdependent (I pulled from Len's tree, hopefully Andi 
preserved the changesets).  I had wanted to do a little more testing of what 
I've got, but I haven't heard any huge complaints so far so maybe things are 
ok.  I'll generate a pull request now.

Jesse
