From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH][v2] ACPI: Do not report _OSI("Darwin") when
 acpi_osi=!Darwin provided
Date: Mon, 1 Feb 2016 10:54:26 +0200
Message-ID: <CAHp75VdaNFVA10X_N-URqmKAv3upOF2zT083T0tiN1=DnLqNbA@mail.gmail.com>
References: <1454293612-13161-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34239 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcBAIy1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2016 03:54:27 -0500
In-Reply-To: <1454293612-13161-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, matthew.garrett@nebula.com, "Zhang, Rui" <rui.zhang@intel.com>

On Mon, Feb 1, 2016 at 4:26 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> Commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly") always
> reports positive value when Apple hardware queries _OSI("Darwin").
> But sometimes the users might want to tell the hardware they don't
> need the Darwin feature, for example, users may leverage the hardware
> to power off the Thunderbolt, by appending acpi_osi=!Darwin in command
> line, thus Apple hardware regards it as an incompatible OS X system,
> hence turns off the Thunderbolt.


> +static bool acpi_osi_setup_disabled(char *str)
> +{
> +       int i;
> +       struct osi_setup_entry *osi;
> +
> +       if (!str)
> +               return false;
> +
> +       for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
> +               osi = &osi_setup_entries[i];
> +               if (!strcmp(osi->string, str)) {

Seems like we have one more user for
http://www.spinics.net/lists/kernel/msg2157535.html

> +                       if (!osi->enable)
> +                               return true;
> +                       else
> +                               return false;

return !osi->enable;

> +               }
> +       }
> +
> +       return false;
> +}


-- 
With Best Regards,
Andy Shevchenko
