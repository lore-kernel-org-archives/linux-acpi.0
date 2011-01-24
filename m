From: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: Re: [PATCH] fix a shutdown regression in intel_idle
Date: Mon, 24 Jan 2011 10:20:14 +0200
Message-ID: <201101241020.14223.ozan@pardus.org.tr>
References: <1295856001.1949.956.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:55997 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab1AXIZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jan 2011 03:25:57 -0500
In-Reply-To: <1295856001.1949.956.camel@sli10-conroe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, ari.m.savolainen@gmail.com

Pazartesi 24 Ocak 2011 g=C3=BCn=C3=BC (saat 10:00:01) Shaohua Li =C5=9F=
unlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1:
> Fix a shutdown regression caused by 2a2d31c8. Looks the clockevent fr=
amework
> can automatically shutdown broadcast timers for hotremove CPUs. And w=
e get a
> shutdown regression when we shutdown broadcast timer for hot remove C=
PU, so
> just delete some code.
> Also fix some section mismatch.

stable@kernel.org was CC'ed in 2a2d31c8 so this should be CC'ed too I t=
hink.

---
Ozan =C3=87a=C4=9Flayan
TUBITAK/UEKAE - Pardus Linux
http://www.pardus.org.tr/eng
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
