From: Frans Pop <elendil@planet.nl>
Subject: Re: Syntax errors in SSDT1 table of HP 2510p laptop
Date: Tue, 30 Sep 2008 10:46:29 +0200
Message-ID: <200809301046.29849.elendil@planet.nl>
References: <200809251119.48907.elendil@planet.nl> <200809260652.21929.elendil@planet.nl> <4911F71203A09E4D9981D27F9D8308587672B3@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpo-eml04.kpnxchange.com ([213.75.38.153]:36679 "EHLO
	cpsmtpo-eml04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752161AbYI3Iqc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Sep 2008 04:46:32 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D8308587672B3@orsmsx503.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday 26 September 2008, Moore, Robert wrote:
> Most of the problems seen in the SSDT are related to the fact that the
> disassembler cannot always correctly disassemble code that contains
> calls to control methods that are external to the table. There is not
> enough information to disassemble correctly, and the table often needs
> to be repaired by hand.

Ah, that is interesting.

It still seems very suspicious to me that I'm seeing kernel errors at the 
exact point where the disassembly fails though.

I'm still hoping that someone from HP can take a look at this and check 
whether there is an issue with the BIOS or not.
