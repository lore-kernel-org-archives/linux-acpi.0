From: Zhang Rui <rui.zhang@intel.com>
Subject: Why is Scope(_TZ_) defined as ACPI_TYPE_THERMAL rather than
 ACPI_TYPE_LOCAL_SCOPE
Date: Mon, 20 Sep 2010 15:08:17 +0800
Message-ID: <1284966497.2111.3460.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42160 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887Ab0ITHHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Sep 2010 03:07:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>, "Brown, Len" <lenb@kernel.org>

Hi, Bob,

this is the code in utglobal.c,
/*
 * Predefined ACPI Names (Built-in to the Interpreter)
 *
 * NOTES:
 * 1) _SB_ is defined to be a device to allow \_SB_._INI to be run
 *    during the initialization sequence.
 * 2) _TZ_ is defined to be a thermal zone in order to allow ASL code to
 *    perform a Notify() operation on it.
 */
const struct acpi_predefined_names acpi_gbl_pre_defined_names[] = {
        {"_GPE", ACPI_TYPE_LOCAL_SCOPE, NULL},
        {"_PR_", ACPI_TYPE_LOCAL_SCOPE, NULL},
        {"_SB_", ACPI_TYPE_DEVICE, NULL},
        {"_SI_", ACPI_TYPE_LOCAL_SCOPE, NULL},
        {"_TZ_", ACPI_TYPE_THERMAL, NULL},
        {"_REV", ACPI_TYPE_INTEGER, (char *)ACPI_CA_SUPPORT_LEVEL},
        {"_OS_", ACPI_TYPE_STRING, ACPI_OS_NAME},
        {"_GL_", ACPI_TYPE_MUTEX, (char *)1},

I found a problem that Linux thermal driver tries to probe _TZ_ because
the _TZ_ ACPI namespace node type suggests it's a thermal device.

I'm wondering why it's a device rather than a scope.
The comment above says ASL code may perform a Notify() operation on it,
but IMO, this notification is meaningless on its own, because _TZ_ can
neither detect the temperature, nor cool the system down, i.e. no action
should be taken on this notification.

So I think we should change the type to ACPI_TYPE_LOCAL_SCOPE, just like
_PR_, _GPE.

BTW: yes, we can do the tricks in Linux/ACPI code, but it's more likely
an ACPICA problem. what do you think?

thanks,
rui

