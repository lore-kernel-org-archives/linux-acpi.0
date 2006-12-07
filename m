From: "Brown, Len" <len.brown@intel.com>
Subject: RE: updated patches of sysfs branch
Date: Thu, 7 Dec 2006 05:19:33 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB602237C4D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C719E9.31CFDE77"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29153 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031976AbWLGKUI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 05:20:08 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C719E9.31CFDE77
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Rui,
this format is sort of a pain.
The message headers are not complete and thus can't be applied.
The messages are out of context -- so I have to manually
remove the checked in series and then insert the new patches
and then re-apply the series.

Ideally you'd re-send the entire series either as
individual patches, or in mbox format.
Here is an example of mbox format from Alexey.

My only complaint about Alexey's example is that
he doesn't put enough comments in the check-in section,
or in the code itself:-)

thanks,
-Len

ps. your previous patch series before this update
is currently exported in the test branch.
=20

>-----Original Message-----
>From: Zhang, Rui=20
>Sent: Friday, December 01, 2006 3:55 AM
>To: lenb@kernel.org
>Cc: linux-acpi@vger; Brown, Len; Li, Shaohua
>Subject: updated patches of sysfs branch
>
>> The following patches are on the "sysfs" branch of the ACPI git tree.
>>=20
>> To test, apply this e-mail series, or git pull from here:
>>=20
>>=20
>git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2
>.6.git sysfs
>>=20
>> I am hopeful that this series will settle down and make the=20
>test branch
>> shortly, and thus make its way into an upcoming -mm release,=20
>and then upstream.
>>
>These are updated patches against 2.6.19. Len, could you update them in
>sysfs branch please?
>
>Four patches are refreshed in all.
>[PATCH 4]: ACPI: add ACPI bus_type for driver model
>remove parameter "int state" of battery driver .resume method, which is
>added recently.
>[PATCH 11]: ACPI: Convert ACPI PCI .bind/.unbind to use PCI bridge
>driver
>remove useless codes and comments which is shown in last patch.
>[PATCH 13]: ACPI: use unique number as bus_id of ACPI devices in sysfs
>use "PNPID:instance_no" as bus_id of ACPI devices in sysfs instead of
>unique numbers.
>[PATCH 14]: ACPI: ibm_acpi: don't use '/' in driver names
>We add a new patch in this patch series.=20
>	ibm_acpi uses '/' in driver names, and this causes a=20
>failure when register an ibm_acpi driver.
>	This patch replace '/' with '_' in driver names.
>	Thank Henrique de Moraes Holschuh for generating this patch.
>
>Thanks,
>Ray
>
>

------_=_NextPart_001_01C719E9.31CFDE77
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit

X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from hdsmsx412.amr.corp.intel.com ([10.127.2.72]) by hdsmsx411.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830); Wed, 6 Dec 2006 15:47:37 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_002_01C71977.C3323A80"
Received: from fmsmsx334.amr.corp.intel.com ([132.233.42.1]) by hdsmsx412.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830); Wed, 6 Dec 2006 15:47:37 -0500
Received: from azsmsx334.amr.corp.intel.com ([10.2.121.57]) by fmsmsx334.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830); Wed, 6 Dec 2006 12:47:35 -0800
Received: from azsmsx334-2.ch.intel.com ([10.2.121.57]) by azsmsx334.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830); Wed, 6 Dec 2006 13:47:35 -0700
Received: from azsmga001.ch.intel.com ([10.2.17.19]) by azsmsx334-2.ch.intel.com with Microsoft SMTPSVC(6.0.3790.1830); Wed, 6 Dec 2006 13:47:34 -0700
Received: from unknown (HELO [10.125.4.21]) ([10.125.4.21])  by azsmga001.ch.intel.com with ESMTP; 06 Dec 2006 12:47:33 -0800
Content-class: urn:content-classes:message
Subject: EC patches in series
Date: Wed, 6 Dec 2006 15:47:31 -0500
Message-ID: <45772C63.7010600@linux.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: EC patches in series
Thread-Index: AccZd8N5ZBDcTzirT+qtchupkKlllw==
From: "Alexey Starikovskiy" <alexey.y.starikovskiy@linux.intel.com>
To: "Brown, Len" <len.brown@intel.com>

This is a multi-part message in MIME format.

------_=_NextPart_002_01C71977.C3323A80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Len,

This is 11 patch series of clean-ups.

Regards,
    Alex.

------_=_NextPart_002_01C71977.C3323A80
Content-Type: application/gzip;
	name="ec.mbox.gz"
Content-Transfer-Encoding: base64
Content-Description: ec.mbox.gz
Content-Disposition: inline;
	filename="ec.mbox.gz"

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
fs0Nmdi69eTJ3wnlYnxypQAA

------_=_NextPart_002_01C71977.C3323A80--

------_=_NextPart_001_01C719E9.31CFDE77--
