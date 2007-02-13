From: Len Brown <lenb@kernel.org>
Subject: Re: /proc/acpi/ac_adapter/AC is missing after latest ACPI merge
Date: Tue, 13 Feb 2007 00:23:15 -0500
Message-ID: <200702130023.15495.lenb@kernel.org>
References: <200702122045.34951.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35046 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161021AbXBMFZB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:25:01 -0500
In-Reply-To: <200702122045.34951.ismail@pardus.org.tr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 12 February 2007 13:45, Ismail D=C3=B6nmez wrote:
> Hi all,
>=20
> After latest ACPI merge /proc/acpi/ac_adapter/AC has gone fishing :
>=20
> [~]> ls -al /proc/acpi/ac_adapter/
> dr-xr-xr-x  2 root root 0 =C5=9Eub 12 20:44 ADP1
>=20
> [~]> ls -al /proc/acpi/ac_adapter/ADP1
> -r--r--r-- 1 root root 0 =C5=9Eub 12 20:44 state
>=20
> This at least breaks HAL which thinks AC is always plugged in, is thi=
s change=20
> intentional?

no change intended here.

grep CONFIG_ACPI_AC .config

lsmod |grep ac

cheers,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
