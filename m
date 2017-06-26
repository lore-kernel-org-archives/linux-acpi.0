From: Lukas Wunner <lukas@wunner.de>
Subject: ACPICA regression for empty ResourceTemplates
Date: Mon, 26 Jun 2017 10:38:15 +0200
Message-ID: <20170626083815.zxlohrjz64delbae@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:50003 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdFZIiS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jun 2017 04:38:18 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Ronald Tschalaer <ronald@innovation.ch>, linux-acpi@vger.kernel.org

Hi Robert,

ACPICA commit c8eac101 (= Linux commit a83019eb9f1f, "ACPICA: Update
resource descriptor handling") is causing a regression when parsing
an empty ResourceTemplate:

acpi_dev_get_resources() now returns -EIO because acpi_walk_resources()
returns AE_AML_NO_RESOURCE_END_TAG for a buffer than contains just a
lone end_tag.

The ACPI 6.1 spec, page 800 explicitly allows empty resource templates:

    ResourceTemplateTerm :=
        ResourceTemplate () {ResourceMacroList} => Buffer
    ResourceMacroList :=
        Nothing | <ResourceMacroTerm ResourceMacroList>
        ^^^^^^^

Thus a term such as "ResourceTemplate () {}" is legal and should not cause
an error to be returned.

The commit claims to revert Rafael's Linux commit 1315f01632da ("Revert
"ACPICA: Resources: Not a valid resource if buffer length too long"),
but in fact does something different.

Please fix at your earliest convenience.  The issue was discovered and
root-caused by Ronald Tschalär, please credit him in the fix, I'm merely
relaying the information:

Reported-by: Ronald Tschalär <ronald@innovation.ch>

Thanks,

Lukas
