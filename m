From: Neil Bird <neil@fnxweb.com>
Subject: sleeping function called from invalid context
Date: Mon, 11 Sep 2006 09:50:12 +0100
Message-ID: <45052344.6040200@fnxweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.uk.thalesgroup.com ([194.128.85.6]:8978 "EHLO
	crawsmail1.uk.thalesgroup.com") by vger.kernel.org with ESMTP
	id S1751276AbWIKIuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2006 04:50:16 -0400
Received: from mail.uk.thalesgroup.com (lisc0021.int.rdel.co.uk) by crawsmail1.uk.thalesgroup.com
 (Content Technologies SMTPRS 4.3.14) with ESMTP id <T7aa8b17b45c0a85c02760@crawsmail1.uk.thalesgroup.com> for <linux-acpi@vger.kernel.org>;
 Mon, 11 Sep 2006 09:50:13 +0100
Received: from ntscxch1.int.rdel.co.uk (ntscxch1.int.rdel.co.uk [172.21.100.149])
	by mail.uk.thalesgroup.com (8.12.8/8.12.8) with ESMTP id k8B8oDhX021093
	for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2006 09:50:13 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


   Not entirely sure this is the correct place for this, but Google did=
n't=20
show up anything obviously better.


   I'm trying to add functionality to a kernel module which processes=20
various input from Sony Vaio laptops (brightness and the Fn keys) by re=
ading=20
from ACPI.  This originally did the ACPI reads during a /proc entry rea=
d=20
(user driven).

   I'm now trying to drive this read automatically by catching key pres=
s=20
events and using that as a trigger.

   However, in the input event callback, and also (as another attempt) =
in a=20
tasklet process/callback the necessary call 'acpi_evaluate_object()' fa=
ils=20
with an error =E2=80=9Csleeping function called from invalid context=E2=
=80=9D.

   The kernel trace suggests this is something to do with a kmalloc() u=
nder=20
a variant of the acpi read that involves having a 'relative ACPI path' =
(the=20
string names of the registers (?) are 4-chars, not fully qualified=E2=80=
=A0);  I'm=20
afraid I forget the exact function called by acpi_evaluate_object() tha=
t's=20
listed.


   Does anyone know the rules for when acpi_evaluate_object() can be ca=
lled,=20
or maybe suggest another way of getting the data?  (please bear in mind=
 I=20
know little of ACPI!).  I tried to determine the full path in case the =
call=20
worked in that context;  it looked like it ought to be something like=20
_SB.xxx.xxx.GBRT instead of GBRT, and I can find this sort of hierarchy=
=20
under acpi under /sys but I *can't* find the actual fields I want (e.g.=
,=20
GBRT) listed, even though they work (I may well be mis-interpreting thi=
s=20
/sys tree).

   This is on Fedora Core 5, kernel 2.6.17-1.2174_FC5.

--=20
[neil@fnx ~]# rm -f .signature
[neil@fnx ~]# ls -l .signature
ls: .signature: No such file or directory
[neil@fnx ~]# exit

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
