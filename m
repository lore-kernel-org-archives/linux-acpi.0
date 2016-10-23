From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi/apei: Fix in-correct return value
Date: Sun, 23 Oct 2016 02:09:28 +0200
Message-ID: <2947283.b7DfXarnOp@vostro.rjw.lan>
References: <20161018160719.31252-1-punit.agrawal@arm.com> <1979931.ATDSke4qB1@vostro.rjw.lan> <20161022163735.emhpdrzfbyys7rcp@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60947 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S935093AbcJWAC3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 22 Oct 2016 20:02:29 -0400
In-Reply-To: <20161022163735.emhpdrzfbyys7rcp@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, tbaicar@codeaurora.org, Len Brown <lenb@kernel.org>

On Saturday, October 22, 2016 06:37:35 PM Borislav Petkov wrote:
> On Fri, Oct 21, 2016 at 11:28:29PM +0200, Rafael J. Wysocki wrote:
> > Boris, all fine here?
> 
> Short answer: Yeah, looks ok to me.
> 
> Longer answer: I mean, this way ghes_proc() *actually* propagates the
> return value of ghes_read_estatus() and we don't do any processing if it
> failed.
> 
> Which doesn't really tell me a whole lot about the actual processing,
> i.e., what ghes_do_proc() did.
> 
> But ghes_do_proc() doesn't return anything and ghes_proc()'s retval is
> used only in contexts where we're asking whether something got processed
> or not.
> 
> And for that, that fix is adequate. So:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks!

