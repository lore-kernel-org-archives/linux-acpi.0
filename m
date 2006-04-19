From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: acpi hotkey sysfs support
Date: Wed, 19 Apr 2006 09:48:37 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1331CCB@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39482 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750712AbWDSBsm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2006 21:48:42 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>, thoenig@suse.de, borislav@users.sf.net, john@neggie.net, tauber@informatik.hu-berlin.de, sziwan@hell.org.pl, "Brown, Len" <len.brown@intel.com>

Hi Garrett,

Since you have provided generic backlight support for ASUS/IBM/Toshiba
acpi driver, which can reduce the unnecessary interface complexity in
platform specific acpi driver for brightness control, do you plan to do
same
thing for Ouptput switch, sound volume control..?  Moreover, do you
think the proposal below still make sense?

--Luming
 
>Subject: acpi hotkey sysfs support
>
>Hello all,
>
>I have created a place under sysfs to have a unified place
>to gather user input for common hotkey features. 
>http://bugzilla.kernel.org/show_bug.cgi?id=5749#c10
>
>All of you are owner of a specific acpi hotkey driver. 
>Would you like to use that sysfs support to reduce the
>unnecessary interface complexity.
>
>Thanks a lot
>Luming
>-
