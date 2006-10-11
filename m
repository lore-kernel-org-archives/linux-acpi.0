From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: RE: Battery & cpufreq problems with HP nc6320
Date: Wed, 11 Oct 2006 13:46:57 +0400
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CE5930AF@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48202 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750925AbWJKJrU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 05:47:20 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org


Peter,

Please look at 
http://bugzilla.kernel.org/show_bug.cgi?id=6455

At least this patch works on nx6125.

Vladimir.

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Peter Clifton
Sent: Tuesday, October 10, 2006 11:36 PM
To: linux-acpi@vger.kernel.org
Subject: Battery & cpufreq problems with HP nc6320

Hi,

I've deliberatly used the same title as a previous message I saw in the
archives from Mike Kasick, Thu, 25 May 2006 11:17:33 -0700.

(I've BCC'd Mike, although I apologise if I got the wrong Mike Kasick!)

I'm in a similar situation with my HP / Compaq nc6320, with battery
status "hanging" after a little while of laptop use. (And speedstep
issues, but that is another problem)

I discovered the patch at:

http://librarian.launchpad.net/3435574/the-patch.txt

Unfortunately I can't remember its origin. Some Ubuntu support forum I
think.

I'm interested to know if this is an acceptable solution to fix the
problem, or if it simply a workaround to a problem elsewhere.

Perhaps some ACPI guru might have some insight.

Regards

Peter Clifton


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
