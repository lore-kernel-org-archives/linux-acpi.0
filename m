From: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez@opensuse.org>
Subject: Re: [Update][PATCH] ACPI / PCI / PM: Fix device PM regression related
 to D3hot/D3cold
Date: Wed, 16 May 2012 16:47:24 -0400
Message-ID: <4FB4125C.6090808@opensuse.org>
References: <5165867.6kdtKH1k0B@penguin> <201205161224.26007.rjw@sisk.pl> <201205162215.21429.rjw@sisk.pl> <201205162250.11101.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53811 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab2EPUr3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 May 2012 16:47:29 -0400
Received: by gglu4 with SMTP id u4so1159866ggl.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 May 2012 13:47:28 -0700 (PDT)
In-Reply-To: <201205162250.11101.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lekensteyn <lekensteyn@gmail.com>, rockorequin@hotmail.com, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

El 16/05/12 16:50, Rafael J. Wysocki escribi=F3:

> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D43228
> Reported-by: rocko<rockorequin@hotmail.com>
> Reported-by: Cristian Rodr=EDguez<crrodriguez@opensuse.org>
> Reported-and-tested-by: Peter<lekensteyn@gmail.com>
> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> ---
>
> The previous patch was still insufficient due to the missing change
> in drivers/acpi/scan.c.  Please test this one.
>
Thank you for taking a look at this, I will test this last patch later=20
today, sorry for the lag ;)




--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
