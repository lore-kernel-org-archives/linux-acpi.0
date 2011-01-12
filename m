From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 14/48] PM: Fix oops in suspend/hibernate code related to failing ioremap()
Date: Wed, 12 Jan 2011 21:05:09 +0100
Message-ID: <201101122105.10132.rjw@sisk.pl>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org> <20110112104027.f3fc302b.randy.dunlap@oracle.com> <4D2DF619.5@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57435 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab1ALUFw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jan 2011 15:05:52 -0500
In-Reply-To: <4D2DF619.5@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wednesday, January 12, 2011, Randy Dunlap wrote:
> On 01/12/11 10:40, Randy Dunlap wrote:
> > On Wed, 12 Jan 2011 19:39:19 +0100 Jiri Slaby wrote:
> > 
> >> On 01/12/2011 11:19 AM, Len Brown wrote:
> >>> @@ -271,7 +271,7 @@ static inline int suspend_nvs_register(unsigned long a, unsigned long b)
> >>>  }
> >>>  static inline int suspend_nvs_alloc(void) { return 0; }
> >>>  static inline void suspend_nvs_free(void) {}
> >>> -static inline void suspend_nvs_save(void) {}
> >>> +static inline int suspend_nvs_save(void) {}
> >>
> >> Aiee, I've just noticed, this needs to return something, otherwise a
> >> warning is generated for !CONFIG_SUSPEND_NVS.
> >>
> >> What's better for you, a followup or resend?
> > 
> > Yeah, I just made a patch for that, but I'll leave it up to
> > you and Len to haggle about.

We're removing CONFIG_SUSPEND_NVS in one of the later patches, but please send
the fix if it's still necessary after applying the entire series.

> Not that Len cares, but there is also this build error when
> ACPI is not enabled:
> 
> arch/x86/kernel/e820.c:734: error:implicit declaration of function 'suspend_nvs_register'
> 
> 
> I also have a patch for it.

Please submit it.

Thanks,
Rafael
