From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
Date: Fri, 21 Dec 2018 19:59:37 +0100
Message-ID: <20181221185937.GL1325@zn.tnic>
References: <1545238252-79630-1-git-send-email-darcari@redhat.com>
 <20181220192447.GG31403@zn.tnic>
 <1691682.ckC9UJvgEr@aspire.rjw.lan>
 <0bb80989-4fe5-c320-8ffc-0f39502110c9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0bb80989-4fe5-c320-8ffc-0f39502110c9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: David Arcari <darcari@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 21, 2018 at 06:52:20PM +0000, James Morse wrote:
> Do we need to ghes_ack_error() too?

That's GHES v2 AFAICT.

> With the location cleared the new kernel will never find the records, and
> firmware can never re-use that location because it wasn't ack'd. The upshot is
> RAS records can't be generated for the kdump kernel. The acpi spec talks about
> use of the memory, so I don't think its fair for it to use this to disarm a
> watchdog.
> 
> I think we can live with this as the kdump kernel isn't going to handle RAS
> errors for the bulk of memory anyway.

Usually, handling hw errors is always better than not but the second
kernel can't do anything better in that respect than the first, right?
If it panics, it panics - no matter the kernel. Generally.

Therefore I think the role of the second kernel should be to be as
resilient as possible to hw errors - like, not even see them :-) - dump
the memory of the first kernel as quickly as possible and reboot for
analysis.

IMHO, of course.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
