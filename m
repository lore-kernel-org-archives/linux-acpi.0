From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI video.c brightness handler conflicts with toshiba_acpi
Date: Wed, 29 Oct 2008 22:01:48 +0100
Message-ID: <200810292201.49882.trenn@suse.de>
References: <200809061108.34877.arvidjaar@mail.ru> <200810291654.56710.trenn@suse.de> <20081029171346.GC7734@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:42468 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbYJ2VBl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 17:01:41 -0400
In-Reply-To: <20081029171346.GC7734@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, toshiba_acpi@memebeam.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, preining@logic.at

On Wednesday 29 October 2008 06:13:46 pm Andi Kleen wrote:
> On Wed, Oct 29, 2008 at 04:54:54PM +0100, Thomas Renninger wrote:
> > > So far I am running with these commits from
> > > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6:
> >
> > This tree does not exist anymore...
>
> It is now linux-acpi-summer2008-2.6
> I renamed to avoid confusion with Len's tree.
> But Len should have taken all the patches in there.

Hmm, looks like he did not.
Thanks for the pointer to the old tree, that made things easy.
I am going to post them to Len privately for inclusion into his test branch 
for now, there should be no need to post them on several lists a fifth 
time...
Let's see whether they still pop up in his next pull request for .28, 
hopefully they do...

Thanks,

      Thomas
