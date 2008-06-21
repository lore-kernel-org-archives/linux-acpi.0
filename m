From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 25/70] ACPICA: Update disassembler for DMAR table changes
Date: Fri, 20 Jun 2008 22:56:15 -0700
Message-ID: <960B77DF2E6D974DBE24FD066EAEE8DAC2B16B@azsmsx422.amr.corp.intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org><ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com> <87hcbnanub.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13116 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbYFUF4R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jun 2008 01:56:17 -0400
Content-class: urn:content-classes:message
In-Reply-To: <87hcbnanub.fsf@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

>This patch does nothing? It just adds declarations and unused symbols

That's right.
this patch is from an upstream ACPICA patch --
but Linux doesn't use all of ACPICA's files.

The reason we apply these is to keep upstream ACPICA
and downstream Linux shared files as close as possible
because manging divergence is extremely labor intensive.

-Len
