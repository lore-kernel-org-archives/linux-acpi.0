From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI_IBM_BAY can not coexist with ACPI_BAY
Date: Thu, 15 Mar 2007 12:04:02 -0300
Message-ID: <20070315150402.GA1048@khazad-dum.debian.net>
References: <20070315071019.GA22613@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34860 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422867AbXCOPEP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 11:04:15 -0400
Content-Disposition: inline
In-Reply-To: <20070315071019.GA22613@tuatara.stupidest.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, 15 Mar 2007, Chris Wedgwood wrote:
> ACPI_IBM_BAY cannot coexist with ACPI_BAY --- it causes the IBM ACPI
> code to fail to initialize so all the IBM ACPI functionality is
> missing.  The simplest fix is to just make sure the Kconfig magic
> disallows ACPI_IBM_BAY when ACPI_BAY is enabled.
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>

NAK.

I have looked into this issue, and I am working on a better fix to ibm-acpi
that allows it to coexist somewhat with ACPI_BAY (by disabling ibm-acpi bay
functionality at runtime if ACPI_BAY is loaded).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
