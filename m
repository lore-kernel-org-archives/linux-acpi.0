From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 01/02] Initial work to let ACPI buttons work over INPUT layer
Date: Wed, 10 Dec 2008 11:31:56 +0100
Message-ID: <200812101131.57130.corentin.chary@gmail.com>
References: <200811291834.46109.dnascimento@gmail.com> <1228901165.10450.13.camel@zimtstern>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f13.google.com ([209.85.218.13]:60347 "EHLO
	mail-bw0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946AbYLJKhB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Dec 2008 05:37:01 -0500
Received: by bwz6 with SMTP id 6so1018206bwz.13
        for <linux-acpi@vger.kernel.org>; Wed, 10 Dec 2008 02:36:59 -0800 (PST)
In-Reply-To: <1228901165.10450.13.camel@zimtstern>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timo Hoenig <thoenig@nouse.net>
Cc: dnascimento@gmail.com, corentincj@iksaif.net, sziwan@users.sourceforge.net, linux-acpi@vger.kernel.org, Nicolas Trangez <ikke@nicolast.be>

On Wednesday 10 December 2008 10:26:05 Timo Hoenig wrote:
> Hi!
>
> On Sat, 2008-11-29 at 18:34 -0200, Daniel Oliveira Nascimento wrote:
> > Updated work of Nicolas Trangez to support INPUT layer in
> > asus-laptop driver in git branch.
> >
> > Initial discussion can be found here:
> > http://article.gmane.org/gmane.linux.acpi.acpi4asus.user/217
>
> Daniel, Nicolas, thanks for the two patches.
>
> I've been testing your patches on two systems (c.f.
> https://bugzilla.novell.com/show_bug.cgi?id=448004 ) and confirm that
> they just work fine.
>
> Has there been any response regarding an mainline inclusion?  I'm just
> following linux-acpi.  At least there didn't see any response.

For mainline inclusion you should:
- CC Len Brown when sending the patch
- Maybe send only the final patch and give credits to Nicolas in the changelog, 
but not sure.

Anyway thanks for the patchs :)
