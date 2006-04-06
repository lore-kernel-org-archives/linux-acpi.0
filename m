From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: ACPI hotkeys and Panasonic R4
Date: Thu, 6 Apr 2006 09:16:12 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1190137@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27671 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751245AbWDFBRP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Apr 2006 21:17:15 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "David J. Wallace" <david@laohu.co.uk>
Cc: linux-acpi@vger.kernel.org

Please try boot option: acpi_generic_hotkey
Please don't forget apply patchs mentioned at:
http://bugzilla.kernel.org/show_bug.cgi?id=3D5749#c11

=46or panasonic , the patch just support :
echo -n xx > /sys/hotkey/brightness .

If you have other question, please feel free to ask.=20
=20
--Luming

>-----Original Message-----
>From: David J. Wallace [mailto:david@laohu.co.uk]=20
>Sent: 2006=C4=EA4=D4=C26=C8=D5 3:41
>To: Yu, Luming
>Subject: ACPI hotkeys and Panasonic R4
>
>Luming,
>
>I believe that you are the author of the Linux ACPI hotkey=20
>driver. I can not=20
>get this driver to load on my Panasonic R4. Is this laptop=20
>supported? I would=20
>appreciate any pointers in getting these going.=20
>
>I get the following message when trying to load the module:
>
>FATAL:Error inserting hotkey  (lib/modules....): No such device
>
>I've attached my dmesg and DSDT
>
>I would appreciate any assistance that you could offer.
>
>Thanks,
>
>David
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
