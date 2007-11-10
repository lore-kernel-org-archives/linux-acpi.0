From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: *NEW* ACPI driver to support App Hot Startup AKA PNP0C32
Date: Sat, 10 Nov 2007 03:21:21 +0000
Message-ID: <200711100321.22500.carlos@strangeworlds.co.uk>
References: <20071110014448.471e384b.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:34439 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbXKJDVn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Nov 2007 22:21:43 -0500
In-Reply-To: <20071110014448.471e384b.miknix@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-15?q?=C2ngelo_Miguel_Arrifano?= <miknix@gmail.com>
Cc: linux-acpi@vger.kernel.org

=C2ngelo,

On Saturday 10 November 2007 01:44:48 =C2ngelo Miguel Arrifano wrote:
> If the laptop is turned off and a hot button is pressed, the
> computer turns on and boots. This module gets a notification from
> ACPI which button was pressed. Then the driver writes to the proc
> fs which button was pressed allowing userspace apps to read that
> files and behave accordingly. Proc files are also writable.

Please use sysfs, not proc (even if you aren't considering submitting t=
his=20
upstream) - /proc/acpi is deprecated and going away (slowly but surely)=
=2E

-Carlos
--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
