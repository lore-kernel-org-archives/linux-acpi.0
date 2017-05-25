From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RESEND PATCH v2] acpi/nfit: Fix memory corruption/Unregister mce decoder on failure
Date: Thu, 25 May 2017 10:59:09 -0400
Message-ID: <x4960gpdltu.fsf@segfault.boston.devel.redhat.com>
References: <1495714243-5595-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933980AbdEYO7T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 May 2017 10:59:19 -0400
In-Reply-To: <1495714243-5595-1-git-send-email-prarit@redhat.com> (Prarit
        Bhargava's message of "Thu, 25 May 2017 08:10:43 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Linda Knippers <linda.knippers@hpe.com>

Prarit Bhargava <prarit@redhat.com> writes:

> I somehow managed to trim off the cc list ... oops.  Sorry about that.
>
> P.
>
> ----8<----
>
> nfit_init() calls nfit_mce_register() on module load.  When the module
> load fails the nfit mce decoder is not unregistered.  The module's
> memory is freed leaving the decoder chain referencing junk.  This will
> cause panics as future registrations will reference the free'd memory.
>
> Unregister the nfit mce decoder on module init failure.
>
> [v2]: register and then unregister mce handler to avoid losing mce events
>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Looks good to me.

Acked-by: Jeff Moyer <jmoyer@redhat.com>
