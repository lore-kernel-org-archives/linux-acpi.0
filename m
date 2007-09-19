From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: 2.6.23-rc6-mm1 and acpi
Date: Wed, 19 Sep 2007 01:49:32 -0700
Message-ID: <20070919014932.316bb9d6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__19_Sep_2007_01_49_32_-0700_x7EKdvP2+msxHI56"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47682 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753522AbXISIti (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Sep 2007 04:49:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Michael Gerdau <mgerdau@tiscali.de>

This is a multi-part message in MIME format.

--Multipart=_Wed__19_Sep_2007_01_49_32_-0700_x7EKdvP2+msxHI56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Begin forwarded message:

Date: Tue, 18 Sep 2007 23:42:25 +0200
From: Michael Gerdau <mgerdau@tiscali.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.23-rc6-mm1 and acpi


Hi,

while trying to compile 2.6.23-rc6-mm1 I came across the following
build error:

mgd@seneca:/usr/src/linux-2.6.23-rc6-mm1> make modules
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
<stdin>:1389:2: warning: #warning syscall revokeat not implemented
<stdin>:1393:2: warning: #warning syscall frevoke not implemented
  CC [M]  drivers/acpi/sbs.o
drivers/acpi/sbs.c: In function ‘acpi_battery_alarm_show’:
drivers/acpi/sbs.c:457: error: implicit declaration of function ‘acpi_battery_get_alarm’
drivers/acpi/sbs.c: In function ‘acpi_battery_alarm_store’:
drivers/acpi/sbs.c:472: error: implicit declaration of function ‘acpi_battery_set_alarm’
drivers/acpi/sbs.c: In function ‘acpi_battery_add’:
drivers/acpi/sbs.c:829: warning: ignoring return value of ‘device_create_file’, declared with attribute warn_unused_result
make[2]: *** [drivers/acpi/sbs.o] Fehler 1
make[1]: *** [drivers/acpi] Fehler 2
make: *** [drivers] Fehler 2

Not sure who to CC, which is why I send it to the list alone.

Best,
Michael
-- 
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgerdau@tiscali.de
 GPG-keys available on request or at public keyserver


--Multipart=_Wed__19_Sep_2007_01_49_32_-0700_x7EKdvP2+msxHI56
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Disposition: attachment;
 filename="signature.asc"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC41IChHTlUv
TGludXgpCgppRDhEQlFCRzhFWlBVWVloeXV4RFFjNFJBbDR5QUo5VVYzbksxSTBvTSt0OUw1NlVi
dVdwaTB5YlNnQ2VPc29XCjlTRk5OWmhyNkgrYUFZZkVGSEZkQkNnPQo9a0tobAotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--Multipart=_Wed__19_Sep_2007_01_49_32_-0700_x7EKdvP2+msxHI56--
