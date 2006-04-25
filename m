From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 25 Apr 2006 15:53:34 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18955 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751383AbWDYTxj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2006 15:53:39 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, ak@suse.de, kmurray@redhat.com, natalie.protasevich@unisys.com, linux-acpi@vger.kernel.org

I'd rather see the original irq-renaming patch
and its subsequent multiple via workaround patches
reverted than to further complicate what is becoming
a fragile mess.

-Len
