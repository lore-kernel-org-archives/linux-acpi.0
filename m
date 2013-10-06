From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: update win8 OSI blacklist
Date: Sun, 6 Oct 2013 21:59:28 +0100
Message-ID: <20131006205928.GA20296@srcf.ucam.org>
References: <1380820383-23336-1-git-send-email-felipe.contreras@gmail.com>
 <20131004161226.GA22784@srcf.ucam.org>
 <CAMP44s0tqKBgUTzFnbTMqDVVWLcaDC5VKd9mq_w+T_Yu19KXqQ@mail.gmail.com>
 <20131006203353.GA19795@srcf.ucam.org>
 <CAMP44s0N5xqD2W7-r-j1k3efo1k0qY2gCeqn+tbHsvOsrqOJgg@mail.gmail.com>
 <20131006204518.GA20077@srcf.ucam.org>
 <CAMP44s0GkVyw+PRYKqq7=MXFFtgUO9xCq6jTsoQV-rSRmC23yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55743 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab3JFU7b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Oct 2013 16:59:31 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0GkVyw+PRYKqq7=MXFFtgUO9xCq6jTsoQV-rSRmC23yg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Oct 06, 2013 at 03:51:05PM -0500, Felipe Contreras wrote:
> On Sun, Oct 6, 2013 at 3:45 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Sun, Oct 06, 2013 at 03:40:42PM -0500, Felipe Contreras wrote:
> >
> >> In case you didn't hear, the plan was to add an entry if a user
> >> reports the backlight not working correctly, and acpi_osi="!Windows
> >> 2012" fixing it with no negative effects. and that's what users did in
> >> bug #60682.
> >
> > So add that to each entry you're adding to the list.
> 
> No. These entries are already there, I'm merely updating it. I added a
> comment before the list, but the comment was removed.

There's no point in having a comment that describes a list, because 
someone will inevitably reorder them or insert things in between at some 
point. Add a comment per entry.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
