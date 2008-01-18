From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode of Acer 5050 Aspire 5053NWXMi
Date: Fri, 18 Jan 2008 16:45:58 -0500
Message-ID: <200801181645.58277.lenb@kernel.org>
References: <1197081036.3112.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37329 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758568AbYARVqM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 16:46:12 -0500
In-Reply-To: <1197081036.3112.2.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: thomas.ramapuram@gmail.com
Cc: linux-acpi@vger.kernel.org

On Friday 07 December 2007 21:30, Thomas Ramapuram wrote:
> System Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: Acer, inc.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: Aspire 5050 =C2=A0 =C2=A0

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
