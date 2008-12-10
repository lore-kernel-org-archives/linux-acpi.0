From: Timo Hoenig <thoenig@nouse.net>
Subject: Re: [PATCH 01/02] Initial work to let ACPI buttons work over INPUT
 layer
Date: Wed, 10 Dec 2008 10:26:05 +0100
Message-ID: <1228901165.10450.13.camel@zimtstern>
References: <200811291834.46109.dnascimento@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:39008 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYLJJZx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2008 04:25:53 -0500
In-Reply-To: <200811291834.46109.dnascimento@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dnascimento@gmail.com, corentincj@iksaif.net, sziwan@users.sourceforge.net
Cc: linux-acpi@vger.kernel.org, Nicolas Trangez <ikke@nicolast.be>

Hi!

On Sat, 2008-11-29 at 18:34 -0200, Daniel Oliveira Nascimento wrote:

> Updated work of Nicolas Trangez to support INPUT layer in
> asus-laptop driver in git branch.
> 
> Initial discussion can be found here:
> http://article.gmane.org/gmane.linux.acpi.acpi4asus.user/217

Daniel, Nicolas, thanks for the two patches.

I've been testing your patches on two systems (c.f.
https://bugzilla.novell.com/show_bug.cgi?id=448004 ) and confirm that
they just work fine.

Has there been any response regarding an mainline inclusion?  I'm just
following linux-acpi.  At least there didn't see any response.

Adding Corentin and Karol to CC.

Thanks,

   Timo

