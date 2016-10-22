From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] acpi/apei: Fix in-correct return value
Date: Sat, 22 Oct 2016 18:37:35 +0200
Message-ID: <20161022163735.emhpdrzfbyys7rcp@pd.tnic>
References: <20161018160719.31252-1-punit.agrawal@arm.com>
 <1979931.ATDSke4qB1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1979931.ATDSke4qB1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, tbaicar@codeaurora.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 21, 2016 at 11:28:29PM +0200, Rafael J. Wysocki wrote:
> Boris, all fine here?

Short answer: Yeah, looks ok to me.

Longer answer: I mean, this way ghes_proc() *actually* propagates the
return value of ghes_read_estatus() and we don't do any processing if it
failed.

Which doesn't really tell me a whole lot about the actual processing,
i.e., what ghes_do_proc() did.

But ghes_do_proc() doesn't return anything and ghes_proc()'s retval is
used only in contexts where we're asking whether something got processed
or not.

And for that, that fix is adequate. So:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
