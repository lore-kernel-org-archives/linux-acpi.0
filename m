From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [PATCH] ACPI: Fix the incorrect calculation about C-state idle
	time
Date: Wed, 2 Jun 2010 09:28:31 -0700
Message-ID: <AANLkTikacbr_8PnevNPE7smvpOv1PEAa9vsqjUXAxiO_@mail.gmail.com>
References: <1275447849-25761-1-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:15172 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579Ab0FBQ2h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 12:28:37 -0400
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com [172.25.105.81])
	by smtp-out.google.com with ESMTP id o52GSYmB004768
	for <linux-acpi@vger.kernel.org>; Wed, 2 Jun 2010 09:28:35 -0700
Received: from yxk8 (yxk8.prod.google.com [10.190.3.136])
	by kpbe17.cbf.corp.google.com with ESMTP id o52GSXUB006543
	for <linux-acpi@vger.kernel.org>; Wed, 2 Jun 2010 09:28:33 -0700
Received: by yxk8 with SMTP id 8so359629yxk.18
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2010 09:28:33 -0700 (PDT)
In-Reply-To: <1275447849-25761-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, Jun 1, 2010 at 8:04 PM,  <yakui.zhao@intel.com> wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
>
> The C-state idle time is not calculated correctly, which will return =
the wrong
> residency time in C-state. It will have the following effects:
> =A0 1. =A0The system can't choose the deeper C-state when it is idle =
next time.
> Of course the system power is increased. E.g. On one server machine a=
bout 40W
> idle power is increased.
> =A0 2. =A0The powertop shows that it will stay in C0 running state ab=
out 95% time
> although the system is idle at most time.

This was a bug from my recent patch here :-(
http://marc.info/?l=3Dlinux-acpi&m=3D127198016715509&w=3D2

Thanks for catching this..

Acked-by: Venkatesh Pallipadi <venki@google.com>

>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Reported-by: Yu Zhidong <zhidong.yu@intel.com>
> Tested-by: Yu Zhidong <zhidong.yu@intel.com>
> CC: Venkatesh Pallipadi <venki@google.com>
> ---
> =A0drivers/acpi/processor_idle.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_i=
dle.c
> index 2e8c27d..6b38a6b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1022,7 +1022,7 @@ static int acpi_idle_enter_bm(struct cpuidle_de=
vice *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&c3_lock);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0kt2 =3D ktime_get_real();
> - =A0 =A0 =A0 idle_time_ns =3D ktime_to_us(ktime_sub(kt2, kt1));
> + =A0 =A0 =A0 idle_time_ns =3D ktime_to_ns(ktime_sub(kt2, kt1));
> =A0 =A0 =A0 =A0idle_time =3D idle_time_ns;
> =A0 =A0 =A0 =A0do_div(idle_time, NSEC_PER_USEC);
>
> --
> 1.5.4.5
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
