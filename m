From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Tue, 25 Oct 2016 11:43:52 +0300
Message-ID: <20161025084352.GA21587@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43334 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756202AbcJYIwa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2016 04:52:30 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep.Holla@arm.com
Cc: linux-acpi@vger.kernel.org

Hello Sudeep Holla,

The patch a36a7fecfe60: "ACPI / processor_idle: Add support for Low
Power Idle(LPI) states" from Jul 21, 2016, leads to the following
static checker warning:

	drivers/acpi/processor_idle.c:1261 acpi_processor_setup_lpi_states()
	warn: buffer overflow 'pr->power.lpi_states' 8 <= 9

drivers/acpi/processor_idle.c
  1250  static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
  1251  {
  1252          int i;
  1253          struct acpi_lpi_state *lpi;
  1254          struct cpuidle_state *state;
  1255          struct cpuidle_driver *drv = &acpi_idle_driver;
  1256  
  1257          if (!pr->flags.has_lpi)
  1258                  return -EOPNOTSUPP;
  1259  
  1260          for (i = 0; i < pr->power.count && i < CPUIDLE_STATE_MAX; i++) {
                                                       ^^^^^^^^^^^^^^^^^

Should this be ACPI_PROCESSOR_MAX_POWER?

  1261                  lpi = &pr->power.lpi_states[i];
                                         ^^^^^^^^^^
because that's how many elements we have in this array.

  1262  
  1263                  state = &drv->states[i];
  1264                  snprintf(state->name, CPUIDLE_NAME_LEN, "LPI-%d", i);
  1265                  strlcpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
  1266                  state->exit_latency = lpi->wake_latency;
  1267                  state->target_residency = lpi->min_residency;
  1268                  if (lpi->arch_flags)
  1269                          state->flags |= CPUIDLE_FLAG_TIMER_STOP;
  1270                  state->enter = acpi_idle_lpi_enter;
  1271                  drv->safe_state_index = i;
  1272          }
  1273  
  1274          drv->state_count = i;
  1275  
  1276          return 0;
  1277  }

regards,
dan carpenter
