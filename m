From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Dell PE-1900
Date: Fri, 18 Jan 2008 16:40:09 -0500
Message-ID: <200801181640.09874.lenb@kernel.org>
References: <4760696D.3090304@amixsi.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45586 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbYARVkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 16:40:33 -0500
In-Reply-To: <4760696D.3090304@amixsi.com.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Railson de Castro Guilherme <railson@amixsi.com.br>
Cc: linux-acpi@vger.kernel.org

On Wednesday 12 December 2007 18:06, Railson de Castro Guilherme wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Dell Inc.
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: PowerEdge 1900

Did you get messages about OSI(Linux) in your dmesg?

If so...

With 2.6.22, did you notice any functional difference with "acpi_osi=3D=
!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=3DLinux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
