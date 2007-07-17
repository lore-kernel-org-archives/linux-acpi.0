From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ACPI: EC: Handler for query 0x80 is not found!
Date: Mon, 16 Jul 2007 20:33:18 -0700
Message-ID: <20070716203318.66e25911.akpm@linux-foundation.org>
References: <48f7fe350707100653w6f01c645u388fbb4691b74c6b@mail.gmail.com>
	<48f7fe350707100947g1453a790n3e425935994003a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51891 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981AbXGQDdc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jul 2007 23:33:32 -0400
In-Reply-To: <48f7fe350707100947g1453a790n3e425935994003a9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ryan Hope <rmh3093@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tue, 10 Jul 2007 12:47:08 -0400 "Ryan Hope" <rmh3093@gmail.com> wrote:

> I noticed that this message goes away if I reboot my computer... So a
> fresh boot it errors, on reboot it does not error.
> 
> On 7/10/07, Ryan Hope <rmh3093@gmail.com> wrote:
> > Ever since 2.6.22-rc6-mm1 I have been seeing these messages in dmesg:
> >
> > ACPI: EC: Handler for query 0x80 is not found!
> > ACPI: EC: Handler for query 0x81 is not found!
> >
> > This did not happen in 2.6.22-rc4-mm1. Does anyone have any clue what
> > this is about?
> >

(switch to correct mailing list)

The acpi guys would probably like you to enter this in bugzilla.kernel.org,
please.

But given that this will be a regression if we merge it into
mainline, I hope that it will get urgent attention.
