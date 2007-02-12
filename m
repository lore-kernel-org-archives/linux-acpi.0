From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: /proc/acpi/ac_adapter/AC is missing after latest ACPI merge
Date: Mon, 12 Feb 2007 20:45:33 +0200
Message-ID: <200702122045.34951.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:43342 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965292AbXBLSpd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Feb 2007 13:45:33 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi all,

After latest ACPI merge /proc/acpi/ac_adapter/AC has gone fishing :

[~]> ls -al /proc/acpi/ac_adapter/
dr-xr-xr-x  2 root root 0 =C5=9Eub 12 20:44 ADP1

[~]> ls -al /proc/acpi/ac_adapter/ADP1
-r--r--r-- 1 root root 0 =C5=9Eub 12 20:44 state

This at least breaks HAL which thinks AC is always plugged in, is this =
change=20
intentional?

Regards,
ismail
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
