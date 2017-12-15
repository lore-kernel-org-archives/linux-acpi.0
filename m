From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] APEI / ERST: Fix missing error handling in erst_reader()
Date: Fri, 15 Dec 2017 11:52:42 +0100
Message-ID: <20171215105242.ed7b2nsanwgmoxl6@pd.tnic>
References: <20171214123116.929-1-tiwai@suse.de>
 <CAJZ5v0gAiSiwwcWpHXWGEpo_Tjy4tqy1D5XvL==BJeuQ6LRKOg@mail.gmail.com>
 <s5hmv2kwj47.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:50368 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755231AbdLOKwz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 05:52:55 -0500
Content-Disposition: inline
In-Reply-To: <s5hmv2kwj47.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jerry Tang <jtang@suse.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Dec 15, 2017 at 08:22:32AM +0100, Takashi Iwai wrote:
> On Fri, 15 Dec 2017 02:01:20 +0100,
> Rafael J. Wysocki wrote:
> > 
> > On Thu, Dec 14, 2017 at 1:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > > The commit f6f828513290 ("pstore: pass allocated memory region back to
> > > caller") changed the check of the return value from erst_read() in
> > > erst_reader() in the following way:
> > >
> > >         if (len == -ENOENT)
> > >                 goto skip;
> > > -       else if (len < 0) {
> > > -               rc = -1;
> > > +       else if (len < sizeof(*rcd)) {
> > > +               rc = -EIO;
> > >                 goto out;
> > >
> > > This introduced another bug: since the comparison with sizeof() is
> > > cast to unsigned, a negative len value doesn't hit any longer.
> > > As a result, when an error is returned from erst_read(), the code
> > > falls through, and it may eventually lead to some weird thing like
> > > memory corruption.
> > >
> > > This patch adds the negative error value check more explicitly for
> > > addressing the issue.
> > >
> > > Fixes: f6f828513290 ("pstore: pass allocated memory region back to caller")
> > 
> > That's ancient. :-)
> > 
> > > Cc: <stable@vger.kernel.org>
> > > Tested-by: Jerry Tang <jtang@suse.com>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  drivers/acpi/apei/erst.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> > > index 6742f6c68034..9bff853e85f3 100644
> > > --- a/drivers/acpi/apei/erst.c
> > > +++ b/drivers/acpi/apei/erst.c
> > > @@ -1007,7 +1007,7 @@ static ssize_t erst_reader(struct pstore_record *record)
> > >         /* The record may be cleared by others, try read next record */
> > >         if (len == -ENOENT)
> > >                 goto skip;
> > > -       else if (len < sizeof(*rcd)) {
> > > +       else if (len < 0 || len < sizeof(*rcd)) {
> > >                 rc = -EIO;
> > >                 goto out;
> > >         }
> > > --
> > 
> > OK, I'm going to queue this up unless I see objections from Boris or Tony.
> 
> I missed Boris in Cc list, sorry.  Now added.

LGTM.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
