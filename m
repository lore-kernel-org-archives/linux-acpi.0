From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: use a separate platform device for hwmon and name it (v2)
Date: Wed, 26 Sep 2007 02:46:43 -0400
Message-ID: <200709260246.43715.lenb@kernel.org>
References: <11907130833895-git-send-email-hmh@hmh.eng.br> <1190713083843-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55632 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667AbXIZGrG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Sep 2007 02:47:06 -0400
In-Reply-To: <1190713083843-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

On Tuesday 25 September 2007 05:38, Henrique de Moraes Holschuh wrote:
> Use a separate platform device and driver ("thinkpad_hwmon") to attach
> hwmon attributes and class, and add a name attribute of "thinkpad" to
> it, which defines the hwmon device name for libsensors4.
> 
> This makes thinkpad-acpi compatible with libsensors4 from lm-sensors, and
> the platform driver and device split will make it much easier to separate
> hwmon functionality into its own module later on.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/thinkpad-acpi.txt |   25 +++++++++---
>  drivers/misc/thinkpad_acpi.c    |   79 +++++++++++++++++++++++++++++++++------
>  drivers/misc/thinkpad_acpi.h    |    6 ++-
>  3 files changed, 91 insertions(+), 19 deletions(-)

previous 8/9 in the test tree is replaced by this one.

thanks,
-Len
