From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] ibm-acpi changes acpi-test/2.6.22
Date: Sun, 11 Mar 2007 19:54:41 -0500
Message-ID: <200703112054.41560.lenb@kernel.org>
References: <11736588493609-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39808 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbXCLBCp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Mar 2007 21:02:45 -0400
In-Reply-To: <11736588493609-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sunday 11 March 2007 20:20, Henrique de Moraes Holschuh wrote:
> Len,
> 
> Please pull from:
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> branch for-upstream/acpi-test
> 
> to receive the following patches:
>       ACPI: ibm-acpi: kill trailing whitespace
>       ACPI: ibm-acpi: rename some identifiers
>       ACPI: ibm-acpi: add header file
>       ACPI: ibm-acpi: organize code
>       ACPI: ibm-acpi: update copyright notice
>       ACPI: ibm-acpi: update documentation
> 
> Please merge them into acpi-test, targetting 2.6.22.

series applied to acpi-test.

BTW. do you have a plan for moving this driver to drivers/misc?

thanks,
-Len
