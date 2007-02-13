From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: /proc/acpi/ac_adapter/AC is missing after latest ACPI merge
Date: Tue, 13 Feb 2007 13:51:51 +0200
Message-ID: <200702131352.13587.ismail@pardus.org.tr>
References: <200702122045.34951.ismail@pardus.org.tr> <200702130023.15495.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:33072 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751292AbXBMLwZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 06:52:25 -0500
In-Reply-To: <200702130023.15495.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 13 February 2007 07:23:15 Len Brown wrote:
> On Monday 12 February 2007 13:45, Ismail D=C3=B6nmez wrote:
> > Hi all,
> >
> > After latest ACPI merge /proc/acpi/ac_adapter/AC has gone fishing :
> >
> > [~]> ls -al /proc/acpi/ac_adapter/
> > dr-xr-xr-x  2 root root 0 =C5=9Eub 12 20:44 ADP1
> >
> > [~]> ls -al /proc/acpi/ac_adapter/ADP1
> > -r--r--r-- 1 root root 0 =C5=9Eub 12 20:44 state
> >
> > This at least breaks HAL which thinks AC is always plugged in, is t=
his
> > change intentional?
>
> no change intended here.

It was indeed a sysfs problem which commit=20
c2b6705b75d9c7aff98a4602a32230639e10891c fixed.

Regards,
ismail

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
