From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] Move ACPI power meter driver to hwmon
Date: Fri, 29 Apr 2011 10:04:43 -0700
Message-ID: <1304096683.31666.289.camel@groeck-laptop>
References: <20110429185312.1c5bbd84@endymion.delvare>
Reply-To: guenter.roeck@ericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:46158 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799Ab1D2RHO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Apr 2011 13:07:14 -0400
In-Reply-To: <20110429185312.1c5bbd84@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Darrick J. Wong" <djwong@us.ibm.com>, Len Brown <lenb@kernel.org>

On Fri, 2011-04-29 at 12:53 -0400, Jean Delvare wrote:
> As discussed earlier, the ACPI power meter driver would better live
> in drivers/hwmon, as its only purpose is to create hwmon-style
> interfaces for ACPI 4.0 power meter devices. Users are more likely to
> look for it there, and less likely to accidentally hide it by
> unselecting its dependencies.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: "Darrick J. Wong" <djwong@us.ibm.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Len Brown <lenb@kernel.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>


