From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/2] ACPICA: add postorder namespace walk
Date: Fri, 31 Jul 2009 12:17:18 -0600
Message-ID: <200907311217.18761.bjorn.helgaas@hp.com>
References: <20090717172248.24968.31911.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:41459 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZGaSRU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 14:17:20 -0400
In-Reply-To: <20090717172248.24968.31911.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Friday 17 July 2009 11:27:16 am Bjorn Helgaas wrote:
> AcpiWalkNamespace() only supports preorder traversal of the namespace.  
> This visits a node before any of its children, so it works well for
> adding new devices.  However, when removing devices, we need a postorder
> traversal so we can remove children before the parents.
> 
> These patches add a new AcpiWalkNamespace2() interface that takes two
> callback arguments: one for preorder traversal and another for postorder.
> These patches don't change the behavior of AcpiWalkNamespace().
> 
> Note that the existing preorder AcpiWalkNamespace() never actually visits
> the starting node.  Therefore, we skip it in postorder also.

Hi Bob,

Any feedback on these patches, or on the question of whether
AcpiWalkNamespace() should visit the starting node?  (I expect
that the starting node question will be most easily resolved
by a documentation update.)

Bjorn


