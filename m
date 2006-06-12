From: Norbert Preining <preining@logic.at>
Subject: Various battery related problems
Date: Mon, 12 Jun 2006 21:06:45 +0200
Message-ID: <20060612190645.GO13197@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:5595 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1752181AbWFLTGq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jun 2006 15:06:46 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3])
	by alpha.logic.tuwien.ac.at with esmtp (Exim 3.35 #1)
	id 1FprkL-0000nH-00
	for linux-acpi@vger.kernel.org; Mon, 12 Jun 2006 21:06:45 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 3.35 #1)
	id 1FprkL-0005zV-00
	for linux-acpi@vger.kernel.org; Mon, 12 Jun 2006 21:06:45 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all!

Quick overview: Now and then my kernel spits out this:
ACPI Error (exmutex-0248): Cannot release Mutex [MUT1], not acquired [2=
0060310]
ACPI Error (psparse-0522): Method parse/execution failed [\_SB_.BAT1._B=
ST] (Node f7c12a80), AE_AML_MUTEX_NOT_ACQUIRED
ACPI Exception (acpi_battery-0201): AE_AML_MUTEX_NOT_ACQUIRED, Evaluati=
ng _BST [20060310]


this is:
Acer TravelMate 3012WTMi
kernel 2.6.17-rc6-mm2
no custom dsdt table.

I found some references to similar problems in 2004 wrt to gnome
applets, which seems a bit strange.

Do you have any other ideas? Do i have to care for this?

Otherwise the battery applet in xfce4 show the status and remaining tim=
e
without any problems.

Best wishes and thanks a lot

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining AT logic DOT at>             Universit=E0=
 di Siena
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
SNITTERBY (n.)
Someone who pins snitters (q.v.) on to snitterfields (q.v.) and is
also suspected of being responsible for the extinction of virginstows
(q.v.)
			--- Douglas Adams, The Meaning of Liff
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
