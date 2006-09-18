From: "Roger Lucas" <roger@planbit.co.uk>
Subject: RE: Kernel eats memory with LG-81  motherboard , acpi_operand possible culprit? RESOLVED
Date: Mon, 18 Sep 2006 12:11:08 +0100
Message-ID: <20060918111118.B972612EDE@bluewhale.planbit.co.uk>
References: <20060916164406.BB50512EDE@bluewhale.planbit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 82-71-36-240.dsl.in-addr.zen.co.uk ([82.71.36.240]:60290 "EHLO
	bluewhale.planbit.co.uk") by vger.kernel.org with ESMTP
	id S932163AbWIRLLU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Sep 2006 07:11:20 -0400
Received: from wolverine (unknown [192.168.1.127])
	by bluewhale.planbit.co.uk (Postfix) with ESMTP id B972612EDE
	for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2006 12:11:18 +0100 (BST)
In-Reply-To: <20060916164406.BB50512EDE@bluewhale.planbit.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

RESOLVED - http://bugzilla.kernel.org/show_bug.cgi?id=7163

There was a code construct in the DSDT BIOS code that exposed a memory leak
in the ACPI kernel module.  The leak is patched in 2.6.18.rc1 onwards and it
was possible to rewrite the DSDT code such that the memory leak condition
was avoided on the unpatched 2.6.16 and 2.6.17 kernels.

"Thank You" to Fiodor and Alexey for helping resolve this so quickly.

- Roger

