From: Yu Luming <luming.yu@intel.com>
Subject: Re: acpi button event to input layer (was [RFC] [PATCH] Make ACPI button driver an input device)
Date: Tue, 5 Sep 2006 16:15:56 +0800
Message-ID: <200609051615.56245.luming.yu@intel.com>
References: <200608281506.50738.luming.yu@intel.com> <200608302257.25382.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4623 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932178AbWIEINO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2006 04:13:14 -0400
In-Reply-To: <200608302257.25382.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Thursday 31 August 2006 10:57, Dmitry Torokhov wrote:
> On Monday 28 August 2006 03:06, Yu Luming wrote:
>  > Matthew / Dmitry,
>  >
>  > I recall there was a patch to make acpi button driver as input dev=
ice.
>  > Do you have any update patch? Because we want to transition acpi e=
vent
>  > mechanism from /proc/acpi/event to input layer. I guess the acpi b=
utton
>  > driver would be the first one to complete such transition.
>  >
>  > http://www.gatago.com/linux/kernel/11320641.html
>
>  I sent the following patch to Len some time ago. It needs the attach=
ed
> cleanup patch.

Hi Dmitry,

The patch doesn't apply. It is somehow changed by email client or serve=
r.
And, I got :
patching file drivers/acpi/button.c
patch: **** malformed patch at line 4: =C2=A0#include <linux/types.h>

Could you please send the patch as attachment to me.

--=20
Thanks,
Luming
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
