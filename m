From: "Zhao, Yakui" <yakui.zhao@intel.com>
Subject: RE: ACPI Extras version 0.30 unsupported model F3JA
Date: Sun, 13 Apr 2008 18:15:32 +0800
Message-ID: <9D7649D18729DE4BB2BD7B494F7FEDC20122C2F0@pdsmsx415.ccr.corp.intel.com>
References: <1208044615.4224.12.camel@ri.homelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25689 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973AbYDMKPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Apr 2008 06:15:37 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1208044615.4224.12.camel@ri.homelinux.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: huan@autistici.org, linux-acpi@vger.kernel.org

Thanks for the DSDT file.
Will you please try to set "CONFIG_ASUS_LAPTOP" instead of "CONFIG_ACPI=
_ASUS" in kernel configuration?


-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Paride Desimone
Sent: 2008=C4=EA4=D4=C213=C8=D5 7:57
To: linux-acpi@vger.kernel.org
Subject: ACPI Extras version 0.30 unsupported model F3JA

Hi,
I'll reading dmseg and i found:

Asus Laptop ACPI Extras version 0.30
  unsupported model F3JA, trying default values
  send /proc/acpi/dsdt to the developers

Paride Desimone
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
