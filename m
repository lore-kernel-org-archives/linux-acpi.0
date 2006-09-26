From: Len Brown <len.brown@intel.com>
Subject: Re: [Patch 0/3] ibm-acpi: Remove experimental flag from brightness and volume. Update documentation
Date: Tue, 26 Sep 2006 17:27:16 -0400
Message-ID: <200609261727.17666.len.brown@intel.com>
References: <20060922101913.276298370@datenfreihafen.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32695 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964803AbWIZVZe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 17:25:34 -0400
In-Reply-To: <20060922101913.276298370@datenfreihafen.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: borislav@users.sourceforge.net, linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, jeremy@goop.org, multinymous@gmail.com, hmh@hmh.eng.br

I've applied 1-3.

Note, however, that the long-term direction is to make these features
available under generic sysfs interfaces, rather than  under /proc/acpi.

thanks,
-Len
