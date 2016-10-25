From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [bug report] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Tue, 25 Oct 2016 10:12:11 +0100
Message-ID: <2a67c6fc-602f-9bce-9dd4-d911789d5c0b@arm.com>
References: <20161025084352.GA21587@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbcJYJMM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Oct 2016 05:12:12 -0400
In-Reply-To: <20161025084352.GA21587@elgon.mountain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org

Hi Dan,

I am finding it difficult to understand this bug report. Please help.

On 25/10/16 09:43, Dan Carpenter wrote:
> Hello Sudeep Holla,
>
> The patch a36a7fecfe60: "ACPI / processor_idle: Add support for Low
> Power Idle(LPI) states" from Jul 21, 2016, leads to the following
> static checker warning:
>
> 	drivers/acpi/processor_idle.c:1261 acpi_processor_setup_lpi_states()
> 	warn: buffer overflow 'pr->power.lpi_states' 8 <= 9
>
> drivers/acpi/processor_idle.c
>   1250  static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
>   1251  {
>   1252          int i;
>   1253          struct acpi_lpi_state *lpi;
>   1254          struct cpuidle_state *state;
>   1255          struct cpuidle_driver *drv = &acpi_idle_driver;
>   1256
>   1257          if (!pr->flags.has_lpi)
>   1258                  return -EOPNOTSUPP;
>   1259

Currently CPUIDLE_STATE_MAX = 10 and ACPI_PROCESSOR_MAX_POWER = 8

>   1260          for (i = 0; i < pr->power.count && i < CPUIDLE_STATE_MAX; i++) {
>
                                                    ^^^^^^^^^^^^^^^^^

We have drv->states[10] and pr->power.lpi_states[8] and above check is 
to ensure we take the minimum of the 2 so that the logic continues to 
work if either of these are changed.

>
> Should this be ACPI_PROCESSOR_MAX_POWER?

No, because we don't want to overflow CPUIDLE_STATE_MAX too in case
that's reduced to say 6. pr->power.count is assured to be <=
ACPI_PROCESSOR_MAX_POWER

>
>   1261                  lpi = &pr->power.lpi_states[i];
>                                          ^^^^^^^^^^
> because that's how many elements we have in this array.
>

Yes that's correct but i < CPUIDLE_STATE_MAX is to ensure we don't
overflow drv->states.

Let me know if I am being stupid and not able to understand something here.

-- 
Regards,
Sudeep
