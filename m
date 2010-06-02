From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: [Intel-gfx] [RFC PATCH 0/2] i915 brightness control
Date: Thu, 3 Jun 2010 00:20:39 +0100
Message-ID: <AANLkTiktSDWqHg_A8V5_jQsCf1w4k5x9Q7ZOCjAIZTEH@mail.gmail.com>
References: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223]:39343 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222Ab0FBXUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 19:20:41 -0400
Received: by ewy23 with SMTP id 23so826769ewy.1
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2010 16:20:40 -0700 (PDT)
In-Reply-To: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

On 2 June 2010 23:11, Kamal Mostafa <kamal@canonical.com> wrote:
> Requesting comments on this idea (proposed by Matthew Garrett) and my
> implementation. =A0Note especially the KNOWN PROBLEM with a "GM45" GP=
U.
>
> =A0-Kamal
>
> .......
>
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/568611
>
> In order to avoid the often-dysfunctional native acpi brightness cont=
rol
> methods, a new acpi_brightness_hook interface is made available.
>
> The i915 driver uses the new hook to take over brightness control.
> Boot with i915.brightness=3D0 to disable.
>
> KNOWN PROBLEM:
> =A0- i915 opregion brightness control silently fails on GM45 (pci-id =
0x2a42)
>
> [RFC PATCH 1/2] acpi/video: acpi_brightness_hook API
> [RFC PATCH 2/2] drm/i915: override acpi brightness control
>
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx
>

Are you sure this is a good idea to enable it by default just because
of a problem with one manufacturer (Dell)?

My Lenovo laptop has fine brightness control with a GM45 and this may b=
reak it.
Might be safer only to enable it for laptops with known problems.


Regards,
Pedro
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
