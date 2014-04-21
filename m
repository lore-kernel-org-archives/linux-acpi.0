From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] tools/power/acpi: Minor bugfixes
Date: Mon, 21 Apr 2014 23:10:06 +0200
Message-ID: <3288040.Ur0poF2ex1@vostro.rjw.lan>
References: <1396876617-53345-1-git-send-email-trenn@suse.de> <1396876617-53345-2-git-send-email-trenn@suse.de> <1AE640813FDE7649BE1B193DEA596E8802546FA3@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60575 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753489AbaDUUxs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2014 16:53:48 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802546FA3@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, April 08, 2014 02:19:20 AM Zheng, Lv wrote:
> Hi, Thomas
> 
> This one looks fine.
> Build tests are all passed.
> Thanks for fixing issues.

OK, queued up for the next pull request, thanks!

Rafael


> > From: Thomas Renninger [mailto:trenn@suse.de]
> > Sent: Monday, April 07, 2014 9:17 PM
> > 
> > - bindir is created, but sbindir is used -> fix that
> > - the debug parts are there twice (copy paste bug?). Remove one of the
> >   exact same parts
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > ---
> >  tools/power/acpi/Makefile |   11 +----------
> >  1 files changed, 1 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
> > index d9186a2..c2c0f20 100644
> > --- a/tools/power/acpi/Makefile
> > +++ b/tools/power/acpi/Makefile
> > @@ -89,15 +89,6 @@ else
> >  	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
> >  endif
> > 
> > -# if DEBUG is enabled, then we do not strip or optimize
> > -ifeq ($(strip $(DEBUG)),true)
> > -	CFLAGS += -O1 -g -DDEBUG
> > -	STRIPCMD = /bin/true -Since_we_are_debugging
> > -else
> > -	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
> > -	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
> > -endif
> > -
> >  # --- ACPIDUMP BEGIN ---
> > 
> >  vpath %.c \
> > @@ -128,7 +119,7 @@ clean:
> >  	-rm -f $(OUTPUT)acpidump
> > 
> >  install-tools:
> > -	$(INSTALL) -d $(DESTDIR)${bindir}
> > +	$(INSTALL) -d $(DESTDIR)${sbindir}
> >  	$(INSTALL_PROGRAM) $(OUTPUT)acpidump $(DESTDIR)${sbindir}
> > 
> >  install-man:
> > --
> > 1.7.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
