From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: iasl and SSDT disassembling limitations
Date: Fri, 24 Oct 2008 18:50:30 +0800
Message-ID: <1224845430.14280.58.camel@minggr.sh.intel.com>
References: <3515468CA27A0F49917112E2ECF61E210927CBF912@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49251 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbYJXKuq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Oct 2008 06:50:46 -0400
In-Reply-To: <3515468CA27A0F49917112E2ECF61E210927CBF912@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: hmh@hmh.eng.br, elendil@planet.nl

We have added a "-e" option to iasl that include tables for external
symbol resolution. See
http://git.acpica.org/repos/?p=acpica.git;a=commitdiff;h=2f705a1b06109e12bd2659d0e12215710a5622b7


Example: To disassemble an SSDT with external symbols defined in DSDT:

iasl -e dsdt.aml -d ssdt.aml

Lin Ming


> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Moore, Robert
> Sent: Saturday, September 27, 2008 12:49 AM
> To: Henrique de Moraes Holschuh
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: iasl and SSDT disassembling limitations
> 
> Yes, it should be possible, and it is on our list of things to look at.
> 
> A little more info on the problem: Without the definition of the control method, the disassembler has no way of knowing how many arguments should be passed to the method. Without this information, it does not know how many expressions to parse after the control method invocation in order to create the arguments. The information is simply not available. So it tries to guess.
> 
> Bob
> 
> 
> >-----Original Message-----
> >From: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]
> >Sent: Friday, September 26, 2008 9:09 AM
> >To: Moore, Robert
> >Cc: linux-acpi@vger.kernel.org
> >Subject: iasl and SSDT disassembling limitations
> >
> >On Fri, 26 Sep 2008, Moore, Robert wrote:
> >> Most of the problems seen in the SSDT are related to the fact that the
> >> disassembler cannot always correctly disassemble code that contains calls
> >> to control methods that are external to the table. There is not enough
> >> information to disassemble correctly, and the table often needs to be
> >> repaired by hand.
> >
> >Can iasl be improved to properly disassemble such tables if we give it ALL
> >tables to work with?
> >
> >--
> >  "One disk to rule them all, One disk to find them. One disk to bring
> >  them all and in the darkness grind them. In the Land of Redmond
> >  where the shadows lie." -- The Silicon Valley Tarot
> >  Henrique Holschuh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

