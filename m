From: Kirill Berezin <kyb22@rol.ru>
Subject: Curious ACPI thermal_zone handling.
Date: Mon, 07 Jul 2008 13:22:54 +0400
Message-ID: <4871E06E.80209@rol.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080600040607000305050101"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.rol.ru ([194.67.1.9]:48753 "EHLO smtp.rol.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbYGGJ0O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2008 05:26:14 -0400
Received: from pontus.sovam.com ([194.67.3.4]:42249 "EHLO [194.67.3.4]"
	smtp-auth: <none> TLS-CIPHER: <none> TLS-PEER-CN1: <none>
	rhost-flags-OK-OK-OK-FAIL) by gnome03.net.rol.ru with ESMTP
	id S5129541AbYGGJSp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2008 13:18:45 +0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080600040607000305050101
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

Linux ACPI system exhibits a vary curious behavior  on my 
Fujitsu-Siemens  pa1538 laptop. After an initial boot my laptop runs 
with slowly rotating fan. Fan continues rotating during the linux boot, 
gnome start and stops only when the temperature reaches active_trip 
point and fells below passive_trip. IMHO it is a little bit strange to 
hear rotating fan for a  core temperature less then 40 Celsius degrees.

google shows a lot of links, but I still cannot get what part of a 
system is responsible for fan start/stop -- hardware, kernel of some 
application?

And my second question is what is the preferable way to set trip points 
for current kernels?

I appreciate any help.

Kirill.



--------------080600040607000305050101
Content-Type: text/x-vcard; charset=utf-8;
 name="kyb22.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kyb22.vcf"

begin:vcard
fn;quoted-printable:=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB =D0=91=D0=B5=D1=80=D0=B5=D0=B7=D0=B8=
	=D0=BD
n;quoted-printable:;=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB =D0=91=D0=B5=D1=80=D0=B5=D0=B7=D0=B8=
	=D0=BD
org;quoted-printable:Golden Telecom;=D0=93=D1=80=D1=83=D0=BF=D0=BF=D0=B0 =D1=80=D0=B0=D0=B7=D0=B2=D0=B8=D1=82=
	=D0=B8=D1=8F ISP =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC, =D0=A1=D0=BE=D0=B2=
	=D0=B8=D0=BD=D1=82=D0=B5=D0=BB
email;internet:kyb22@rol.ru
title;quoted-printable:=D0=A1=D1=82=D0=B0=D1=80=D1=88=D0=B8=D0=B9 =D0=B8=D0=BD=D0=B6=D0=B5=D0=BD=
	=D0=B5=D1=80-=D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B8=D1=81=
	=D1=82
tel;work:+7 495 787 1345
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------080600040607000305050101--
