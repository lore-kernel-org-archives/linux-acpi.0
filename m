From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
Subject: Re: Asus Eee 901Go ACPI errors on 2.6.30-rc4-git4
Date: Sat, 9 May 2009 19:47:01 -0600
Message-ID: <20090510014701.GA17193@ellpspace.math.ualberta.ca>
References: <87vdobq48p.fsf@fzidpc73.tu-graz.ac.at> <9b2b86520905080646r85f30bcp6f50d7388d8289f5@mail.gmail.com> <20090509025643.GA24335@ellpspace.math.ualberta.ca> <9b2b86520905090113v427c1de8n4d8479016701d30a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ellpspace.math.ualberta.ca ([129.128.207.67]:34428 "EHLO
	ellpspace.math.ualberta.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461AbZEJBrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 May 2009 21:47:22 -0400
Content-Disposition: inline
In-Reply-To: <9b2b86520905090113v427c1de8n4d8479016701d30a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Mario Lang <mlang@tugraz.at>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Sat, May 09, 2009 at 09:13:18AM +0100, Alan Jenkins wrote:
> On 5/9/09, Michal Jaegermann <michal@ellpspace.math.ualberta.ca> wrote:
> 
> > https://bugzilla.redhat.com/buglist.cgi?quicksearch=+Method+parse%2Fexecution+failed
> >
> > brings a list where it is possible to find something of that sort
> > in different settings too.
> 
> I think that's a very general failure message, that ACPI failed to
> execute some method.  I don't think there are any other EC (Embedded
> Controller) failures on that list.

Hm, at least https://bugzilla.redhat.com/show_bug.cgi?id=472650#c5
seems to be quite similar.  It says:

ACPI Error (evregion-0315): No handler for Region [EC__] (f780b848)
[EmbeddedControl] [20080609]
....
and so on.  That is for GX700 laptop from MSI.

I did not go through every of those reports from the referenced list.

    Michal
