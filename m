From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 13:45:27 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64778 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751270AbWDTFph convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2006 01:45:37 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

>Sleep and power buttons are logically part of the keyboard, 
>and it makes 
>for them to be exposed via an input device rather than an odd file in 
>/proc. This patch adds a keycode for lid switches (are we 
>running out of 
>keycodes?) and allows the button driver to register an input device.

Do you plan to port the whole acpi event interface into input layer?
If so,  keycode is NOT a right way.

--Luming
