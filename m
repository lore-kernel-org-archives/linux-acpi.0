From: Hillf Danton <dhillf@gmail.com>
Subject: Re: [PATCH] Add ACPI and power trace points for laptop overheating
Date: Fri, 18 May 2012 21:27:29 +0800
Message-ID: <CAJd=RBCwLOxQwfmppxxJjfJzEJ+RSoL4MaE9wKtSrotKe2J56w@mail.gmail.com>
References: <1337263737-3541-1-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42396 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761163Ab2ERN13 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 May 2012 09:27:29 -0400
In-Reply-To: <1337263737-3541-1-git-send-email-andi@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

Hi Andi

On Thu, May 17, 2012 at 10:08 PM, Andi Kleen <andi@firstfloor.org> wrot=
e:
> From: Andi Kleen <ak@linux.intel.com>
>
> Add trace points for ACPI power events which are important for a lapt=
op's
> thermal: acpi throttling/pstate, ec communication, GPU overheating. U=
seful
> for understanding the thermal behaviour of laptops on the thermal edg=
e.
>
> The generic power events have gpu_limit, overtemp_pstate and overtemp=
_throttling
> I added ACPI specific new events for EC desynchronization (which
> seems to be a common problem, but is entirely uninstrumented currentl=
y),
> and can lead to lost throttling events.
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
> =C2=A0Documentation/trace/events-acpi.txt =C2=A0| =C2=A0 13 ++++++++
> =C2=A0Documentation/trace/events-power.txt | =C2=A0 20 +++++++++++++
> =C2=A0drivers/acpi/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0drivers/acpi/acpi-trace.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A07 ++++
> =C2=A0drivers/acpi/ec.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 ++
> =C2=A0drivers/acpi/processor_thermal.c =C2=A0 =C2=A0 | =C2=A0 =C2=A04=
 ++
> =C2=A0drivers/platform/x86/intel_ips.c =C2=A0 =C2=A0 | =C2=A0 =C2=A04=
 ++
> =C2=A0include/trace/events/power.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 51 ++++++++++++++++++++++++++++++++++
> =C2=A0kernel/trace/power-traces.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A03 ++
> =C2=A09 files changed, 107 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/events-acpi.txt
> =C2=A0create mode 100644 drivers/acpi/acpi-trace.c
>
[...]
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -73,3 +73,4 @@ obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) +=3D acpi_p=
ad.o
> =C2=A0obj-$(CONFIG_ACPI_IPMI) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0+=3D acpi_ipmi.o
>
> =C2=A0obj-$(CONFIG_ACPI_APEI) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0+=3D apei/
> +obj-$(CONFIG_TRACEPOINTS) =C2=A0 =C2=A0 =C2=A0+=3D acpi-trace.o
> \ No newline at end of file

=46or what the newline is?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
