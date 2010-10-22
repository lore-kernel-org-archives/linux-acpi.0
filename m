From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Make Embedded Controller command timeout delay configurable
Date: Sat, 23 Oct 2010 01:43:24 +0200
Message-ID: <201010230143.24858.rjw@sisk.pl>
References: <201010211824.57893.trenn@suse.de> <201010222322.00618.rjw@sisk.pl> <201010230046.06637.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45630 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab0JVXo0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Oct 2010 19:44:26 -0400
In-Reply-To: <201010230046.06637.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Saturday, October 23, 2010, Thomas Renninger wrote:
> On Friday 22 October 2010 11:22:00 pm Rafael J. Wysocki wrote:
> > On Friday, October 22, 2010, Len Brown wrote:
> > > applied
> > 
> > OK
> > 
> > What if I do ec_delay=0 ?
> Same as with quite some other boot params:
> Your machine won't boot.
> 
> Why should this be a problem?

Because your intention is to allow the users to _increase_ the delay and not
to decrease it.  Decreasing it is known dangerous, so why don't you simply
put a limit in there?

I know there are many boot params that will hurt you if not used with care,
but is that a sufficient reason for adding another one?

Rafael
