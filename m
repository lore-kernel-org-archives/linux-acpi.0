From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: /proc/acpi/ac_adapter/AC is missing after latest ACPI merge
Date: Tue, 13 Feb 2007 09:36:34 +0200
Message-ID: <200702130936.37764.ismail@pardus.org.tr>
References: <200702122045.34951.ismail@pardus.org.tr> <200702130023.15495.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:38212 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751164AbXBMHgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 02:36:42 -0500
In-Reply-To: <200702130023.15495.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>

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
>
> grep CONFIG_ACPI_AC .config
>
> lsmod |grep ac


[~/GIT/linux-2.6]> grep CONFIG_ACPI_AC .config
CONFIG_ACPI_AC=3Dy

[~/GIT/linux-2.6]> lsmod|grep ac
af_packet              19976  2
cpufreq_userspace       3732  0

But it looks like older kernels had only  /proc/acpi/ac_adapter/ADP1 an=
d it=20
worked fine with HAL, maybe something in sysfs changed? Also for some r=
eason=20
hal-addon-acpi doesn't seem to start at all, which might be the problem=
=2E

Regards,
ismail
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
