From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] ACPI: ibm-acpi: allow module to load when acpi notifiers can't be set
Date: Thu, 15 Mar 2007 12:17:21 -0700
Message-ID: <20070315191721.GB2556@tuatara.stupidest.org>
References: <20070315071019.GA22613@tuatara.stupidest.org> <20070315175113.GA6596@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:31775 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932810AbXCOTRX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 15:17:23 -0400
Content-Disposition: inline
In-Reply-To: <20070315175113.GA6596@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, kristen.c.accardi@intel.com

On Thu, Mar 15, 2007 at 02:51:14PM -0300, Henrique de Moraes Holschuh wrote:

> This patch allows for ibm-acpi to coexist (with diminished
> functionality) with other drivers like ACPI_BAY.

Given the ACP_IBM_BAY implementation is more complete (or seems to be,
please comment if that isn't the case) we should probably actually
make sure that is the *preferred* code used (on suitable hardware) at
run time surely?

That way distributions can build both options and on IBM/Lenovo
hardware it will use the IBM ACPI code and otherwise will use the
generic ACPI BAY code?

Perhaps the IBM_ACPI_BAY code should go away and any missing
functionality provided there should be merged into ACPI_BAY?
