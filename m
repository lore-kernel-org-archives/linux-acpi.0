From: Bjorn Helgaas <helgaas@kernel.org>
Subject: GHES platform devices
Date: Wed, 16 Nov 2016 15:36:25 -0600
Message-ID: <20161116213625.GA10368@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932263AbcKPVg3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Nov 2016 16:36:29 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Huang,

7ad6e9435596 ("ACPI, APEI, Manage GHES as platform devices") added
platform devices so the GHES driver could be built as a module and
automatically loaded when needed.

Later, 86cd47334b00 ("ACPI, APEI, GHES, Prevent GHES to be built as
module") removed the ability to build GHES as a module.

Should we revert 7ad6e9435596?  It's inconsistent to handle GHES, but
not other error sources, as a platform device.  And having it as a
platform device probably puts gunk in sysfs that we don't need.

Bjorn
