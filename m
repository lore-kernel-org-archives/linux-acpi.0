From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 1/4] tools/power/acpi: Minor bugfixes
Date: Tue, 8 Apr 2014 02:19:20 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802546FA3@SHSMSX101.ccr.corp.intel.com>
References: <1396876617-53345-1-git-send-email-trenn@suse.de>
 <1396876617-53345-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1287 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbaDHCYY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Apr 2014 22:24:24 -0400
In-Reply-To: <1396876617-53345-2-git-send-email-trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Thomas

This one looks fine.
Build tests are all passed.
Thanks for fixing issues.

Best regards
-Lv

> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Monday, April 07, 2014 9:17 PM
> 
> - bindir is created, but sbindir is used -> fix that
> - the debug parts are there twice (copy paste bug?). Remove one of the
>   exact same parts
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  tools/power/acpi/Makefile |   11 +----------
>  1 files changed, 1 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
> index d9186a2..c2c0f20 100644
> --- a/tools/power/acpi/Makefile
> +++ b/tools/power/acpi/Makefile
> @@ -89,15 +89,6 @@ else
>  	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
>  endif
> 
> -# if DEBUG is enabled, then we do not strip or optimize
> -ifeq ($(strip $(DEBUG)),true)
> -	CFLAGS += -O1 -g -DDEBUG
> -	STRIPCMD = /bin/true -Since_we_are_debugging
> -else
> -	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
> -	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
> -endif
> -
>  # --- ACPIDUMP BEGIN ---
> 
>  vpath %.c \
> @@ -128,7 +119,7 @@ clean:
>  	-rm -f $(OUTPUT)acpidump
> 
>  install-tools:
> -	$(INSTALL) -d $(DESTDIR)${bindir}
> +	$(INSTALL) -d $(DESTDIR)${sbindir}
>  	$(INSTALL_PROGRAM) $(OUTPUT)acpidump $(DESTDIR)${sbindir}
> 
>  install-man:
> --
> 1.7.6.1

