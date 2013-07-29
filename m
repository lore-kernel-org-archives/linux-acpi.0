From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] APEI/ERST: Fix error message formatting
Date: Mon, 29 Jul 2013 16:40:46 +0200
Message-ID: <20130729144046.GE6634@pd.tnic>
References: <1374526866-6813-1-git-send-email-bp@alien8.de>
 <20130724171347.GB29756@naverao1-tp.watson.ibm.com>
 <1374686598.18818.18.camel@joe-AO722>
 <51F10AA8.2050901@linux.vnet.ibm.com>
 <CAErSpo5vLbsM5BXjrCVy1AKBxRRSH33TthyyK3O35Mghqw81nQ@mail.gmail.com>
 <20130729135812.GD6634@pd.tnic>
 <CAErSpo6fbMmicX95j_wYkJRnQeJEZ_jQSm76j9ZN4sHP0C2Yhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo6fbMmicX95j_wYkJRnQeJEZ_jQSm76j9ZN4sHP0C2Yhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 29, 2013 at 08:28:05AM -0600, Bjorn Helgaas wrote:
> > @@ -186,7 +186,7 @@ static int erst_exec_stall(struct apei_exec_context *ctx,
> >
> >         if (ctx->value > FIRMWARE_MAX_STALL) {
> >                 if (!in_nmi())
> > -                       pr_warning(FW_WARN ERST_PFX
> > +                       pr_warn(FW_WARN
> >                         "Too long stall time for stall instruction: %llx.\n",
> 
> You didn't change this part, but this and similar messages look less
> useful than they could be.  We're printing in hex, but there's no
> indication in the output (no "0x" prefix).  And there's no instruction
> pointer or anything to help connect this back to the source of the
> problem.

Sounds like we don't want to print ctx->value at all but simply signal
about the stall? Or?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
