From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Acpi oops 2.6.17.7 vanilla
Date: Wed, 9 Aug 2006 21:50:34 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1120723@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62221 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750817AbWHINux convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2006 09:50:53 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Rutgeerts <johan.rutgeerts@mech.kuleuven.be>, linux-acpi@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org

Please open a bug on bugzilla.kernel.org in ACPI category

Thanks
Luming=20

-----Original Message-----
=46rom: linux-kernel-owner@vger.kernel.org=20
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Johan Rutgeert=
s
Sent: 2006=C4=EA8=D4=C29=C8=D5 20:33
To: linux-acpi@vger.kernel.org
Cc: Brown, Len; linux-kernel@vger.kernel.org
Subject: Acpi oops 2.6.17.7 vanilla



Hi,


I frequently get kernel oopses (NULL pointer dereference),=20
which seem acpi=20
related.


Attached file contains kern.log info for a non-tainted 2.6.17.7 vanilla=
=20
kernel.



If it is of interest: I have put lots of similar oops reports=20
online, for=20
different kernels versions (ubuntu kernels and vanilla), at:
<http://people.mech.kuleuven.be/~jrutgeer/oopses/>.

=46or the earlier kernels of those, I used to have a lot of=20
"ACPI: read EC, IB=20
not empty" messages. These seem gone since I compiled a vanilla=20
2.6.17.7=20
kernel.


I'm testing a 2.6.18-rc4 kernel now. If there is anything else=20
I can do (e.g.=20
test older kernels), please let me know.



Greetings,

Johan Rutgeerts


Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
