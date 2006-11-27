From: Daniel Drake <ddrake@brontes3d.com>
Subject: AE_NOT_FOUND while evaluating SleepState [\_S3_]
Date: Mon, 27 Nov 2006 10:18:02 -0500
Message-ID: <1164640682.8724.2.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp135.iad.emailsrvr.com ([207.97.245.135]:52378 "EHLO
	smtp135.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1754450AbWK0PSF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 10:18:05 -0500
Received: from [10.20.253.243] (host34.155.212.242.conversent.net [155.212.242.34])
	(Authenticated sender: ddrake@brontes3d.com)
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id B782644C016
	for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2006 10:18:02 -0500 (EST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm looking into suspend-to-RAM on my Tyan S2895 K8WE motherboard
(x86-64). It does not work, "mem" is not listed in /sys/power/state

I have tracked down the problem to this code
(acpi_get_sleep_type_data(), drivers/acpi/hardware/hwregs.c)

  /*Evaluate the namespace object containing the values for this state*/
  status = acpi_ns_evaluate(info);
  if (ACPI_FAILURE(status)) {
    ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
                      "%s while evaluating SleepState [%s]\n",
                      acpi_format_exception(status),
                      info->pathname));

    goto cleanup;
  }

The message produced is:
        AE_NOT_FOUND while evaluating SleepState [\_S3_]

Does this system simply not support suspend-to-RAM or can something be
done on the Linux side?

The system does support: S0 S1 S4 S5

acpidump:
http://dev.gentoo.org/~dsd/misc/s2895-acpidump.txt

Thanks!

-- 
Daniel Drake
Brontes Technologies, A 3M Company

