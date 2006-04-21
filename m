From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: how to back from suspend without shutdown
Date: Fri, 21 Apr 2006 09:43:42 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD13783F5@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46768 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932128AbWDUBns convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2006 21:43:48 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, Nigel Cunningham <ncunningham@cyclades.com>
Cc: acpi devel <linux-acpi@vger.kernel.org>

>unload acpid (service acipd stop)  before suspend is more easy and
>works.

Hmm,  it is an easy and ugly workaround. I bet this kind of question
would be
raised again and again on this mailing list, if no code fix exists.

--Luming
