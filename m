From: Len Brown <lenb@kernel.org>
Subject: Re: inconsistency in /proc/acpi directory structure?
Date: Thu, 9 Aug 2007 12:02:54 -0400
Message-ID: <200708091202.54943.lenb@kernel.org>
References: <20070809123943.GD3939@ngolde.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39593 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936382AbXHIRWK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 13:22:10 -0400
In-Reply-To: <20070809123943.GD3939@ngolde.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nico Golde <nion@gmx.net>
Cc: linux-acpi@vger.kernel.org

Hi Nico,
I have to second what Henrique wrote.
Please avoid /proc/acpi/* whenever you can can.
We are trying to get rid of it completely,
but that is only partly done.

I really resist changes to /proc/acpi/* because
I consider it legacy and would rather the effort
be focused on the new sysfs interfaces.

cheers,
-Len
