From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Resume from Memory very slow on 2.6.37+
Date: Thu, 20 Jan 2011 02:50:30 +0100
Message-ID: <201101200250.30459.rjw@sisk.pl>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com> <201101192219.07569.rjw@sisk.pl> <AANLkTinvz=syQgiWkQLgu2ssutBNccKuyxdPcGj97npU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57639 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527Ab1ATBvT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jan 2011 20:51:19 -0500
In-Reply-To: <AANLkTinvz=syQgiWkQLgu2ssutBNccKuyxdPcGj97npU@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>, Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, January 20, 2011, Jeff Chua wrote:
> On Thu, Jan 20, 2011 at 5:19 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > OK, I'd like you to test the two patches I'll send in replies to this
> > message.
> > [1/2] - It will go back to using ioremap_cache() for NVS pages allocations.
> 
> Applied. This one makes resume effective.
> 
> > [2/2] - This one will move suspend_nvs_free() before device drivers' resume
> >        callbacks (should avoid conflicts with the drivers' mappings).
> 
> Applied. This one makes no difference. Without applying [1/2], this
> one makes resume hangs, so definitely needs to go along with [1/2].
> 
> Applied both and I've tried a few cycles and resume still working ok.

OK, thanks.

Len, can you push https://patchwork.kernel.org/patch/490071/ and
https://patchwork.kernel.org/patch/490061/ to Linus, please?

Rafael
