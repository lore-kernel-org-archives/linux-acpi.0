From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: iasl and SSDT disassembling limitations
Date: Fri, 26 Sep 2008 13:08:41 -0300
Message-ID: <20080926160841.GB30729@khazad-dum.debian.net>
References: <200809251119.48907.elendil@planet.nl> <1222400642.4023.187.camel@yakui_zhao.sh.intel.com> <200809260652.21929.elendil@planet.nl> <4911F71203A09E4D9981D27F9D8308587672B3@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44985 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751707AbYIZQIq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 12:08:46 -0400
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D8308587672B3@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 26 Sep 2008, Moore, Robert wrote:
> Most of the problems seen in the SSDT are related to the fact that the
> disassembler cannot always correctly disassemble code that contains calls
> to control methods that are external to the table. There is not enough
> information to disassemble correctly, and the table often needs to be
> repaired by hand.

Can iasl be improved to properly disassemble such tables if we give it ALL
tables to work with?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
