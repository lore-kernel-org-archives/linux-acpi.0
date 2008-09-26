From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: iasl and SSDT disassembling limitations
Date: Fri, 26 Sep 2008 09:48:36 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308587674AB@orsmsx503.amr.corp.intel.com>
References: <200809251119.48907.elendil@planet.nl>
 <1222400642.4023.187.camel@yakui_zhao.sh.intel.com>
 <200809260652.21929.elendil@planet.nl>
 <4911F71203A09E4D9981D27F9D8308587672B3@orsmsx503.amr.corp.intel.com>
 <20080926160841.GB30729@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18049 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511AbYIZQuK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 12:50:10 -0400
In-Reply-To: <20080926160841.GB30729@khazad-dum.debian.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Yes, it should be possible, and it is on our list of things to look at.

A little more info on the problem: Without the definition of the control method, the disassembler has no way of knowing how many arguments should be passed to the method. Without this information, it does not know how many expressions to parse after the control method invocation in order to create the arguments. The information is simply not available. So it tries to guess.

Bob


>-----Original Message-----
>From: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]
>Sent: Friday, September 26, 2008 9:09 AM
>To: Moore, Robert
>Cc: linux-acpi@vger.kernel.org
>Subject: iasl and SSDT disassembling limitations
>
>On Fri, 26 Sep 2008, Moore, Robert wrote:
>> Most of the problems seen in the SSDT are related to the fact that the
>> disassembler cannot always correctly disassemble code that contains calls
>> to control methods that are external to the table. There is not enough
>> information to disassemble correctly, and the table often needs to be
>> repaired by hand.
>
>Can iasl be improved to properly disassemble such tables if we give it ALL
>tables to work with?
>
>--
>  "One disk to rule them all, One disk to find them. One disk to bring
>  them all and in the darkness grind them. In the Land of Redmond
>  where the shadows lie." -- The Silicon Valley Tarot
>  Henrique Holschuh
