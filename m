From: matthieu castet <castet.matthieu@free.fr>
Subject: acpi resource reservation
Date: Wed, 24 Sep 2008 19:36:03 +0000 (UTC)
Message-ID: <loom.20080924T193444-211@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36548 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbYIXTgV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Sep 2008 15:36:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kia9n-0005zJ-NM
	for linux-acpi@vger.kernel.org; Wed, 24 Sep 2008 19:36:16 +0000
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2008 19:36:15 +0000
Received: from castet.matthieu by cac94-1-81-57-151-96.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2008 19:36:15 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I wonder why acpi doesn't use request_region/request_mem_region on the resource
used by the interpreter. 

For example ioport resource are declared in dsdt with OperationRegion.

A good place to do that could be acpi_os_validate_address.

I believe by doing that acpi will avoid that other drivers try to use the same r
esource. And it will avoid the acpi_check_region hack that need to be added in e
ach driver instead of relying with the standard
request_region/request_mem_region mecanism.


Matthieu

